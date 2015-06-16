<?php

require_once(__DIR__.'/init.php');

$fields = [
  'id' => 'ID',
  'dataset' => 'Dataset',
  'method' => 'Method',
  'parameters' => 'Parameters',
  'error_train_mean' => 'Train error (mean)',
  'error_train_sigma' => 'Train error (ssq)',
  'error_test_mean' => 'Test error (mean)',
  'error_test_sigma' => 'Test error (sigma)',
  'kendall_mean' => 'Kendall (mean)',
  'kendall_sigma' => 'Kendall (sigma)',
  'time' => 'Comp. time (s)',
  'datetime_inserted' => 'Time added'
 ];

$data = [];

foreach (dibi::query('SELECT * FROM regressions')->fetchAll() as $item) {
	$item = (array)$item;
	$el = [];

	foreach ($item as $k => $v) {
		$el[$fields[$k]] = $v;
	}	

	$data[] = $el;
}

responseCSV($data);