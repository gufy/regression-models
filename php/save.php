<?php

require_once(__DIR__.'/dibi.min.php');

date_default_timezone_set('Europe/Prague');

parse_str(implode('&', array_slice($argv, 1)), $params);

define('__DBHOST__', 'mathiotic.com');
define('__DBUSER__', 'c3_mathiotic');
define('__DBBASE__', 'c3_mathiotic');
define('__DBPASS__', 'H7xCh2pqk');

dibi::connect(array(
	'driver'   => 'mysql',
	'host'     => __DBHOST__,
	'username' => __DBUSER__,
	'password' => __DBPASS__,
	'database' => __DBBASE__,
	'charset'  => 'utf8',
));

dibi::query('insert into regressions', $params);


