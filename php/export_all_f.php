<?php

require_once(dirname(__FILE__).'/init.php');

$path = dirname(__FILE__).'/../thesis/csv';


for ($i = 15; $i <= 24; $i++) {
	$f = $i;
	$query = "
		SELECT 	CONVERT(REPLACE(REPLACE(r1.dataset, 'd-5000', ''), 'f$f-', ''), UNSIGNED INTEGER) as dim,
			r1.method, r1.error_test_mean, r1.error_test_sigma, r1.error_train_mean, r1.error_train_sigma, r1.kendall_mean, r1.kendall_sigma, r1.time
		FROM regressions AS r1
		INNER JOIN
		( 
			SELECT dataset, method, MIN(error_test_mean) AS error_test_mean FROM regressions GROUP BY dataset, method 
		) AS r2
		ON r2.dataset = r1.dataset AND r2.method = r1.method AND r2.error_test_mean = r1.error_test_mean
		WHERE r1.dataset LIKE 'f$f-%' 
		GROUP BY r1.dataset, r1.method
		ORDER BY dim, r1.method
"; 

	$data = dibi::query($query)->fetchAll();

	file_put_contents($path.'/f'.$f.'.csv', responseCSV($data, ',', true));

}