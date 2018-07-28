<?php
//include "city.php";
//include "shops.php";
include "LocalDPD.php";
include "cost1.php";

$localdpd = new LocalDPD;

$city1 = "Ставрополь";
//$city2 = "Котлас";

if(isset($_POST["city"])) {
    $city2 = $_POST["city"];
}
if(isset($_POST["weight"])) {
    $weight = $_POST["weight"];
}
if(isset($_POST["height"])) {
    $height = $_POST["height"];
}
if(isset($_POST["width"])) {
    $width = $_POST["width"];
}
if(isset($_POST["length"])) {
    $length = $_POST["length"];
}

//$weight = 3;
//$height = 20;
//$width = 40;
//$length = 80;

$params = array(
    "weight" => $weight,
    "height" => $height,
    "width" => $width,
    "length" => $length
);

$city1_id = $localdpd->getLocalCityID($city1);
$city2_id = $localdpd->getLocalCityID($city2);

$cost = calcCost($city1_id, $city2_id, $params);


//echo "$city1 - $city2";
//echo "<pre>";
//print_r($cost);
//echo "</pre>";

if($cost){
    echo json_encode($cost);
}

