<?
    $to = 'info@lidsport.ru, om@lidsport.ru';
    $subject = 'Предварительный заказ';
    $message = '
        <html>
            <head>
                <title>'.$subject.'</title>
            </head>
            <body>
                <p>Клиент попытался сделать заказ '.$_POST['tovar'].', но еще не дошел до конца. Если в ближайшее время заказ не будет оформлен - позвоните клиенту:</p>
                <p>Имя: '.$_POST['name'].'</p>
                <p>Телефон: '.$_POST['phone'].'</p>
            </body>
        </html>';
    $headers  = "Content-type: text/html; charset=utf-8 \r\n";
    $headers .= "From: lidsport.ru <info@lidsport.ru>\r\n";
    mail($to, $subject, $message, $headers);