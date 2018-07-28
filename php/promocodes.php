<?php

if(isset($_POST["localStorage"])) {

}

if(isset($_POST["cookie"])) {

}

if(isset($_POST["email"])) {
    $_SESSION['email'] = $_POST["email"];
}
else {
    $_SESSION['email'] = "";
}
session_start();
//unset($_SESSION['count']);

if (($_SESSION['count']) == NULL && $_POST['cookie'] == "first" && $_POST["localStorage"] == "first") {

    $_SESSION['count'] = 1;
    $count = 1;
    $_SESSION['cookie'] = "repeat";
    $_SESSION['localStorage'] = "repeat";

    chdir('../');
    require_once('api/Simpla.php');

    setlocale(LC_ALL, "ru_RU.UTF-8");

    for ($i = 1; $i <= 205; $i++) {
        $coupon_categories[] = $i;
    }

    $simpla = new Simpla();
    $result = $simpla->coupons->get_coupons();
    foreach($result as $r){
        $pattern = '/^D23R12C[0-9]+/';
        if (preg_match($pattern, $r->code, $matches)) {
            $names[] = substr($r->code, 7);
        }
    }
    rsort($names);
    $name = $names[0];
    if($name) {
        $coupon->code = "D23R12C" . ++$name;
        $coupon->expire = $date = date("Y-m-d H:i:s", strtotime("+7 days"));
        $coupon->value = "10";
        $coupon->type = "percentage";
        $coupon->min_order_price = "";
        $coupon->single = "1";

        $coupon->id = $simpla->coupons->add_coupon($coupon);
        $coupon = $simpla->coupons->get_coupon($coupon->id);

        $_SESSION['id'] = $coupon->id;
        $_SESSION['promo'] = $coupon->code;
        $_SESSION['expire'] = date("d.m.Y", strtotime($coupon->expire));

        if($result) {
            $simpla->coupons->update_coupon_categories($coupon->id, $coupon_categories);
        }
    }
    else {
        $coupon->code = "D23R12C1";
        $coupon->expire = $date = date("Y-m-d H:i:s", strtotime("+7 days"));
        $coupon->value = "10";
        $coupon->type = "percentage";
        $coupon->min_order_price = "";
        $coupon->single = "1";

        $coupon->id = $simpla->coupons->add_coupon($coupon);

        if($coupon->id) {
            foreach($coupon_categories as $cat) {
                $simpla->coupons->add_coupon_category($coupon->id, $cat);
            }
        }
    }

    $_SESSION['promo'] = $coupon->code;

    $res = array(
        "id" => $coupon->id,
        "promo" => $coupon->code,
        "expire" => date("d.m.Y", strtotime($coupon->expire)),
        "count" => $count,
        "cookie" =>  "repeat",
        "localStorage" => "repeat",
        "email" => "",
    );
}
else {
    $_SESSION['count']++;
    $_SESSION['cookie'] = "repeat";
    $_SESSION['localStorage'] = "repeat";

    $res = array(
        "id" => $_SESSION['id'],
        "promo" => $_SESSION['promo'],
        "expire" => $_SESSION['expire'],
        "count" => $_SESSION['count'],
        "cookie" =>  $_SESSION['cookie'],
        "localStorage" => $_SESSION['localStorage'],
        "email" => $_SESSION['email'],
    );
}




echo json_encode($res);