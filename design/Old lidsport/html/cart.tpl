<!-- wablon korziny -->
{* Шаблон корзины *}

{$meta_title = "Корзина" scope=parent}
	<div class="category_title mb20 mt20">
		<span>Корзина</span>
	</div>
	
	<div class="div_tovar mb30">
		<div class="tov_header h45 pattern"></div>
		<h1 class="ml10 mt10" style="font-size: 19px;  font-weight: bold;">
			{if $cart->purchases}В корзине {$cart->total_products} {$cart->total_products|plural:'товар':'товаров':'товара'}
			{else}Корзина пуста{/if}
		</h1>
		
		{if $cart->purchases}
			<form method="post" name="cart" class="mb20 cart_page">
				{* Список покупок *}
				<ul id="purchases" class="ul_basket">
					{foreach from=$cart->purchases item=purchase}
						<li>
							<div class="row">
							
								{* Изображение товара *}
								<div class="fl">
									<div class="div_l w180 h140 dtc vam">
										{$image = $purchase->product->images|first}
											<a href="/products/{$purchase->product->url}">
												{if $purchase->product->imagesc}
                                                <img src="/images1c/{$purchase->product->imagesc}" alt="{$product->name|escape}" style="display:block; margin:0 auto; max-height:130px;">
                                 
                                			{else}
                                				{if $image}
                            		         	<img src="{$image->filename|resize:179:139}" alt="{$product->name|escape}">
                                                {else}
                                                <img src="/design/lidsport/images/defaultPhoto.png" alt="{$product->name|escape}" style="display:block; margin:0 auto;">
                                                {/if}
												
											
											{/if}
										</a>
									</div>
								</div>
								
								{* Название товара *}
								<div class="fl" style="width:300px;">
									<div class="dtc vam h140">
										{$purchase->variant->name|escape}
											<a href="products/{$purchase->product->url}" class="nazv db">
												{$purchase->product->name|escape}
											</a>       
										{$purchase->variant->name|escape}
									</div>
								</div>
								
								{* Количество *}
								<div class="fl" style="margin-left: 72px;width: 117px;">
									<span class="colvo w180 db mt25 mb20">Количество</span>
									<!--<a href="" class="minus fl"></a>
									<input name="" type="text" class="chislo w40 tac fl">
									<a href="" class="plas fl"></a>-->
									<select name="amounts[{$purchase->variant->id}]" onchange="document.cart.submit();">
										{section name=amounts start=1 loop=$purchase->variant->stock+1 step=1}
											<option value="{$smarty.section.amounts.index}" {if $purchase->amount==$smarty.section.amounts.index}selected{/if}>{$smarty.section.amounts.index} {$settings->units}</option>
										{/section}
									</select>
								</div>
								
								{* Цена за единицу *}
								<div class="fl">
									<span class="colvo w180 db mt25 mb20">Стоимость</span>
									<span class="rub b pr fl" style="color:#411d75;"><span class="r_da pa" style="top: 1px;color:#411d75;">-</span>P</span>
									<span class="price2 fl db ml15 f16 pa"  style="margin: 0px 0 0 21px;">{($purchase->variant->price*$purchase->amount)|convert}&nbsp;{$currency->sign}</span>
								</div>
								
								{* Удалить из корзины *}
								<div class="fl">
									<div class="dtc vam h140">
										<a href="/cart/remove/{$purchase->variant->id}" class="db del w20 h20"></a>
									</div>
								</div>
								
							</div>
							<div class="cl"></div>
						</li>
					{/foreach}
				</ul>
				
				{if $user->discount}
					<tr>
						<th class="image"></th>
						<th class="name">скидка</th>
						<th class="price"></th>
						<th class="amount"></th>
						<th class="price">{$user->discount}&nbsp;%</th>
						<th class="remove"></th>
					</tr>
				{/if}
				
				{if $coupon_request}
					<tr class="coupon">
						<th class="image"></th>
						<th class="name" colspan="3">Код купона или подарочного ваучера
							{if $coupon_error}
								<div class="message_error">
									{if $coupon_error == 'invalid'}Купон недействителен{/if}
								</div>
							{/if}
							<div>
								<input type="text" name="coupon_code" value="{$cart->coupon->code|escape}" class="coupon_code">
							</div>
							
							{if $cart->coupon->min_order_price>0}(купон {$cart->coupon->code|escape} действует для заказов от {$cart->coupon->min_order_price|convert} {$currency->sign}){/if}
							
							<div>
								<input type="button" name="apply_coupon" class="btn"  value="Применить купон" onclick="document.cart.submit();">
							</div>
						</th>
						<th class="price">
							{if $cart->coupon_discount>0}
								&minus;{$cart->coupon_discount|convert}&nbsp;{$currency->sign}
							{/if}
						</th>
						<th class="remove"></th>
					</tr>
					
					{literal}
						<script>
							$("input[name='coupon_code']").keypress(function(event)
							{
								if(event.keyCode == 13)
								{
									$("input[name='name']").attr('data-format', '');
									$("input[name='email']").attr('data-format', '');
									document.cart.submit();
								}
							});
						</script>
					{/literal}
				{/if}
				
				<div class="dostavit">
					<div class="row">
					
						{* Доставка *}
						{if $deliveries}
							<div class="fl w500">
								<span class="aebal mt15 db">Способ получения:</span>
								<ul id="deliveries" class="bn p0">
									{foreach $deliveries as $delivery}
										<li>
										
											<div class="checkbox">
												<input type="radio" style="float:left; margin:4px 5px 0 0;" name="delivery_id" value="{$delivery->id}" {if $delivery_id==$delivery->id}checked{elseif $delivery@first}checked{/if} id="deliveries_{$delivery->id}">
											</div>
											
											<h3>
												<label for="deliveries_{$delivery->id}">
													{$delivery->name}
														{if $cart->total_price < $delivery->free_from && $delivery->price>0}
															({$delivery->price|convert}&nbsp;{$currency->sign})
														{elseif $cart->total_price >= $delivery->free_from}
															(бесплатно)
														{/if}
												</label>
											</h3>
											
											<div class="description">{$delivery->description}</div>
											
										</li>
									{/foreach}
								</ul>
							</div>
							
							<div class="fl">
								<span class="f16 aebal ttu mt15 db b">ОБЩАЯ СТОИМОСТЬ (БЕЗ ДОСТАВКИ):</span>
								<!--<span class="f16 aebal ttu mt15 db b">ОБЩАЯ СТОИМОСТЬ (С ДОСТАВКОЙ):</span>-->
							</div>
							
							<div class="fl ml5">
								<span class="rub2 fl b f20 db mt15 pr"><span style="position:absolute;font-size: 19px;top: 3px;left: 2px;">-</span>P</span>
								<span class="price2 fl db ml15 f20 pa mt12" style="margin: 15px 0 0 16px; color:#63269d;">{$cart->total_price|convert}&nbsp;{$currency->sign}</span>
								<!--<del class="rub2 fl b f20 db ml-13 mt46">P</del>
								<span class="price2 fl db ml15 f20 pa mt46" style="margin: 48px 0 0 16px; color:#63269d;">???</span>-->
							</div>
							
							<div class="cl"></div>
						{/if}
					</div>
				</div>
				
				<div class="forms mb30">
					<div class="row">
						<span class="db f24 qwert b mt20 mb25">БЫСТРОЕ ОФОРМЛЕНИЕ ЗАКАЗА</span>
						<div class="form cart_form">
							{if $error}
								<div class="message_error">
									{if $error == 'empty_name'}Введите имя{/if}
									{if $error == 'empty_email'}Введите email{/if}
									{if $error == 'captcha'}Капча введена неверно {$captcha} ;{/if}
								</div>
							{/if}
						</div>
						
						
						<div class="w412 fl">
						
							<span class="f16 db str">Ваше имя (Как к Вам обращаться):</span>
							<input name="name" type="text" value="{$name|escape}" data-format=".+" data-notice="Введите имя" class="pole mb20"/>
							
							<span class="f16 db">E-mail (Для сопровождения заказа):</span>
							<input name="email" type="text" value="{$email|escape}" data-format="email" data-notice="Введите email" class="pole mb20" />
							
							<span class="f16 db str">Телефон (Чтобы с Вами связаться):</span>
							<input name="phone" type="text" value="{$phone|escape}" class="pole mb20" />
							
							<span class="f16 db str">Адрес (Куда Вам доставить заказ):</span>
							<input name="address" type="text" value="{$address|escape}" class="pole mb20" />
							<span class="f16 db polk">*Поля обязательные для заполнения :</span>
							
						</div>
						
						<div class="fl ml40">
							<div class="dtc vab h355">
								<span class="f16 db">Комментарий к заказу:</span>
								<textarea name="comment" id="order_comment" class="pole mb20 h121 pt5">{$comment|escape}</textarea>
							</div>
						</div>
						
						<div class="cl"></div>
						
						<div class="captcha">
							<img src="/captcha/image.php?{math equation='rand(10,10000)'}" alt='captcha'/>
						</div>
						
						<span class="f16 db str w190">Введите код проверки:</span>
						<input class="input_captcha" id="comment_captcha" type="text" name="captcha_code" value="" data-format="\d\d\d\d" data-notice="Введите капчу"/>
						
						<div class="cl"></div>
						
						<input type="submit" name="checkout" class="more_btn db br3 fl f16 lh38 min_btn w180 b h40 mt10 bn cp" value="Оформить заказ">
						
					</div>
					
					<span class="ttu db fl f16 sum b">СУММА ЗАКАЗА:</span>
					<del class="rub2 fl b f20 db mt17 ml10">P</del>
					<span class="price2 fl db ml15 f20 mt20 w100">{$cart->total_price|convert}&nbsp;{$currency->sign}</span>
					<input type="checkbox" style=" margin: 24px 0 0 16px;">
					<span class="fl f15 pa podp">Оформить подписку, первым узнавать об акциях и предложениях</span>
					
				</div>
				
			</form>
			
			<div class="cl"></div>
		{else}
			<span class="mt5 ml10 mb10 db">В корзине нет товаров</span>
		{/if}
		
	</div>
