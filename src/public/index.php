<?php

// User types from PSR-7
use DI\Container;
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use Slim\Factory\AppFactory;

$prod = getenv("VOLRPI_PROD") != FALSE;

// Require the Composer autoload file to load the dependencies
require __DIR__ . '/../../vendor/autoload.php';

// Define constants as part of the application
// These can possibly be replaced by a config file
define('TEMPLATE_DIR', '../templates/');
define('CACHE_DIR', '../../cache/');

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
    return new \Slim\Views\Twig(TEMPLATE_DIR, [
        'cache' => $prod ? CACHE_DIR : false
    ]);
});

// The handler for the main index page
$app->get('/', function (Request $request, Response $response, array $args) {
   return $this->get('view')->render($response, 'index.html', []);
})->setName('index');

// The handler for the events page
$app->get('/events', function (Request $request, Response $response, array $args) {
   return $this->get('view')->render($response, 'events.html', []);
})->setName('events');

// The handler for the organizations page
$app->get('/organizations', function (Request $request, Response $response, array $args) {
   return $this->get('view')->render($response, 'organizations.html', []);
})->setName('organizations');

// The handler for the leaderboard page
$app->get('/leaderboard', function (Request $request, Response $response, array $args) {
   return $this->get('view')->render($response, 'leaderboard.html', []);
})->setName('leaderboard');

// Run the application
$app->run();

?>
