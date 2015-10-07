<?php

require_once(dirname(__FILE__).'/init.php');

parse_str(implode('&', array_slice($argv, 1)), $_GET);

$noisy = 0;
if (isset($_GET['noisy']) && $_GET['noisy'] == 1) {
	$noisy = 1;
}

$rename = array(
	'GP' => 'GP',
	'RBF-NN' => 'RBF',
	'SVM' => 'SVM',
	'Polynomial' => 'Poly',
	'Forests' => 'RF' 
);

function get_mse_results($noisy, $rename) {

	$output = array();
	$result = dibi::query("SELECT DISTINCT
		r1.dim, r1.dataset, r1.method, r2.error_test_mean as err, r2.error_test_sigma as err_sigma
	FROM (
		SELECT 
			r.dataset_full, r.dataset, r.dim, r.method,
			MIN(r.error_test_mean) as error_test_mean_min
		FROM (
			SELECT 
				dataset as dataset_full,
				REPLACE(REPLACE(dataset, '5d', '05d'), '-5000', '') as dataset,
				SUBSTRING(REPLACE(REPLACE(dataset, '5d', '05d'), '-5000', ''), 5) as dim,
				REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(method, 'GP (SEiso)', 'GP'), 'GP (SEard)', 'GP'), 'GP (RQiso)', 'GP'), 'SVM (nu-SVR, rbf)', 'SVM'), 'SVM (epsilon-SVR, rbf)', 'SVM') as method,
				error_test_mean
			FROM regressions
			WHERE noisy = %i
		) AS r
		GROUP BY dataset, method
	) as r1
	LEFT JOIN regressions as r2
	ON (r1.error_test_mean_min = r2.error_test_mean AND r1.dataset_full = r2.dataset)
	GROUP BY dataset, method
	ORDER BY dataset, error_test_mean", $noisy)->fetchAll();

	$methods = array();
	foreach ($result as $row) {
		if (!isset($methods[$row->dataset])) { $methods[$row->dataset] = array(); }

		$methods[$row->dataset][$row->method] = $row;
	}

	unset($methods['STYAcOH-0d-0']);
	unset($methods['STYC2H4-0d-0']);


	// ourperforms

	$outperforms = array();
	$funs = array();
	$data = array();
	$dataSig = array();

	foreach ($result as $row) {
		if (in_array($row->dataset, array('STYAcOH-0d-0', 'STYC2H4-0d-0'))) continue;

		if (!isset($data[$row->dim])) { $data[$row->dim] = array(); }
		if (!isset($data[$row->dim][$row->method])) { $data[$row->dim][$row->method] = array(); }

		if (!isset($dataSig[$row->dim])) { $dataSig[$row->dim] = array(); }
		if (!isset($dataSig[$row->dim][$row->method])) { $dataSig[$row->dim][$row->method] = array(); }

		$numOutperforms = 0;
		foreach (array('GP', 'RBF-NN', 'Forests', 'SVM', 'Polynomial') as $m) {
			if (!isset($data[$row->dim][$row->method][$m])) { $data[$row->dim][$row->method][$m] = 0; }
			if (!isset($dataSig[$row->dim][$row->method][$m])) { $dataSig[$row->dim][$row->method][$m] = 0; }

			
			if ($row->err < $methods[$row->dataset][$m]->err) {

				$data[$row->dim][$row->method][$m]++;
				
				$m_i = $row->err;
				$m_j = $methods[$row->dataset][$m]->err;

				$s_i = $row->err_sigma;
				$s_j = $methods[$row->dataset][$m]->err_sigma;

				$k = 10;
				$s2 = $s_i * $s_i + $s_j * $s_j;
				$t = ($m_j - $m_i) / sqrt($s2 /$k);

				$t_0975_18 = 2.100922040241036;

				//echo $t . " vs " . $t_0975_18 . "\n";
				if ($t > $t_0975_18) {
					// zamitame hypotezu o shodnem prumeru => signifikantni rozdil
					$dataSig[$row->dim][$row->method][$m]++;
				} else {

				}
			} 
		}

	}

	foreach ($data as $key => $dim) {
		//echo "\n\n%";
		//echo $key . "\n";
		foreach (array('GP', 'RBF-NN', 'Forests', 'SVM', 'Polynomial') as $m1) {

			if (!isset($data[$key][$m1])) continue;

			$method = $data[$key][$m1];
			//echo "%" . $m1 . ": ";

			$line = " & {$rename[$m1]} ";

			foreach (array('GP', 'RBF-NN', 'Forests', 'SVM', 'Polynomial') as $m2) {
				$r = $method[$m2];
				$rs = $dataSig[$key][$m1][$m2];
				//echo $r . " ($rs), ";
				if ($m2 == $m1) {
					$line .= "& $\\times$ ";
				} else {
					$line .= "& " . $r . " ($rs) ";
				}
			}

			$line .= "";
			$output[] = $line;
		
		}
	}

	//echo "\n\n\n%Summary\n\n";

	foreach (array('GP', 'RBF-NN', 'Forests', 'SVM', 'Polynomial') as $m1) {

		//echo "%" . $m1 . ": ";
		$line = " & {$rename[$m1]} ";

		foreach (array('GP', 'RBF-NN', 'Forests', 'SVM', 'Polynomial') as $m2) {

			$r = 0; $rs = 0;

			foreach ($data as $key => $dim) {
				$r += $data[$key][$m1][$m2];
				$rs += $dataSig[$key][$m1][$m2];
			}

			if ($m2 == $m1) {
					$line .= "& $\\times$ ";
				} else {
					$line .= "& " . $r . " ($rs) ";
				}
		}

		$line .= "";
		$output[] = $line;

	}

	return $output;

}

