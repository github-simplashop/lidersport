<?php
$file = 'promo_email.txt';
$clients = unserialize(file_get_contents($file));

foreach ($clients as $client) {
    echo $client[email] . " - " .  $client[promocode] . "<br/>";
}
