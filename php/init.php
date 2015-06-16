<?php

require_once(__DIR__.'/dibi.min.php');

date_default_timezone_set('Europe/Prague');

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


function responseCSV($array, $delimiter = ';', $return) {
    if (count($array) > 0) {
        $headings = array();
        foreach ($array[0] as $k => $v) {
            $headings[] = $k;
        }

        // Open the output stream
        $fh = fopen('php://output', 'w');

        // Start output buffering (to capture stream contents)
        ob_start();

        fputcsv($fh, $headings, $delimiter);

        // Loop over the * to export
        if (! empty($array)) {
            foreach ($array as $item) {
                fputcsv($fh, array_values((array)$item), $delimiter);
            }
        }

        // Get the contents of the output buffer
        $string = ob_get_clean();

        if ($return) {

            return $string;

        } else {

            $filename = 'csv_' . date('Ymd') .'_' . date('His');

            // Output CSV-specific headers

            header("Pragma: public");
            header("Expires: 0");
            header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
            header("Cache-Control: private",false);
            header("Content-Type: application/octet-stream");
            header("Content-Disposition: attachment; filename=$filename.csv" );
            header("Content-Transfer-Encoding: binary");

            exit($string);
        }

    }

    exit;
}