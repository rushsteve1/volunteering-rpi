<?php

// User types from PSR-7
use DI\Container;
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use Slim\Factory\AppFactory;
require_once '../vendor/jasig/phpcas/source/CAS.php';
require_once "./queries.php";

// Require the Composer autoload file to load the dependencies
require __DIR__ . '/../vendor/autoload.php';

// Once the connection options use a config file (or while testing)
// you can uncomment this
// require __DIR__ . '/queries.php';

// Define constants as part of the application
// These can possibly be replaced by a config file
define('TEMPLATE_DIR', 'templates/');
define('CACHE_DIR', '../cache/');

// Create the DI container
$container = new Container();

// Set as the active container
AppFactory::setContainer($container);

// Create app
$app = AppFactory::create();

// Setup the middleware
$app->addRoutingMiddleware();
$app->addErrorMiddleware(true, true, true); // Must go last

// Register twig-view component on container
// This sets up the templating engine so that we can use it later
$container->set('view', function () {
   $prod = getenv("VOLRPI_PROD") != FALSE;
   return new \Slim\Views\Twig(TEMPLATE_DIR, [
      'cache' => $prod ? CACHE_DIR : false
   ]);
});

$container->set('notFoundHandler', function($ctx) {
  return function(Request $request, Response $response) use ($ctx) {
    return $this->get('view')->render($response->withStatus(404), '404.html');
  };
});

// CAS Connection information
phpCAS::client(CAS_VERSION_2_0, 'cas-auth.rpi.edu/cas', 443, '');
// phpCAS::setCasServerCACert($cas_server_ca_cert_path);
phpCAS::setNoCasServerValidation();

// Return username if logged in, empty string otherwise
function getUsername(){
  $username = '';
  if(phpCAS::isAuthenticated()){
    $username = phpCAS::getUser();
  }
  return strtolower($username);
}

// The handler for the main index page
$app->get('/', function (Request $request, Response $response, array $args) {
   return $this->get('view')->render($response, 'index.html',
   [
      'username' => getUsername(),
      "events" => select_events()
   ]);
})->setName('index');

// The handler for the organizations page
$app->get('/organizations', function (Request $request, Response $response, array $args) {
   return $this->get('view')->render($response, 'organizations.html', 
   [
      'username' => getUsername(), 
      'organizations' => array_map(function($e) { $e['pres'] = select_user_by_rcsid($e[4]); return $e; }, select_orgs()),
   ]);
})->setName('organizations');

// The handler for the leaderboard page
$app->get('/leaderboard', function (Request $request, Response $response, array $args) {
   return $this->get('view')->render($response, 'leaderboard.html',
   [
      'username' => getUsername(),
      "users" => select_leaderboard()
   ]);
})->setName('leaderboard');

// Login functionality
$app->get('/login', function (Request $request, Response $response, array $args) {
   phpCAS::forceAuthentication();
   $username = getUsername();
   if (!select_user_by_rcsid($username)) {
     insert_user($username, $username, $username);
   }
   return $response->withHeader('Location', '/')->withStatus(301);
})->setName('login');

// Logout functionality
$app->get('/logout', function (Request $request, Response $response, array $args) {
   phpCAS::logout();
})->setName('logout');

// The handler for the user page
$app->get('/user/{user}', function (Request $request, Response $response, array $args) {
   return $this->get('view')->render($response, 'user.html',
   [
      'username' => getUsername(),
      'user' => $args['user'],
      'userData' => select_user_by_rcsid($args['user'])
   ]);
})->setName('user');

// The handler for the org page
$app->get('/org/{orgid}', function (Request $request, Response $response, array $args) {
   $orgData = select_org_by_id($args['orgid']);
   return $this->get('view')->render($response, 'org.html',
   [
      'username' => getUsername(),
      'orgid' => $args['orgid'],
      'orgData' => $orgData,
      'events' => select_events_by_org($args['orgid']),
      'pres' => select_user_by_rcsid($orgData['adminID'])
   ]);
})->setName('org');

// The handler for the event page
$app->get('/event/{eventid}', function (Request $request, Response $response, array $args) {
   $eventData = select_event_by_id($args['eventid']);
   return $this->get('view')->render($response, 'event.html',
   [
      'username' => getUsername(),
      'eventid' => $args['eventid'],
      'eventData' => $eventData,
      'orgData' => select_org_by_id($eventData["id"])
   ]);
})->setName('event');

// The handler for the event creation page
$app->get('/create-event', function (Request $request, Response $response, array $args) {
   return $this->get('view')->render($response, 'create-event.html',
   [
      'username' => getUsername(),
      'orgData' => select_orgs()
   ]);
})->setName('event');

// The handler for the event submission
$app->post('/create-event', function (Request $request, Response $response, array $args) {
   $data = $request->getParsedBody();
   insert_event($data["name"], $data["org"], $data["description"], $data["location"], $data["occupancy"], $data["duration"], $data["date"]);
   return $response->withHeader('Location', '/')->withStatus(301);
})->setName('event');

// The handler for the org creation page
$app->get('/create-org', function (Request $request, Response $response, array $args) {
   return $this->get('view')->render($response, 'create-org.html',
   [
      'username' => getUsername()
   ]);
})->setName('org');

// The handler for the org submission
$app->post('/create-org', function (Request $request, Response $response, array $args) {
   $data = $request->getParsedBody();
   insert_org($data["name"], $data["description"], $data["website"], getUsername(), $data["image"]);
   return $response->withHeader('Location', '/organizations' )->withStatus(301);
})->setName('org');


// Run the application
$app->run();

?>
