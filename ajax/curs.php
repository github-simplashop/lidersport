<?php
	chdir('..');
	require_once('api/Simpla.php');
	$simpla = new Simpla();

	$url = "http://www.cbr.ru/scripts/XML_daily.asp"; // URL, XML документ, всегда содержит актуальные данные
	$curs = array(); // массив с данными
	 
	// функция полчуния даты из спарсенного XML
	function get_timestamp($date)
	 {
		 list($d, $m, $y) = explode('.', $date);
		 return mktime(0, 0, 0, $m, $d, $y);
	 }
	 
	 
	if(!$xml=simplexml_load_file($url)) die('Ошибка загрузки XML'); // загружаем полученный документ в дерево XML
	$curs['date']=get_timestamp($xml->attributes()->Date); // получаем текущую дату
	 
	foreach($xml->Valute as $m){ // перебор всех значений
	   // для примера будем получать значения курсов лишь для двух валют USD и EUR
	   if($m->CharCode=="USD" || $m->CharCode=="EUR"){
		$curs[(string)$m->CharCode]=(float)str_replace(",", ".", (string)$m->Value); // запись значений в массив
	   }
	  } 
 	
	$simpla->db->query('UPDATE __settings SET value=? WHERE name=?', $curs["USD"], "usd");
	$simpla->db->query('UPDATE __settings SET value=? WHERE name=?', $curs["EUR"], "eur");
	print_r($curs);

?>