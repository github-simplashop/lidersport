{$meta_title = "Корзина" scope=parent}
<div class="cart">
	<div class="cart__wrapper wrapper">
		<h1 class="cart__title">Корзина</h1>
		{if $cart->purchases}
		<form method="post" name="cart" class="cart__form cart_page mb20">
			<ul id="purchases" class="cart__list">
				{foreach from=$cart->purchases item=purchase}
					<li class="cart__item">
						<div class="cart__image">
							{$image = $purchase->product->images|first}
							<a href="/products/{$purchase->product->url}">
								{if $purchase->product->imagesc}
									<img src="/images1c/{$purchase->product->imagesc}" alt="{$product->name|escape}">
								{else}
									{if $image}
										<img src="{$image->filename|resize:179:139}" alt="{$product->name|escape}">
									{else}
										<img src="/design/lidsport/images/defaultPhoto.png" alt="{$product->name|escape}">
									{/if}
								{/if}
							</a>
						</div>

						<div class="cart__name">
							<a href="/products/{$purchase->product->url}">
								{$purchase->product->name|escape}
							</a>       
							<span>{$purchase->variant->name|escape}</span>
						</div>

						<div class="cart__delete">
							<a href="/cart/remove/{$purchase->variant->id}">
								<img src="/design/{$settings->theme}/images/ico/close_mobile_menu.svg" alt="delete">
							</a>
						</div>
						
						<div class="cart__price">
							<span class="cart__label">Стоимость:</span>
							<p>{($purchase->variant->price*$purchase->amount)|convert} <i class="fa fa-rub"></i></p>
						</div>
						
						<div class="cart__value">
							<span class="cart__label">Количество:</span>
							<select name="amounts[{$purchase->variant->id}]" onchange="document.cart.submit();">
								{section name=amounts start=1 loop=$purchase->variant->stock+1 step=1}
								<option value="{$smarty.section.amounts.index}"
									{if $purchase->amount==$smarty.section.amounts.index}selected{/if}>
									{$smarty.section.amounts.index}
									{$settings->units}
								</option>
								{/section}
							</select>
						</div>
					</li>
				{/foreach}
			</ul>
			<p class="cart__total">
				{if $cart->purchases}
					В корзине {$cart->total_products} {$cart->total_products|plural:'товар':'товаров':'товара'} общей стоимостью - {$cart->total_price|convert} <i class="fa fa-rub"></i>
					{if $user->discount}
						<br><span>скидка - {$user->discount}%</span>
					{/if}
				{else}
					Корзина пуста
				{/if}
			</p>

			<div class="cart__block">
				{if $deliveries}
					<div class="cart__deliverie deliverie">
						<p class="deliverie__title">Способ получения:</p>
						<ul id="deliveries" class="deliverie__list">
							{foreach $deliveries as $delivery}
								<li class="deliverie__item">
									<input type="radio" name="delivery_id" value="{$delivery->id}" id="deliveries_{$delivery->id}" {if $delivery_id==$delivery->id}checked{elseif $delivery@first}checked{/if}>
									<label for="deliveries_{$delivery->id}">
										{$delivery->name}
										{if $cart->total_price < $delivery->free_from && $delivery->price>0}
											({$delivery->price|convert} {$currency->sign})
										{elseif $cart->total_price >= $delivery->free_from}
											(бесплатно)
										{/if}
									</label>
									<div class="deliverie__description">{$delivery->description}</div>
								</li>
							{/foreach}
						</ul>
					</div>
				{/if}

				<div class="cart__issue issue">
					<p class="issue__title">Быстрое оформление заказа</p>
					{if $error}
						<div class="issue__error">
							{if $error == 'empty_name'}Введите имя{/if}
							{if $error == 'empty_email'}Введите email{/if}
							{if $error == 'captcha'}Капча введена неверно{/if}
						</div>
					{/if}

					<p class="issue__caption">* Ваше имя (Как к Вам обращаться):</p>
					<input name="name" type="text" value="{$name|escape}" data-format=".+" data-notice="Введите имя" class="issue__input">
					<p class="issue__caption">E-mail (Для сопровождения заказа):</p>
					<input name="email" type="text" value="{$email|escape}" data-format="email" data-notice="Введите email" class="issue__input">
					<p class="issue__caption">* Телефон (Чтобы с Вами связаться):</p>
					<input name="phone" type="text" value="{$phone|escape}" class="issue__input">
					<p class="issue__caption">* Адрес (Куда Вам доставить заказ):</p>
					<input name="address" type="text" value="{$address|escape}" class="issue__input">
					<p class="issue__caption">Комментарий к заказу:</p>
					<textarea name="comment" id="order_comment" class="issue__textarea">{$comment|escape}</textarea>
					<p class="issue__hint">* - Поля обязательные для заполнения</p>

					<div class="issue__captcha captcha">
						<input id="comment_captcha" class="captcha__input" type="text" name="captcha_code" placeholder="Введите код" data-format="\d\d\d\d" data-notice="Введите капчу">
						<img src="/captcha/image.php?{math equation='rand(10,10000)'}&type=cart" alt="captcha" class="captcha__image">
					</div> 

				<p class="issue__total">Сумма заказа: <span>{$cart->total_price|convert} {$currency->sign}</span></p>
				<p><input type="checkbox" style="position: relative; top: 3px; margin: 0;">	Оформить подписку, первым узнавать об акциях и предложениях</p>
				<input type="submit" name="checkout" class="issue__send" value="Оформить заказ">
			</div>

		</form>
		{else}
			<span>В корзине нет товаров</span>
		{/if}

	</div>
</div>