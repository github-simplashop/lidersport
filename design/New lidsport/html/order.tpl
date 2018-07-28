<div class="order">
	<div class="wrapper__order wrapper">
		<h1 class="order__title">Ваш заказ №{$order->id} 
			{if $order->status == 0}принят{/if}
			{if $order->status == 1}в обработке{elseif $order->status == 2}выполнен{/if}
			{if $order->paid == 1}, оплачен{else}{/if}
		</h1>
		
		<div id="purchases" class="o-purchases">
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
					<span class="o-purchases__info">{($purchase->price)|convert} {$currency->sign}.	&times; {$purchase->amount} {$settings->units}. = {($purchase->price*$purchase->amount)|convert} {$currency->sign}.</span>
				</div>
			{/foreach}

			<p class="o-purchases__result">
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
			</p>
		</div>

		{* Детали заказа *}
		<h2 class="order__title">Детали заказа</h2>
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

		{if !$order->paid}

			{* Выбор способа оплаты *}
			{if $payment_methods && !$payment_method && $order->total_price>0}
				<form method="post" class="pay">
					<h2 class="pay__title">Выберите способ оплаты</h2>
					<ul id="deliveries" class="pay__list">
						{foreach $payment_methods as $payment_method}
							<li class="pay__item">
								<input class="pay__radio" type="radio" name="payment_method_id" value="{$payment_method->id}" {if $payment_method@first}checked{/if} id="payment_{$payment_method->id}">
								<label class="pay__label" for="payment_{$payment_method->id}">	{$payment_method->name}, к оплате {$order->total_price|convert:$payment_method->currency_id} {$all_currencies[$payment_method->currency_id]->sign}.</label>
								<div class="pay__description">{$payment_method->description}</div>
							</li>
						{/foreach}
					</ul>
					<input type="submit" class="pay__button" value="Закончить заказ">
				</form>
			
			{elseif $payment_method}
			{* Выбраный способ оплаты *}
				<h2 class="order__title">Способ оплаты &mdash; {$payment_method->name}</h2>
				<form method="post">
					<input type="submit" name="reset_payment_method" value="Выбрать другой способ оплаты" class="order__button">
				</form>	
				
				<p>{$payment_method->description}</p>
				
				К оплате: {$order->total_price|convert:$payment_method->currency_id} {$all_currencies[$payment_method]}

				{* Форма оплаты, генерируется модулем оплаты *}
				{checkout_form order_id=$order->id module=$payment_method->module}
			{/if}
		{/if}
	</div>
</div>