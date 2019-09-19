<?php

// User types from PSR-7
use DI\Container;
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use Slim\Factory\AppFactory;

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
        'cache' => CACHE_DIR
    ]);
});

// The handler for the main index page
$app->get('/', function (Request $request, Response $response, array $args) {
   return $this->get('view')->render($response, 'index.html', []);
})->setName('index');

// Run the application
$app->run();

?>
