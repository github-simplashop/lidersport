<?php 
$mail=array("info@lidsport.ru");
/*  */

$mailmsg="";
			if ($_POST["title"] and $_POST["kol"])	
			{			
				$subscrname = "Оформление товара";  
		
				$mailmsg="
				<h2>".$_POST["title"]."</h2><br />
				ФИО: ".$_POST["name"]."<br>
				Город: ".$_POST["city"]."<br>
				телефон: ".$_POST["tel"]."<br><br>
				
				Кол-во: ".$_POST["kol"]."<br>
				url: <a href='".$_POST["url"]."'>".$_POST["url"]."</a><br>
				";
			}
			else if ($_POST["zvon"])
			{
				$subscrname = "Консультация";  
					
				$mail2 = "";
				if (isset($_POST['email'])) 	$mail2 = "Email: ".$_POST['email']."<br>";
				$mailmsg="
				<h2>".$_POST["title"]."</h2><br />
				url: <a href='".$_POST["url"]."'>".$_POST["url"]."</a><br>
				ФИО: ".$_POST["name"]."<br>
				$mail2
				телефон: ".$_POST["tel"]."<br><br>
				коммент: ".$_POST["oz_comment"]."<br>
				";
			}
			else if ($_POST["kalk"])
			{
				$subscrname = "Оформление товара";  
		
				$mailmsg="
				<h2>".$_POST["title"]."</h2><br />
				url: <a href='".$_POST["url"]."'>".$_POST["url"]."</a><br>
				ФИО: ".$_POST["name"]."<br>
				Город: ".$_POST["city"]."<br>
				телефон: ".$_POST["tel"]."<br>
				коммент: ".$_POST["kom"]."<br>
				";
			}
			
			
			if ($mailmsg)
			{
				$i=0;
				while ($mail[$i])
				{
					$headers="Content-Type: text/html; charset=utf-8\n";
					$headers.="From: info@lidsport.ru\nX-Mailer: SDone mailer";
					if (!mail($mail[$i],$subscrname,$mailmsg,$headers))
					{
						echo "письмо не отправилось !!!!".$mail[$i];
					}
					else {
						
					}
					$i++;
				}
			}
?>

