<?php

require_once(__DIR__.'/init.php');

parse_str(implode('&', array_slice($argv, 1)), $params);

dibi::query('insert into regressions', $params);


