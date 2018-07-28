<?php
session_start();
//ini_set("display_errors",1);
//error_reporting(E_ALL); 
chdir("../");
$dir = str_replace('php', '', dirname(__FILE__));
require_once $dir.'api/Simpla.php';

Class FormContact extends Simpla{
	  public function generatorItemsName(){
	  	  $result  = array();
	  	  $row = $this->cart->get_cart();
	  	  print_r($row);
	  	  foreach($row->purchases AS $name=>$value){
	  	  	  $result[] = '<tr><td style="text-align: center;">'.$value->product->name.'</td><td  style="text-align: center;">'.$value->amount.' шт</td><td  style="text-align: center;">'.number_format($value->variant->price * $value->amount,2,',',' ').' '.$this->money->get_currency()->sign.'</td></tr>';
	  	  }
	  	  return $result;
	  }
	  public function generatorTotalPrice(){
	  	 $summe = array();
	  	 $row = $this->cart->get_cart();
         $summ['summe'] = $row->total_price;
         $summ['discount'] = $row->coupon_discount;
         return $summ;
	  }
}

$form = new FormContact();
$data = $form->generatorItemsName();
$row = $form->cart->get_cart();
?>
<table border="0" style="width:100%;">
   <tr>
       <th style="width:75%; text-align: center;">Товар</th>
       <th style="text-align: center;">Количество</th>
       <th style="text-align: center;">Цена</th>
   </tr>
<? echo implode("\n", $data); ?> 
<tr><td colspan="3" style="text-align: center;">Заказ на сумму <?php echo number_format($row->total_price, 2, ',',' '); echo " ".$form->money->get_currency()->sign; ?> (<font color="red"><?php echo number_format($row->total_price_coupon, 2, ',',' '); echo " ".$form->money->get_currency()->sign; ?></font>) купон включен! </td></tr>
</table>