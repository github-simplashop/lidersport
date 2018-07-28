	{$meta_title = "Оформление заказа" scope=parent}

<div class="order order_my">
	{*<div class="wrapper__order wrapper">*}

    <div class="wrapper__order wrapper">
        <a href="/" class="header__logo cart__logo">
            <img src="/design/{$settings->theme}/images/logo.png" alt="logo">
          </a>
 <a href="tel:+78652990059" class="footer__phone cart__phone">8 (8652) 99-00-59</a>

	</div>

		{if !$order->paid}
<div class="hidden-order3">

	<div class="order__deliverie">
		<div class="cart__deliverie__inner cart__deliverie__inner__step-one">

			<div class="cart__deliverie__step cart__deliverie__step-one">
				<div class="wrapper step__title">
					<div class="step__list">1</div>
					<span class="step__name">Способ получения</span>
				</div>
				<div class="step__body">
				</div>
			</div>

		</div>

		<div class="cart__deliverie__inner cart__deliverie__inner__step-two">

			<div class="cart__deliverie__step cart__deliverie__step-two">
				<div class="wrapper step__title">
					<div class="step__list">2</div>
					<span class="step__name">Контактные данные</span>
				</div>
				<div class="step__body">
				</div>
			</div>

		</div>

		<div class="cart__deliverie__inner cart__deliverie__inner__step-three cart__deliverie__inner--active">

			<div class="cart__deliverie__step cart__deliverie__step-three">
				<div class="wrapper step__title">
					<div class="step__list">3</div>
					<span class="step__name">Способ оплаты</span>
				</div>
				<div class="step__body">
						{* Выбор способа оплаты *}
						{if $payment_methods && !$payment_method && $order->total_price>0}
							<div class="wrapper">
							<form method="post" class="pay">
								{*<h2 class="pay__title">ШАГ 3. Выберите способ оплаты</h2>*}
								<ul id="deliveries" class="pay__list">
									{foreach $payment_methods as $payment_method}
										<li class="pay__item">
											<input class="pay__radio" type="radio" name="payment_method_id" value="{$payment_method->id}" {if $payment_method@first}checked{/if} id="payment_{$payment_method->id}">
											<label class="pay__label" for="payment_{$payment_method->id}">	{$payment_method->name}, к оплате {$order->total_price|convert:$payment_method->currency_id} {$all_currencies[$payment_method->currency_id]->sign}.</label>
											{*<div class="pay__description">{$payment_method->description}</div>*}
										</li>
									{/foreach}
								</ul>
                                {$address = explode(",", $order->address)}
                                {if $order->delivery_id > 1 || $address[0] != "Ставрополь"}
									<div class="cart__delivery__alert">
										<i class="fa fa-exclamation-circle" aria-hidden="true"> </i> <span>ОБРАТИТЕ ВНИМАНИЕ</span> Доставка оплачивается отдельно, стоимость и сроки доставки уточняйте у менеджеров.
									</div>
								{/if}

								{*<a href="#" class="netpaybutton buttonred" style="padding:9px 5px 9px 15px; text-decoration: none; width: 100px; height: 20px; display: block" id="orderEnd">Завершить</a>*}
								<div class="cart__delivery__next">
									<input type="button" name="new_changeform" class="issue__send" id="orderEnd" value="Продолжить оформление">
									<input type="submit" name="Submit" class="netpaybutton buttonred" value="Продолжить оформление" style="display: none;" id="orderNext">
								</div>

								<!-- {checkout_form order_id=$order->id module=$payment_method->module} -->


							</form>
							</div>
						{elseif $payment_method}
						<div class="order__deliverie__inner">
							<div class="wrapper">
								{* Выбраный способ оплаты *}
								<h2 class="order__title">Пожалуйста, проверьте детали заказа.</h2>
								<p>Способ оплаты &mdash; {$payment_method->name}</p>
								<p>Для проведения платежа далее Вы будете переведены на страницу оплаты платёжной системы Net Pay</p>
								{*<p></p><p><strong><img src="/files/uploads/visa-mastercard-maestro.jpg" alt="paynet" title="visa" height="39" width="250"></strong></p><p></p>*}
								<!-- <p>{$payment_method->description}</p> -->
								<form method="post">
									<input type="submit" name="reset_payment_method" value="Выбрать другой способ оплаты" class="changePayType">
								</form>



								<!------------ Детали заказа ---------------->
								<div style="display: block">
									<p class="o-purchases__point o-purchases__point--total" style="margin: 40px 0 10px 0;"> Детали заказа:</p>
									<h1 class="order__title">Ваш заказ № {$order->id}
                                        {if $order->status == 0}принят{/if}
                                        {if $order->status == 1}в обработке{elseif $order->status == 2}выполнен{/if}
                                        {if $order->paid == 1}, оплачен{else}{/if}
									</h1>

									<div id="purchases" class="o-purchases" style="margin-bottom: 0;">
										{foreach $purchases as $purchase}

									<div class="o-purchases__item">
												{$image = $purchase->product->images|first}
												{if $image}
													<a href="products/{$purchase->product->url}" class="o-purchases__image">
														<img src="{$image->filename|resize:50:50}" alt="{$product->name|escape}">
													</a>
												{/if}
												<a href="/products/{$purchase->product->url}" class="o-purchases__name">{$purchase->product_name|escape}</a>
												{$purchase->variant_name|escape}
												{if $order->paid && $purchase->variant->attachment}
													<a class="o-purchases__download" href="order/{$order->url}/{$purchase->variant->attachment}">скачать файл</a>
												{/if}

										<span class="o-purchases__info">
											<span class="order__price__new">{(($purchase->price) - $purchase->sale_price)|convert} {$currency->sign}.</span>
												{if $purchase->sale_price != 0}
													<span class="order__price__old">{$purchase->price|convert} {$currency->sign}.</span>
											&times; {$purchase->amount} {$settings->units}. = <span class="order__price__total">{(($purchase->price - $purchase->sale_price)*$purchase->amount)|convert} {$currency->sign}.</span></span>
												{else}
									&times; {$purchase->amount} {$settings->units}. = <span class="order__price__total">{($purchase->price*$purchase->amount)|convert} {$currency->sign}.</span></span>
												{/if}
											</div>
										{/foreach}

										<!-- <p class="o-purchases__result">
										{* Скидка, если есть *}
										{if $order->discount > 0}
											<span class="o-purchases__point">Скидка: {$order->discount}%</span>
										{/if}

										{* Купон, если есть *}
										{if $order->coupon_discount > 0}
											<span class="o-purchases__point">Купон: {$order->coupon_discount|convert} {$currency->sign}</span>
										{/if}

										{* Если стоимость доставки входит в сумму заказа *}
										{if !$order->separate_delivery && $order->delivery_price>0}
											<span class="o-purchases__point">{$delivery->name|escape} - {$order->delivery_price|convert} {$currency->sign}.</span>
										{/if}

										{* Итого *}
										<span class="o-purchases__point o-purchases__point--total">Итого: {$order->total_price|convert} {$currency->sign}.</span>

										{* Если стоимость доставки не входит в сумму заказа *}
										{if $order->separate_delivery}
											<span class="o-purchases__point">{$delivery->name|escape} {$order->delivery_price|convert} {$currency->sign}.</span>
										{/if}
									</p> -->
									</div>


									{* Детали заказа *}
									<!-- <h2 class="order__title">Детали заказа</h2> -->
									<table class="order__details">
										<tr>
											<td>Дата заказа</td>
											<td>{$order->date|date} в {$order->date|time}</td>
										</tr>
										{if $order->name}
											<tr>
												<td>Имя</td>
												<td>{$order->name|escape}</td>
											</tr>
										{/if}
										{if $order->email}
											<tr>
												<td>Email</td>
												<td>{$order->email|escape}</td>
											</tr>
										{/if}
										{if $order->phone}
											<tr>
												<td>Телефон</td>
												<td>{$order->phone|escape}</td>
											</tr>
										{/if}
										{if $order->address}
											<tr>
												<td>Адрес доставки</td>
												<td>{$order->address|escape}</td>
											</tr>
										{/if}
										{if $order->comment}
											<tr>
												<td>Комментарий</td>
												<td>{$order->comment|escape|nl2br}</td>
											</tr>
										{/if}
									</table>

								<!------------ Детали заказа конец---------------->

								<span class="o-purchases__point o-purchases__point--total" style="margin: -40px 0 10px 0;;">К оплате: {$order->total_price|convert:$payment_method->currency_id} {$all_currencies[$payment_method]}руб.</span>

								{if $order->coupon_discount > 0}
									<span class="o-purchases__point__sale--total">Скидка {$order->coupon_discount|convert} {$currency->sign}.</span>
								{/if}
								</div>
								{* Форма оплаты, генерируется модулем оплаты *}





							</div>

						<div class="wrapper cart__delivery__next">
							{checkout_form order_id=$order->id module=$payment_method->module}
						</div>
						{/if}
						{/if}
						<!-- <input type="button" class="pay__button" value="Продолжить" id="change-sposob"> -->

					</div>
				</div>
			</div>

		</div>

	</div>