function get_kendall_results($noisy, $rename) {

	$output = array();
	$result = dibi::query("SELECT DISTINCT
			r1.dim, r1.dataset, r1.method, r2.kendall_mean as kendall, r2.kendall_sigma * sqrt(10) as kendall_sigma
		FROM (
		SELECT 
			r.dataset_full, r.dataset, r.dim, r.method,
			MAX(r.kendall_mean) as kendall_max
		FROM (
			SELECT 
				dataset as dataset_full,
				REPLACE(REPLACE(dataset, '5d', '05d'), '-5000', '') as dataset,
				SUBSTRING(REPLACE(REPLACE(dataset, '5d', '05d'), '-5000', ''), 5) as dim,
				REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(method, 'GP (SEiso)', 'GP'), 'GP (SEard)', 'GP'), 'GP (RQiso)', 'GP'), 'SVM (nu-SVR, rbf)', 'SVM'), 'SVM (epsilon-SVR, rbf)', 'SVM') as method,
				kendall_mean
			FROM regressions
			WHERE noisy = %i
		) AS r
		GROUP BY dataset, method
		) as r1
		LEFT JOIN regressions as r2
		ON (r1.kendall_max = r2.kendall_mean AND r1.dataset_full = r2.dataset)
		GROUP BY r1.dim, r1.dataset, r1.method, r2.kendall_mean
		ORDER BY dim, dataset, kendall_mean", $noisy)->fetchAll();

	$methods = array();
	foreach ($result as $row) {
		if (!isset($methods[$row->dataset])) { $methods[$row->dataset] = array(); }

		$methods[$row->dataset][$row->method] = $row;
	}

	unset($methods['STYAcOH-0d-0']);
	unset($methods['STYC2H4-0d-0']);

	// ourperforms

	$outperforms = array();
	$funs = array();
	$data = array();
	$dataSig = array();

	foreach ($result as $row) {
		if (in_array($row->dataset, array('STYAcOH-0d-0', 'STYC2H4-0d-0'))) continue;
	//var_dump($row);

		if (!isset($data[$row->dim])) { $data[$row->dim] = array(); }
		if (!isset($data[$row->dim][$row->method])) { $data[$row->dim][$row->method] = array(); }

		if (!isset($dataSig[$row->dim])) { $dataSig[$row->dim] = array(); }
		if (!isset($dataSig[$row->dim][$row->method])) { $dataSig[$row->dim][$row->method] = array(); }

		$numOutperforms = 0;
		foreach (array('GP', 'RBF-NN', 'Forests', 'SVM', 'Polynomial') as $m) {
			if (!isset($data[$row->dim][$row->method][$m])) { $data[$row->dim][$row->method][$m] = 0; }
			if (!isset($dataSig[$row->dim][$row->method][$m])) { $dataSig[$row->dim][$row->method][$m] = 0; }

			
			if ($row->kendall > $methods[$row->dataset][$m]->kendall) {
				$data[$row->dim][$row->method][$m]++;
				
				$m_i = $row->kendall;
				$m_j = $methods[$row->dataset][$m]->kendall;

				$s_i = $row->kendall_sigma;
				$s_j = $methods[$row->dataset][$m]->kendall_sigma;

				$k = 10;
				$s2 = $s_i * $s_i + $s_j * $s_j;
				$t = ($m_i - $m_j) / sqrt($s2 /$k);

				$t_0975_18 = 2.100922040241036;

				//echo $t . " vs " . $t_0975_18 . "\n";
				if ($t > $t_0975_18) {
					// zamitame hypotezu o shodnem prumeru => signifikantni rozdil
					$dataSig[$row->dim][$row->method][$m]++;
				} else {

				}
			} 
		}

	}



	foreach ($data as $key => $dim) {

		//echo "\n\n%";
		//echo $key . "\n";
		foreach (array('GP', 'RBF-NN', 'Forests', 'SVM', 'Polynomial') as $m1) {

			if (!isset($data[$key][$m1])) continue;

			$method = $data[$key][$m1];
			//echo "%" . $m1 . ": ";

			$line = "\t";

			foreach (array('GP', 'RBF-NN', 'Forests', 'SVM', 'Polynomial') as $m2) {
				$r = $method[$m2];
				$rs = $dataSig[$key][$m1][$m2];
				//echo $r . " ($rs), ";
				if ($m2 == $m1) {
					$line .= "& $\\times$ ";
				} else {
					$line .= "& " . $r . " ($rs) ";
				}
			}

			$line .= " \\\\";
			$output[] = $line;
		
		}
	}

	//echo "\n\n\n%Summary\n\n";

	foreach (array('GP', 'RBF-NN', 'Forests', 'SVM', 'Polynomial') as $m1) {

		//echo "%" . $m1 . ": ";
		$line = "\t";

		foreach (array('GP', 'RBF-NN', 'Forests', 'SVM', 'Polynomial') as $m2) {

			$r = 0; $rs = 0;

			foreach ($data as $key => $dim) {
				$r += $data[$key][$m1][$m2];
				$rs += $dataSig[$key][$m1][$m2];
			}

			if ($m2 == $m1) {
					$line .= "& $\\times$ ";
				} else {
					$line .= "& " . $r . " ($rs) ";
				}
		}

		$line .= " \\\\";
		$output[] = $line;

	}

	return $output;
}

$res1 = get_mse_results($noisy, $rename);
$res2 = get_kendall_results($noisy, $rename);
echo "\n\n";

for ($i = 0; $i < count($res1); $i++) {
	echo $res1[$i]."\n";
	echo $res2[$i]."\n";
}

echo "\n\n";




