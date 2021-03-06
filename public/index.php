<?php
$origin = isset($_SERVER['HTTP_ORIGIN']) ? $_SERVER['HTTP_ORIGIN'] : 'http://nginx.clover.com';
$corsConfigs['method'] = 'GET,POST,OPTIONS';
$corsConfigs['credential'] = 'true';
header('Access-Control-Allow-Origin:' . $origin);
header('Access-Control-Allow-Methods:' . $corsConfigs['method']);
header('Access-Control-Allow-Credentials:' . $corsConfigs['credential']);

// Define path to application directory
defined('APPLICATION_PATH')
    || define('APPLICATION_PATH', realpath(dirname(__FILE__) . '/../application'));

// Define application environment
defined('APPLICATION_ENV')
    || define('APPLICATION_ENV', (getenv('APPLICATION_ENV') ? getenv('APPLICATION_ENV') : 'production'));

// Ensure library/ is on include_path
set_include_path(implode(PATH_SEPARATOR, array(
    realpath(APPLICATION_PATH . '/../library'),
    realpath(APPLICATION_PATH . '/../include'),
    get_include_path(),
)));

/** Zend_Application */
require_once 'Zend/Application.php';

// Create application, bootstrap, and run
$application = new Zend_Application(
    APPLICATION_ENV,
    APPLICATION_PATH . '/configs/application.ini'
);
try {
    $application->getAutoloader()->setFallbackAutoloader(true);
    $application->bootstrap()
                ->run();
}
catch(Exception $e) {
    echo $e->getMessage();
}