</div>

<div class="cl"></div>
<div class="category_title mb30">
	<span>У НАС ПОКУПАТЬ ЛЕГКО!</span>
</div>
<div class="shadow_div"></div>
<ul class="razn">
	<li>Заказ</li>
	<li>Сопровождение</li>
	<li>Доставка</li>
</ul>
<div class="cl"></div>
<ul class="ul_amalker">
	<li>
		<div class="dtc vam h130">
			<img src="/design/{$settings->theme}/images/icon_zakaz.png" alt="zakaz" class="fl mt4 zalupen"/>
			<div class="fl add_zalupen1">
				<span class="db f16 b">Заказывай товар на сайте.</span>
				<span class="db f24 b">(8652) 51-17-77</span>
				<span class="db f16 b">Бесплатная консультация.</span>
			</div>
		</div>
	</li>
	<li class="podpizden">
		<div class="dtc vam h130">
			<img src="/design/{$settings->theme}/images/soprovogd.png" alt="zakaz" class="fl mt12 zalupen2"/>
			<div class="fl pl25">
				<span class="db f15 b bliat_zaebalsia_eto_rovniat">C вами свяжется наш<br />
					консультант, подтвердит<br />
					заказ. Уточнит способ и <br />
					сроки доставки.
				</span>
			</div>
		</div>
	</li>
	<li class="hrdde">
		<div class="dtc vam h130">
			<img src="/design/{$settings->theme}/images/dost.png" alt="zakaz" class="fl ebaa" />
			<div class="fl">
				<span class="db f15 b rovno">Наша служба доставит вам<br />
					товар вовремя.Оплата<br />
					наличными курьеру или<br />
					на сайте
				</span>
			</div>
		</div>
	</li>
</ul>
<div class="cl"></div>