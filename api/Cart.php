<?php

/**
 * Simpla CMS
 *
 * @copyright	2011 Denis Pikusov
 * @link		http://simplacms.ru
 * @author		Denis Pikusov
 *
 */
 
require_once('Simpla.php');

class Cart extends Simpla
{

	/*
	*
	* Функция возвращает корзину
	*
	*/
    /**
     *
     */
    public function get_cart()
	{ 
		$cart->purchases = array();
		$cart->total_price = 0;
		$cart->total_products = 0;
		$cart->coupon = null;
		$cart->discount = 0;
		$cart->coupon_discount = 0;
        $cart->total_price_coupon = 0;
        $cart->discount_text = array();

		// Берем из сессии список variant_id=>amount
		if(!empty($_SESSION['shopping_cart']))
		{
			$session_items = $_SESSION['shopping_cart'];
			
			$variants = $this->variants->get_variants(array('id'=>array_keys($session_items)));
			if(!empty($variants))
			{
 
				foreach($variants as $variant)
				{
					$items[$variant->id]->variant = $variant;
					$items[$variant->id]->amount = $session_items[$variant->id];
					$products_ids[] = $variant->product_id;
				}
	
				$products = array();
				foreach($this->products->get_products(array('id'=>$products_ids)) as $p)
					$products[$p->id]=$p;
				
				$images = $this->products->get_images(array('product_id'=>$products_ids));
				foreach($images as $image)
					$products[$image->product_id]->images[$image->id] = $image;
			
				// Пользовательская скидка
				$cart->discount = 0;
				if(isset($_SESSION['user_id']) && $user = $this->users->get_user(intval($_SESSION['user_id'])))
					$cart->discount = $user->discount;
				foreach($items as $variant_id=>$item)
				{	
					$purchase = null;
					if(!empty($products[$item->variant->product_id]))
					{
						$purchase->product = $products[$item->variant->product_id];
						
						$purchase->variant = $item->variant;
						
						$purchase->amount = $item->amount;
			
						$cart->purchases[] = $purchase;
						if(isset($_SESSION['user_id']) && $user = $this->users->get_user(intval($_SESSION['user_id']))){
							if(isset($item->variant->compare_price) || $item->variant->compare_price!=""){
								$cart->total_price += $item->variant->price*$item->amount;	
							}
							else 
							{
								$item->variant->price *= (100-$cart->discount)/100;
								$cart->total_price += $item->variant->price*$item->amount;
							}

						}
						else{
							$item->variant->price *= (100-$cart->discount)/100;
							$cart->total_price += $item->variant->price*$item->amount;
						}
						$cart->total_products += $item->amount;
					}
				}
				
				
					
				//$cart->total_price *= (100-$cart->discount)/100;
				
				// Скидка по купону
				if(isset($_SESSION['coupon_code']))
				{
					$cart->coupon = $this->coupons->get_coupon($_SESSION['coupon_code']);
					if($cart->coupon && $cart->coupon->valid && $cart->total_price>=$cart->coupon->min_order_price)
					{
                        foreach($items as $variant_id=>$item)
                        {
                            $purchase = null;
                            $skidka = 0;
                            $purchase = new stdClass();
                            $purchase->product = $products[$item->variant->product_id];
                            $product_id = $purchase->product->id;
                            $coupon_id = $cart->coupon->id;
                            $this->db->query("SELECT DISTINCT count(*) cnt FROM s_categories_coupons cc, s_products_categories pc WHERE cc.category_id = pc.category_id AND pc.product_id = ? AND cc.coupon_id = ?", $product_id, $coupon_id);
                            $z=$this->db->result('cnt');
                            if($z)
                            {
                                if($cart->coupon->type!='absolute')
                                {
                                    if ($purchase->product->max_sale >= 0)
                                    {
                                        if ($purchase->product->max_sale == 0) {
                                            $purchase->product->max_sale = 20;
                                        }
                                        if ($cart->coupon->value > $purchase->product->max_sale) {
                                            $skidka = round((($item->variant->price*$item->amount) * ($purchase->product->max_sale)/100), 0, PHP_ROUND_HALF_DOWN);
                                        }
                                        else {
                                            $skidka = round((($item->variant->price*$item->amount) * ($cart->coupon->value)/100), 0, PHP_ROUND_HALF_DOWN);
                                        }

                                    }
                                    else
                                    {
                                        $skidka = 0;
                                    }

                                }

                                $cart->discount_text[$product_id] = $skidka;
                                $cart->total_price_coupon += $item->variant->price*$item->amount;
                                $cart->total_sale_coupon += $skidka;
                            }
                            else
                            {
                                $cart->discount_text[$product_id] = 0;
                                $cart->total_price_coupon += $item->variant->price*$item->amount;
                            }
                        }
					    if($cart->coupon->type=='absolute')
						{
                            // Абсолютная скидка не более суммы заказа
                            $cart->coupon_discount = $cart->total_price_coupon>$cart->coupon->value?$cart->coupon->value:$cart->total_price_coupon;
                            $cart->total_price_coupon = max(0, $cart->total_price_coupon-$cart->coupon->value);
                        }
                        else
                        {
                            $cart->coupon_discount = ($cart->total_price - ($cart->total_price_coupon - $cart->total_sale_coupon));
                            //$cart->total_price_coupon = $cart->total_price_coupon-$cart->coupon_discount;
                        }
					}
					else
					{
						unset($_SESSION['coupon_code']);
					}

				}
				else {
                    foreach($items as $variant_id=>$item)
                    {
                        $purchase = null;
                        $skidka = 0;
                        $purchase = new stdClass();
                        $purchase->product = $products[$item->variant->product_id];
                        $product_id = $purchase->product->id;

                        if ($purchase->product->max_sale >= 0)
                        {
                            if ($purchase->product->max_sale == 0) {
                                $purchase->product->max_sale = 20;
                            }
                            if ($purchase->product->max_sale >= 5) {
                                $skidka = round((($item->variant->price*$item->amount) * 0.05), 0, PHP_ROUND_HALF_DOWN);
                            }
                            else {
                                $skidka = 0;
                            }
                        }
                        else
                        {
                            $skidka = 0;
                        }

                        $cart->discount_text[$product_id] = $skidka;
                        $cart->total_price_coupon += $item->variant->price*$item->amount;
                        $cart->total_sale_coupon += $skidka;

                        $cart->coupon_discount = ($cart->total_price - ($cart->total_price_coupon - $cart->total_sale_coupon));
                    }
                }
			}
		}

        $cart->total_price = $cart->total_price - $cart->coupon_discount;
		return $cart;
	}
	
