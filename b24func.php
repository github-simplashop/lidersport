<?php

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
           $param = array('fields' => array('NAME' => $fio,'SECOND_NAME' => '','LAST_NAME' => '', 'OPENED' => 'Y', 'ASSIGNED_BY_ID' => 1, 'TYPE_ID' => 'CLIENT', 'SOURCE_ID' => $source,'PHONE' => array(array('VALUE' => $phone, 'VALUE_TYPE' => 'WORK'))));
            foreach($param AS $name => $value){
                 $p["FIELDS[$name]"] =$value;
            }

           $param = http_build_query($param);
            

           $url = $res."crm.contact.add.json";
           $response = json_decode(post($url,$param));
           return $response->result;
     }
     function addDeal($id, $title, $current, $summe, $source = 96, $zakaz){
     	  global $res;
     	  $p = "fields[TITLE]=$title&fields[TYPE_ID]=Продажа&fields[CONTACT_ID]=$id&fields[OPENED]=N&fields[ASSIGNED_BY_ID]=124&fields7[CURRENCY_ID]=$current&fields[OPPORTUNITY]=$summe&fields[UTM_SOURCE]=".$_SESSION['utm_data']['utm_source']."&fields[UTM_MEDIUM]=".$_SESSION['utm_data']['utm_medium']."&fields[UTM_CAMPAIGN]=".$_SESSION['utm_data']['utm_campaign']."&fields[UTM_CONTENT]=".$_SESSION['utm_data']['utm_content']."&fields[UTM_TERM]=".$_SESSION['utm_data']['utm_term']."&fields[UF_CRM_1521275132]=".$_SESSION['y_referer']."&fields[UF_CRM_1521397378]=".$source."&fields[UF_CRM_1521398696]=".$zakaz;
          //$p .= http_build_query(array('items' => array(array('id' => 96, 'VALUE' => $source, 'VALUE_TYPE' => 'WORK'))));
     	  $ex = explode('&', $p);
     	  $url = $res."crm.deal.add.json";
     	  
     	  
     	  $response = json_decode(post($url, $p));
     	  return $response;
     }

