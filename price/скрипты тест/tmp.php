<?php

chdir('../');
include('api/Simpla.php');

setlocale(LC_ALL, "ru_RU.UTF-8");


	$simpla = new Simpla();

	$name = 'Гантели';
	$simpla->db->query('SELECT id FROM __categories WHERE name=? ', $name);
    $results = $simpla->db->results();
    foreach($results as $val)
    {
    	echo $val->id."<br />";
    }

?>