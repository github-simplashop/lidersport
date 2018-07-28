<?php

include "LocalDPD.php";

$localdpd = new LocalDPD;

if(isset($_POST["city"])) {
    $city = $_POST["city"];

    $findshops = $localdpd->getLocalShops($city);

    $delivery_arr = array();

    foreach($findshops as $item) {
        if ($item->brand == "DPD" or $item->brand == "") {
            //echo "Пункт выдачи: DPD";
            $delivery_name = "Пункт выдачи: DPD";
        }
        else {
            //echo "Пункт выдачи: DPD - ". $item->brand;
            $delivery_name = "Пункт выдачи: DPD - ". $item->brand;
        }
        //echo "<br/>";
        $delivery_address = $item->address->streetAbbr . " " . $item->address->street . ", " . $item->address->houseNo;

        //echo $item->address->streetAbbr . " " . $item->address->street . ", " . $item->address->houseNo;
        //echo "<br/>";
        $delivery_geoCoordinates = array(
            'latitude' => $item->geoCoordinates->latitude,
            'longitude' => $item->geoCoordinates->longitude
        );

        //echo "Время работы: <br/>";

        foreach ($item->schedule as $key => $schedule) {
            if (!is_string($key)){
                if ($schedule->operation == "SelfDelivery") {
                    if (is_array($schedule->timetable)){
                        $opentimetable = array();
                        foreach ($schedule->timetable as $timetable) {
                            //echo "&nbsp; $timetable->weekDays: $timetable->workTime<br/>";
                            $opentimetable[] = array(
                                'weekDays' => $timetable->weekDays,
                                'workTime' => $timetable->workTime
                            );
                        }
                    }
                    else {
                        //echo "&nbsp;" . $schedule->timetable->weekDays . ": " . $schedule->timetable->workTime . "<br/>";
                    }
                }
            }
            elseif ($key == "timetable") {
                if (is_array($schedule)){
                    $opentimetable = array();
                    foreach ($schedule as $timetable) {
                        //echo "&nbsp; $timetable->weekDays: $timetable->workTime<br/>";
                        $opentimetable[] = array(
                            'weekDays' => $timetable->weekDays,
                            'workTime' => $timetable->workTime
                        );
                    }
                }
                else {
                    //echo "&nbsp;" . $schedule->weekDays . ": " . $schedule->workTime . "<br/>";
                }
            }
        }

        //echo "Способы оплаты: <br/>";

        $pay_count = 0;
        foreach ($item->schedule as $key => $schedule) {
            if (!is_string($key)) {

                if ($schedule->operation == "Payment") {
                    //echo "&nbsp; прием наличных<br/>";
                    $pay_count++;
                }
                if ($schedule->operation == "PaymentByBankCard") {
                    //echo "&nbsp; прием банковских карт<br/>";
                    $pay_count++;
                }
            }
        }
        if ($pay_count == 0) {
            //echo "&nbsp; отсутствуют<br/>";
        }
        //echo "<br/><br/>";

        $delivery_arr[] = array(
            'name'=>$delivery_name,
            'address'=>$delivery_address,
            'opentimetable'=>$opentimetable,
            'geoCoordinates'=>$delivery_geoCoordinates
        );
    }

    $res[shops]  = $delivery_arr;

}
elseif (isset($_POST["region"])) {
    $region = $_POST["region"];

    $cities_arr = $localdpd->getLocalCities($region);

    $res[cities] = $cities_arr;

}
else {
    $regions_arr = $localdpd->getLocalRegions();

    $res[regions] = $regions_arr;

}





//$regions = $localdpd->getLocalRegions();
//echo "<pre>";
echo json_encode($res);
//print_r($cities_arr);
//echo "</pre>";

?>

