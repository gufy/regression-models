<?php

require_once(__DIR__.'/init.php');
require_once(__DIR__.'/header.php');

$methods = dibi::query('SELECT DISTINCT method FROM regressions ORDER BY method')->fetchAll();
$datasets = dibi::query('SELECT DISTINCT dataset FROM regressions ORDER BY dataset')->fetchAll();

$data = dibi::query('SELECT * FROM regressions ORDER BY error_test_mean');
$results = [];

foreach ($methods as $method) {
    $results[$method->method] = [];

    foreach ($datasets as $dataset) {
        $results[$method->method][$dataset->dataset] = [];
    }
}

?>
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <ul class="nav navbar-nav">
<?php

foreach ($methods as $method):  ?>
      <li role="presentation"><a href="#<?php echo $method->method; ?>"><?php echo $method->method; ?></a></li>

    
<?php endforeach;

?>
        </ul>
        <form class="nav navbar-form navbar-right">
            <a class="btn btn-success" href="./csv.php">Download CSV</a>
        </form>
    </div>
</nav><?php

foreach ($data as $item) {
    $results[$item->method][$item->dataset][] = $item;
}

foreach ($methods as $m) {

    if (isset($_GET['m']) && !in_array(strtolower($m->method),explode(',',strtolower($_GET['m'])))) continue;

    $method = $m->method;
    echo "<hr id=\"{$method}\" />";
    echo "<h2>{$method}</h2>\n"; 

    foreach ($datasets as $d) {

        $dataset = $d->dataset;

        if (isset($_GET['dim']) && strpos($dataset, $_GET['dim']) === false) continue;  
        if (isset($_GET['fun']) && strpos($dataset, $_GET['fun']) === false) continue;  
        if (isset($_GET['d']) && !in_array(strtolower($dataset),explode(',',strtolower($_GET['d'])))) continue;
    
        echo "<h3>{$dataset}</h3>\n";

        if (isset($results[$method][$dataset]) && count($results[$method][$dataset]) > 0) {
            $result = $results[$method][$dataset];

?><table class="table">
    <thead>
        <tr>
            <th>Parameters</th>
            <th>Test error</th>
            <th>Train error</th>
            <th>Kendall</th>
            <th>Time (m)</th>
            <th>Computed at</th>
        </tr>
    </thead>
    <tbody>
<?php foreach ($result as $row): 
            $date = new DateTime();
            $date->sub(new DateInterval('P1D'));

            $highlighted = $row->datetime_inserted > $date;
            $t = 2.2622;
?>
            <tr class="<?php echo $highlighted ? 'success': ''; ?>">
                <td><?php echo $row->parameters; ?></td>
                <td><?php echo $row->error_test_mean; ?> (&plusmn;<?php echo round($t*$row->error_test_sigma, 5); ?>)</td>
                <td><?php echo $row->error_train_mean; ?> (&plusmn;<?php echo round($t*$row->error_train_sigma, 5); ?>)</td>
                <td><?php echo $row->kendall_mean; ?> (&plusmn;<?php echo round($t*$row->kendall_sigma, 5); ?>)</td>
                <td><?php echo round($row->time / 6) / 10; ?></td>
                <td><?php echo $row->datetime_inserted; ?></td>
            </tr>
<?php endforeach; ?>    
    </tbody>
</table><?php

        }

    }

}

require_once(__DIR__.'/footer.php');