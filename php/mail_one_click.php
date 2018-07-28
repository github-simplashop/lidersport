<?php
session_start();
//ini_set("display_errors",1);
//error_reporting(E_ALL); 
chdir("../");
$dir = str_replace('php', '', dirname(__FILE__));
require_once $dir . 'api/Simpla.php';
require_once $dir . 'b24func.php';

Class FormContact extends Simpla
{
    public function generatorItemsName()
    {
        $result = array();
        $row    = $this->cart->get_cart();
        foreach ($row->purchases AS $name => $value) {
            $result[] = '<tr><td style="text-align: center;">' . $value->product->name . '</td><td  style="text-align: center;">' . $value->amount . ' шт</td><td  style="text-align: center;">' . number_format($value->variant->price * $value->amount, 2, ',', ' ') . ' ' . $this->money->get_currency()->sign . '</td></tr>';
        }
        return $result;
    }

    public function generatorTotalPrice()
    {
        $summe            = array();
        $row              = $this->cart->get_cart();
        $summ['summe']    = $row->total_price;
        $summ['discount'] = $row->coupon_discount;
        return $summ;
    }
}

$form = new FormContact();
$data = $form->generatorItemsName();
$row  = $form->cart->get_cart();

if (isset($_SESSION['utm_data']) and count($_SESSION['utm_data']) > 0) {
    $utm_num = 0;
    if (substr_count($_SESSION['utm_data']['utm_source'], 'yandex')) {
        $utm_num  = 86;
        $utm_name = "Яндекс директ";
    } elseif (substr_count($_SESSION['utm_data']['utm_source'], 'google')) {
        $utm_num  = 88;
        $utm_name = "Google Adwords";
    } elseif (substr_count($_SESSION['utm_data']['utm_source'], 'vk')) {
        $utm_num  = 92;
        $utm_name = "ВК реклама";
    } elseif (substr_count($_SESSION['utm_data']['utm_source'], 'instagram')) {
        $utm_num  = 92;
        $utm_name = "ИНСТ реклама";
    }
    $im = array();
    foreach ($_SESSION['utm_data'] AS $num => $value) {
        $im[] = "<p>$num: $value</p>";
    }

} else {
    if (count($_SESSION['y_referer']) <= 0) {
        $referer  = "отсутствует";
        $utm_name = "Прямой заход";
    } else {
        $referer = htmlspecialchars($_SESSION['y_referer']);
        $parser  = parse_url($referer);
        $host    = $parser['host'];
        if (substr_count($host, 'google')) {
            $utm_name = "Поиск Google";
            $utm_num  = 84;
        } elseif (substr_count($host, 'yandex')) {
            $utm_num  = 82;
            $utm_name = "Поиск Яндекс";
        } else {
            $utm_num  = 96;
            $utm_name = "Пришел с сайта " . $host;
        }
    }
}

if (isset($_SESSION['y_referer'])) {
    $referer = $_SESSION['y_referer'];
} else {
    $referer = "отсутствует";
}


if (count($im) > 0) {
    $utm_data = implode("\n", $im);
} else {
    $utm_data = "<p>UTM метки: Отсутствуют</p>";
}
$price        = number_format(str_replace(' ', '', $_POST['price']), 2, ',', ' ');
$cart_content = '<tr><td style="text-align: center;">' . htmlspecialchars($_POST['item']) . '</td><td  style="text-align: center;">Уточнить у клиента</td><td  style="text-align: center;">' . $price . ' ' . $form->money->get_currency()->sign . '</td></tr>';

$cart_content .= $cart1 . '<tr><td colspan="3" style="text-align: center;">Заказ на сумму <b>' . $price . ' '
    . $form->money->get_currency()->sign . '</b></td></tr>';
//         {$product->equally_price|convert}
//$cart_content = '<tr><td style="text-align: center;">'.htmlspecialchars($_POST['item']).'</td><td  style="text-align: center;">Уточнить у клиента</td><td  style="text-align: center;">'.number_format($_POST['price'],2,',',' ').' '.$form->money->get_currency()->sign.'</td></tr>';
//$cart_content .= $cart1.'<tr><td colspan="3" style="text-align: center;">Заказ на сумму <b>'.number_format($product->equally_price|convert).' '.$form->money->get_currency()->sign.'</b></td></tr>';

$to      = 'info@lidsport.ru';
$to_2    = 'om@lidsport.ru';
$subject = 'Заявка "Купить в один клик"';
$message = '
        <html>
            <head>
                <title>' . $subject . '</title>
            </head>
            <body>
                <p>Имя: ' . $_POST['name'] . '</p>
                <p>Телефон: ' . $_POST['phone'] . '</p>
                <p>ИСТОЧНИК ЛИДА: ' . $utm_name . '</p>
                ' . $utm_data . '
                <p>Товар: ' . htmlspecialchars($_POST['item']) . '</p>
                <p>Referer: ' . $referer . '</p>
                <table border="0" style="width:100%;">
                   <tr>
                       <th style="width:75%; text-align: center;">Товар</th>
                       <th style="text-align: center;">Количество</th>
                       <th style="text-align: center;">Цена</th>
                   </tr>
                ' . $cart_content . '
                </table>
            </body>
        </html>';
print $message;
$headers = "Content-type: text/html; charset=utf-8 \r\n";
$headers .= "From: lidsport.ru <info@lidsport.ru>\r\n";
mail($to, $subject, $message, $headers);
mail($to_2, $subject, $message, $headers);
$code  = $form->money->get_currency()->code;
$_user = addContact($_POST['name'], $_POST['phone'], $_SESSION['utm_data']['utm_source']);
addDeal($_user, "Купить в один клик - " . htmlspecialchars($_POST['item']) . "", $code, $_POST['price'], $utm_name, "Купить в 1 клик");
    

