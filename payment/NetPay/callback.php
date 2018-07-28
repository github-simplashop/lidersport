<?php

// Работаем в корневой директории
chdir ('../../');
require_once('api/Simpla.php');
$simpla = new Simpla();
$status = 0;
$error = '';

$query = $simpla->db->placehold("SELECT * FROM __payment_methods WHERE module=? LIMIT 1", 'NetPay');
$simpla->db->query($query);
$payment_method = $simpla->db->result();
$payment_settins = unserialize($payment_method->settings);
$api_key = $payment_settins['api_key'];    
$auth_sign = $payment_settins['auth_sign'];    

if ($payment_settins['test_mode'] == '1'){
	$auth_sign = '1';
	$api_key = 'js4cucpn4kkc6jl1p95np054g2';
}


parse_str($_SERVER['QUERY_STRING'], $query_arr);
$getData = $query_arr;
foreach ($query_arr as $k => $v) { //cleaning bad keys
	if ($k == 'orderID') {
		break;
	}
	unset($getData[$k]);
}			
$preToken = '';
foreach ($getData as $k => $v) {
    if ($k !== 'token') $preToken .= $v.';';
}			
$token = md5($preToken.base64_encode(md5($api_key, true)).';');

if ($getData['auth'] == $auth_sign) {
    if ($token === urldecode($getData['token'])) {
        if (	in_array($getData['error'], array('000', '0'))
        	&&	($getData['status'] === 'APPROVED') 
        	&& 	($getData['transactionType'] == 'Sale')
        	) { 
			// Выберем заказ из базы
		    $order = $simpla->orders->get_order(intval($getData['orderID']));
		    if (empty($order)) {
		    	$getData['status'] = '0';
	            $getData['error'] = 'Оплачиваемый заказ не найден';
		    }
		    else {
		    	// Установим статус оплачен
			    $simpla->orders->update_order(intval($order->id), array('paid'=>1));
			
			    // Отправим уведомление на email
			    $simpla->notify->email_order_user(intval($order->id));
			    //$simpla->notify->email_order_admin(intval($order->id));
			
			    // Спишем товары  
			    $simpla->orders->close(intval($order->id));
			
			    $getData['status'] = '1';
		    }
        }
        else {
            $getData['status'] = '0';
        }
    }
    else {
        $getData['status'] = '0';
        $getData['error'] = 'Error: token does not match';
    }
}
else {
    $getData['status'] = 0;
    $getData['error'] = 'Wrong auth value';
}

echo '<notification>
            <orderId>' . $getData['orderID'] . '</orderId>
            <transactionType>' . $getData['transactionType'] . '</transactionType>
            <status>' . $getData['status'] . '</status>
            <error>' . $getData['error'] . '</error>
    </notification>';
