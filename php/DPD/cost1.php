<?php
function calcCost($city1, $city2, $params) { //делаем функцию по поиску ключа города в DPD передавая город. (Пример - Калуга)

//    $city1 = "196025140";   //Ставрополь
//    $city2 = "49210037";    //Краснодар
    include "settings.php";
//    echo "$server[0]calculator2?wsdl <br/><br/>";
    $client = new SoapClient ("$server[0]calculator2?wsdl");

    $sposob = "";
    $arData['auth'] = array(
        'clientNumber' => $MY_NUMBER,
        'clientKey' => $MY_KEY,);

    $arData = array(
        'delivery' => array(			// город доставки
            'cityId' => $city2, //сам город
        ),
    );		$arData['auth'] = array(
        'clientNumber' => $MY_NUMBER,
        'clientKey' => $MY_KEY); //данные авторизации
    if ($sposob == 'home'){ //если отправляем до дома то ставим значение false
        $arData['selfDelivery'] = false;// Доставка ДО дома
    }
    else { // если же мы хотим отправить до терминала то true
        $arData['selfDelivery'] = true;// Доставка ДО терминала
    }
    $arData['pickup'] = array(
        'cityId' => $city1,
    ); // где забирают товар

    $arData['selfPickup'] = true;// Доставка ОТ терминала // если вы сами довозите до терминала то true если вы отдаёте от двери то false

//    $arData['weight'] = 8;
//    $arData['length'] = 70;
//    $arData['width'] = 40;
//    $arData['height'] = 50;
//    $arData['quantity'] = 1;

    $weight = $params["weight"];
    $length = $params["length"];
    $width = $params["width"];
    $height = $params["height"];
    $cout = 1;  //если у нас место 1 то мы просто заносим в массив

    $arData['parcel'] = array('weight' => $weight, 'length' => $length, 'width' => $width, 'height' => $height , 'quantity' => $cout);


    $arRequest['request'] = $arData; //помещаем наш масив авторизации в масив запроса request.


//    echo "<pre>";
//    print_r($arRequest);
//    echo "</pre>";


    try {
        $ret = ($client->getServiceCostByParcels2($arRequest)); //обращаемся к функции getCitiesCashPay  и получаем список городов.
    } catch (Exception $e) {
        echo "disallow";
    }

    $result = $ret;

    if($result){
        $min_cost = 0;
        foreach($ret->return as $item) {
            $params[] = array(
                "cost" => $item->cost,
                "days" => $item->days
            );
            if($min_cost == 0){
                $min_cost = $item->cost;
                $params_min[0] = array(
                    "cost" => $item->cost,
                    "days" => $item->days
                );
            }
            else {
                if($min_cost > $item->cost){
                    $min_cost = $item->cost;
                    $params_min[0] = array(
                        "cost" => $item->cost,
                        "days" => $item->days
                    );

                }
            }
        }

        return $params_min[0];

    }
}
