<?php

	error_reporting(E_ALL);
    //ini_set('max_execution_time', 60);
    //ini_set('display_errors', 1);
    //print_r(ini_get('max_execution_time'));
    //die;
        // Засекаем время
	$time_start = microtime(true);
	session_start();
        //Save referer or UTM data;
        $utm = array();
        if(is_array($_GET) and count($_GET) > 0){
          foreach($_GET AS $n=>$value){
              if(is_array($value)) continue;
              if(!substr_count(strval($n), 'utm')) continue;
                $utm[$n] = htmlspecialchars(trim($value));

              
          }
        }
        if(count($utm) > 0 and !isset($_SESSION['utm_data'])){
               $_SESSION['utm_data'] = $utm;
        } 
        echo "<!--".print_r($_SESSION['utm_data'], true)."-->";

        if(isset($_SERVER['HTTP_REFERER'])){
               if(is_string($_SERVER['HTTP_REFERER']) and !substr_count($_SERVER['HTTP_REFERER'], 'https://lidsport.ru')){
                        $referer = htmlspecialchars(trim($_SERVER['HTTP_REFERER']));
                        $_SESSION['y_referer'] = $referer;
               }
        }

        //echo "<!--".print_r($_SESSION, true)."-->";
        
	require_once('view/IndexView.php');
	$view = new IndexView();
	
	// Если все хорошо
	if(($res = $view->fetch()) !== false)
	{
		// Выводим результат
		header("Content-type: text/html; charset=UTF-8");	
		print $res;

		if(empty($_SESSION['last_visited_page'])
		|| empty($_SESSION['current_page'])
		|| $_SERVER['REQUEST_URI'] !== $_SESSION['current_page'])
		{
			if(!empty($_SESSION['current_page'])
			&& $_SESSION['last_visited_page'] !== $_SESSION['current_page'])
			{
				$_SESSION['last_visited_page'] = $_SESSION['current_page'];
			}
			$_SESSION['current_page'] = $_SERVER['REQUEST_URI'];
		}		
	}
	else 
	{
		// Иначе страница об ошибке
		header("http/1.0 404 not found");
		
		// Подменим переменную GET, чтобы вывести страницу 404
		$_GET['page_url'] = '404';
		$_GET['module'] = 'PageView';
		print $view->fetch();   
	}


// Отладочная информация
if(1)
{
	print "<!--\r\n";
	$time_end = microtime(true);
	$exec_time = $time_end-$time_start;
  
  	if(function_exists('memory_get_peak_usage'))
	{
		print "memory peak usage: ".memory_get_peak_usage()." bytes\r\n";
	}
	print "page generation time: ".$exec_time." seconds\r\n";  
	print "-->";
}
