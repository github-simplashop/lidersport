<?
    $to = 'info@lidsport.ru';
    $subject = 'Заявка с сайта lidsport.ru';
    $message = '
        <html>
            <head>
                <title>'.$subject.'</title>
            </head>
            <body>
                <p>Имя: '.$_POST['name'].'</p>
                <p>Телефон: '.$_POST['phone'].'</p>
                <p>Название товара: '.$_POST['item'].'</p>
            </body>
        </html>';
    $headers  = "Content-type: text/html; charset=utf-8 \r\n";
    $headers .= "From: noreply <noreply@domen.ru>\r\n";
    mail($to, $subject, $message, $headers);