	/*
	*
	* Добавление варианта товара в корзину
	*
	*/
	public function add_item($variant_id, $amount = 1)
	{ 
		$amount = max(1, $amount);
	
		if(isset($_SESSION['shopping_cart'][$variant_id]))
      		$amount = max(1, $amount+$_SESSION['shopping_cart'][$variant_id]);

		// Выберем товар из базы, заодно убедившись в его существовании
		$variant = $this->variants->get_variant($variant_id);

		// Если товар существует, добавим его в корзину
		if(!empty($variant) && ($variant->stock>0) )
		{
			// Не дадим больше чем на складе
			$amount = min($amount, $variant->stock);
	     
			$_SESSION['shopping_cart'][$variant_id] = intval($amount); 
		}
	}
	
	/*
	*
	* Обновление количества товара
	*
	*/
	public function update_item($variant_id, $amount = 1)
	{
		$amount = max(1, $amount);
		
		// Выберем товар из базы, заодно убедившись в его существовании
		$variant = $this->variants->get_variant($variant_id);

		// Если товар существует, добавим его в корзину
		if(!empty($variant) && $variant->stock>0)
		{
			// Не дадим больше чем на складе
			$amount = min($amount, $variant->stock);
	     
			$_SESSION['shopping_cart'][$variant_id] = intval($amount); 

		}
 
	}
	
	
	/*
	*
	* Удаление товара из корзины
	*
	*/
	public function delete_item($variant_id)
	{
		unset($_SESSION['shopping_cart'][$variant_id]); 
	}
	
	/*
	*
	* Очистка корзины
	*
	*/
	public function empty_cart()
	{
		unset($_SESSION['shopping_cart']);
		unset($_SESSION['coupon_code']);
	}
 
	/*
	*
	* Применить купон
	*
	*/
	public function apply_coupon($coupon_code)
	{
		$coupon = $this->coupons->get_coupon((string)$coupon_code);
		if($coupon && $coupon->valid)
		{
			$_SESSION['coupon_code'] = $coupon->code;
		}
		else
		{
			unset($_SESSION['coupon_code']);
		}		
	} 
}