<?
if(isset($_POST["email"])) {
    $to = $_POST["email"];
}
if(isset($_POST["promo"])) {
    $promo = $_POST["promo"];
}

$subject = 'Персональный промокод на скидку 10%';
$message = '
        <html>
            <head>
                <title>'.$subject.'</title>
            </head>
            <body>
                <p>Привет, любитель спорта и здорового образа жизни!</p>
                <p>Твой персональный промокод на скидку 10% в нашем магазине</p>
                <p><strong>'.$promo.'</strong></p>
                <p>Не забудь, что воспользоваться им можно только в течение 7 дней, начиная с сегодняшнего дня!</p>
                <p>Как воспользоваться промокодом?</p>
                <p>
                    <ol>
                        <li>Самый простой способ - выбрать товары на сайте <a href="http://lidsport.ru/?utm_source=e-mail&utm_medium=e-mail&utm_campaign=Promokod_10%&utm_content=DIrect&utm_term=1_pismo">lidsport.ru</a> и в корзине ввести наш промокод.</li><br/>
                        <li>Можно придти в магазин и сказать этот промокод продавцу или даже просто показать этот e-mail при покупке.</li>
                    </ol>
                </p>
                <p>Спасибо, что обратился именно к нам, мы приложим все усилия, чтобы оправдать все твои ожидания от компании Лидерспорт</p>
                <p>
                    -- Команда Лидерспорт<br/>
                    -- 8(8652)99-00-59
                </p>

            </body>
        </html>';
$headers  = "Content-type: text/html; charset=utf-8 \r\n";
$headers .= "From: lidsport.ru <info@lidsport.ru>\r\n";

$file = 'promo_email.txt';
$current = unserialize(file_get_contents($file));

if(empty($current)){
    $clients = array();
}
else {
    $clients = $current;
}
$repeat = false;
foreach ($clients as $client) {
    if ($client[email] == $to) {
        $repeat = true;
    }
}
if (!$repeat) {
    $success = mail($to, $subject, $message, $headers);
    //$success = true;
    if($success) {
        array_push($clients, array(
            "email" => "$to",
            "promocode" => "$promo",
        ));
        echo "Промокод отправлен!";
    }
    else {
        echo "К сожалению не удалось отправить промокод!";
    }
}
else {
    echo "На данную почту уже высылался промокод!";
}

$current = serialize($clients);
// Пишем содержимое обратно в файл
file_put_contents($file, $current);
