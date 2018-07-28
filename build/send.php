<?
    if($_POST['form']=="callback") {
        $to = 'tili-bom@bk.ru';
        $subject = 'LiderSport - Заказ обратного звонка';
        $message = '
                <html>
                    <head>
                        <title>'.$subject.'</title>
                    </head>
                    <body>
                        <p>Имя: '.$_POST['name'].'</p>
                        <p>Телефон: '.$_POST['phone'].'</p>
                    </body>
                </html>';
        $headers  = "Content-type: text/html; charset=utf-8 \r\n";
        $headers .= "From: noreply <noreply@lidersport.ru>\r\n";
        mail($to, $subject, $message, $headers);
    } else {
        $to = 'tili-bom@bk.ru';
        $subject = 'LiderSport - Заказ товара';
        $message = '
                <html>
                    <head>
                        <title>'.$subject.'</title>
                    </head>
                    <body>
                        <p>Имя: '.$_POST['name'].'</p>
                        <p>Телефон: '.$_POST['phone'].'</p>
                        <p>Товар : '.$_POST['treeName'].'</p>
                        <p>Размер: '.$_POST['treeSize'].'</p>
                        <p>Цена: '.$_POST['treePrice'].'</p>
                    </body>
                </html>';
        $headers  = "Content-type: text/html; charset=utf-8 \r\n";
        $headers .= "From: noreply <noreply@lidersport.ru>\r\n";
        mail($to, $subject, $message, $headers);
    }
?>