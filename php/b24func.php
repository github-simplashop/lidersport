<?php
      header("Content-Type:text/html; charset=utf-8");

      $res = "https://lidsportmarketing.bitrix24.ru/rest/1/r93jlym6i1gogirw/";

      function post($url, $post){
            $array = array(
                CURLOPT_URL => $url,
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_SSL_VERIFYPEER  => false,
                CURLOPT_SSL_VERIFYHOST  => false
            );
            if($post){
                 $array[CURLOPT_POST] = true;
                 $array[CURLOPT_POSTFIELDS] = $post;
            }
            if(!$curl = curl_init()) return false;
            foreach($array AS $opt=>$value){
            	 curl_setopt($curl,$opt,$value);
            }
            $errno = curl_errno($curl);
            return ($errno>0) ? false : curl_exec($curl);
      }

     function addContact($fio, $phone, $source = 'SELF'){
     	global $res;
     	   $p = array();
           $param = array('NAME' => $fio,'SECOND_NAME' => '','LAST_NAME' => '', 'OPENED' => 'Y', 'ASSIGNED_BY_ID' => 1, 'TYPE_ID' => 'CLIENT', 'SOURCE_ID' => $source,'PHONE' => array('VALUE' => $phone, 'VALUE_TYPE' => 'WORK'));
            foreach($param AS $name => $value){
                 $p["FIELDS[$name]"] =$value;
            }

           $param = http_build_query($p)."&FIELDS[PHONE][VALUE]=$phone&&FIELDS[PHONE][VALUE_TYPE]=WORK";
            

           $url = $res."crm.contact.add.json";
           $response = json_decode(post($url,$param));
           return $response->result;
     }
     function addDeal($id, $title, $current, $summe){
     	  global $res;
     	  $p = "fields[TITLE]=$title&fields[TYPE_ID]=GOODS&fields[CONTACT_ID]=$id&fields[OPENED]=Y&fields[ASSIGNED_BY_ID]=1&fields[CURRENCY_ID]=$current&fields[OPPORTUNITY]=$summe";
     	  $ex = explode('&', $p);
     	  $url = $res."crm.deal.add.json";
     	  
     	  
     	  $response = json_decode(post($url, $p));
     	  return $response;
     }