</div>
<!-- прослойка наличка -->
<div class="prosloikaCash wrapper" style="display: none; ">
<p> Спасибо, {$order->name|escape}, Ваш заказ оформлен, подробности заказа высланы на Вашу почту {$order->email|escape}</p><p> ЧЕРЕЗ НЕСКОЛЬКО СЕКУНД ВЫ БУДЕТЕ ПЕРЕНАПРАВЛЕНЫ НА ГЛАВНУЮ СТРАНИЦУ </p>
</div>
<!-- прослойка end -->

<!-- прослойка онлайн -->
<div class="prosloikaOnline wrapper" style="display: none; ">
<p> Спасибо, {$order->name|escape}, Ваш заказ оформлен, подробности заказа высланы на Вашу почту {$order->email|escape}</p><p> ЧЕРЕЗ НЕСКОЛЬКО СЕКУНД ВЫ БУДЕТЕ ПЕРЕНАПРАВЛЕНЫ НА СТРАНИЦУ ОПЛАТЫ </p>
</div> 
<!-- прослойка end -->     
	{*</div>*}

</div>



{literal}
<script type="text/javascript">
$('.header__middle').css({'background-image': 'none'}); 
$('.header').css({'display' : 'none'});
$('.cart__phone, .cart__logo').css({'display': 'block'}); 
//setTimeout(function() {
//$('.footer').css({'display' : 'none'});
//}, 100);
</script>
{/literal}

   <!--       НА БУДУЩЕЕ
   
    -->