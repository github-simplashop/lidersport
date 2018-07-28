{$meta_title = "Корзина" scope=parent}

<div class="cart">
	<div class="cart__wrapper wrapper">
		<a href="/" class="header__logo cart__logo">
			<img src="/design/{$settings->theme}/images/logo.png" alt="logo">
		</a>
		<a href="tel:+78652221577" class="footer__phone cart__phone">8 (8652) 22-15-77</a>
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
				<!------- Шаг 1 Способ получения -------->
				<div class="cart__block">


                    {if $deliveries}

						<div class="cart__deliverie deliverie sposob-polucheniya" style="display: none">
							<p class="deliverie__title">ШАГ 1. ВЫБЕРИТЕ СПОСОБ ПОЛУЧЕНИЯ ЗАКАЗА:</p>
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
							<input type="button" name="changeform" class="issue__send" id="dostavka-button" value="Продолжить">
							<input type="button" name="changeform" class="issue__send" id="samovyvoz-button" value="Продолжить" style="display: none;">
						</div>

						<div class="changeShop">
							<p class="deliverie__title mag_list">Список магазинов:</p>
							<form class="map__list">


								<p><input type="radio" style="margin-left: -18px;" name="shop_id" id="mag1" value="1"><label for="mag1">Магазин «Лидерспорт»<br>ул. Макарова, д. 26, стр Б.<br>Телефон: <a href="tel:+78652221577" class="map__link">22-15-77</a>
										<br>Время работы:<br> без выходных, с 9:00 до 20:00.</label></p>

								<p><input type="radio" style="margin-left: -18px;" name="shop_id" id="mag2" value="2"><label for="mag2">Магазин «Лидерспорт»<br>
										ул. Серова 486/1<br>Телефон: <a href="tel:+78652221577" class="map__link">22-15-77</a><br>Время работы:<br> без выходных, с 9:00 до 20:00.</label></p>


								<p><input type="radio" style="margin-left: -18px;" name="shop_id" id="mag3" value="3"><label for="mag3">Магазин «Лидерспорт»<br>ул. Мира 334<br>Телефон: <a href="tel:+78652221577" class="map__link">22-15-77</a><br>Время работы:<br> без выходных, с 9:00 до 20:00.</label></p>


								<p><input type="radio" style="margin-left: -18px;" name="shop_id" id="mag4" value="4"><label for="mag4">Магазин «Лидерспорт»<br>ул. Тухачевского 20/1<br>Телефон: <a href="tel:+78652221577" class="map__link">22-15-77</a><br>Время работы:<br> без выходных, с 9:00 до 20:00.</label></p>

								<p><input type="radio" style="margin-left: -18px;" name="shop_id" id="mag5" value="5"><label for="mag5">Магазин «Лидерспорт»<br>ТЦ Пассаж, 1 этаж<br>Телефон: <a href="tel:+78652221577" class="map__link">22-15-77</a><br>Время работы:<br> без выходных, с 9:00 до 20:00.</label></p>

                                {*<p><input type="radio" style="margin-left: -18px;" name="shop_id" id="mag6" value="6"><label for="mag6">Прокат и сервис велосипедов<br>пл. Ленина, ст. Динамо<br>Телефон: <a href="tel:+78652221577" class="map__link">22-15-77</a><br>Время работы:<br> без выходных, с 9:00 до 20:00.</label></p>*}

							</form>
						</div>

                    {/if}
					<!------- 1 end -------->

					<!------- Шаг 0 Поле: имя телефон промокод -------->
					<div class="cart__issue issue" id="firstStep">
						<form class="firstForm">
							<!-- <p class="issue__title">Быстрое оформление заказа</p> -->
							<input name="tovar" type="text" value="{$purchase->product->name|escape}" data-format=".+" style="display: none;" id="inputTovar">
							<p class="issue__caption">* Ваше имя (Как к Вам обращаться):</p> <span id="pleaseInputName" class="red_text">Пожалуйста введите имя</span>
							<input name="name" type="text" value="{$name|escape}" data-format=".+" data-notice="Введите имя" class="issue__input" id="inputName" required>

							<p class="issue__caption">* Телефон (Чтобы с Вами связаться):</p> <span id="pleaseInputPhone" class="red_text">Пожалуйста введите корректый телефон</span>
							<input name="phone" type="text" value="{$phone|escape}" class="issue__input" id="inputPhone" required>
							<div>
								<input id="promo_cod" class="captcha__input" type="text" name="promo_code"  maxlength="4" placeholder="Промокод" data-format="\d\d\d\d" data-notice="Введите промокод">
							</div>

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
											<input type="button" name="apply_coupon"  value="Применить купон" onclick="document.cart.submit();">
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
                                    $("input[name='coupon_code']").keypress(function(event){
                                        if(event.keyCode == 13){
                                            $("input[name='name']").attr('data-format', '');
                                            $("input[name='email']").attr('data-format', '');
                                            document.cart.submit();
                                        }
                                    });
								</script>
                            {/literal}

                            {/if}

							<p><input type="checkbox" style="position: relative; top: 15px; margin: 0;" required checked id="inputPers">	<p class= "checkcheck">Я даю свое согласие на обработку персональных данных
								и соглашаюсь с условиями и <a href="/confid">политикой конфиденциальности</a></p><span id="pleaseInputPers" class="red_text" style="margin-top: -10px;">Вы должны должны подтвердить согласие на обработку персональных данных</span>

							<input type="button" name="changeform" class="issue__send" id="changeform" value="Оформить" style="margin-bottom: 100px;">

						</form>
						<!-- <p class="issue__caption">* Ваше имя (Как к Вам обращаться):</p>
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
				<p><input type="checkbox" style="position: relative; top: 3px; margin: 0;">	Оформить подписку, первым узнавать об акциях и предложениях</p> -->







					</div>
					<!--------- 0 end ----------->


					<!--------- Шаг 2-1(Если выбран самовывоз) Поле: имя номер мэйл коммент -->
					<div class="cart__issue issue forma-samovyvoz" style="display: none; margin-bottom: 20px; padding-top: 80px;">
						<p class="deliverie__title">ШАГ 2. ЗАПОЛНИТЕ ДАННЫЕ ДЛЯ ДОСТАВКИ</p>
						<p class="issue__caption">* Ваше имя (Как к Вам обращаться):</p> <span id="pleaseInputName1" class="red_text">Пожалуйста введите имя</span>
						<input name="name" type="text" value="{$name|escape}" data-format=".+" data-notice="Введите имя" class="issue__input"  id="inputNameForm3">
						<p class="issue__caption">* E-mail (Для сопровождения заказа):</p><span id="pleaseInputEmail1" class="red_text">Пожалуйста введите корректный E-mail</span>
						<input name="email" type="text" value="{$email|escape}" data-format="email" data-notice="Введите email" class="issue__input" id="inputMailForm3">
						<p class="issue__caption">* Телефон (Чтобы с Вами связаться):</p><span id="pleaseInputPhone1" class="red_text">Пожалуйста введите корректный телефон</span>
						<input name="phone" type="text" value="{$phone|escape}" class="issue__input" id="inputPhoneForm3">
						<p class="issue__caption">Комментарий к заказу:</p>
						<textarea name="comment" id="order_commentForm3" class="issue__textarea">{$comment|escape}</textarea>
						<p class="issue__hint">* - Поля обязательные для заполнения</p>
						<!-- Кнопка перехода на ордер -->
						<input type="button" name="back" class="issue__send nextOrder back1" value="Назад" id="back1">
						<input type="button" name="checkout" class="issue__send nextOrder" value="Продолжить" id="nextOrderForm3">

					</div>

					<!-- 2-1 end -->
					<!-- Шаг 2-2(если выбран курьерская или транспортная) Поле: имя номер мэйл коммент + адрес доставки  -->
					<div class="cart__issue issue forma-dostavka" style="display: none; margin-bottom: 20px; padding-top: 80px;">
						<p class="deliverie__title">ШАГ 2. ЗАПОЛНИТЕ ДАННЫЕ ДЛЯ ДОСТАВКИ</p>
						<p class="issue__caption">* Ваше имя (Как к Вам обращаться):</p><span id="pleaseInputName2" class="red_text">Пожалуйста введите имя</span>
						<input name="name" type="text" value="{$name|escape}" data-format=".+" data-notice="Введите имя" class="issue__input"  id="inputNameForm2">
						<p class="issue__caption">* E-mail (Для сопровождения заказа):</p><span id="pleaseInputEmail2" class="red_text">Пожалуйста введите корректный E-mail</span>
						<input name="email" type="text" value="{$email|escape}" data-format="email" data-notice="Введите email" class="issue__input"  id="inputMailForm2">
						<p class="issue__caption">* Телефон (Чтобы с Вами связаться):</p><span id="pleaseInputPhone2" class="red_text">Пожалуйста введите корректный телефон</span>
						<input name="phone" type="text" value="{$phone|escape}" class="issue__input" id="inputPhoneForm2">
						<p class="issue__caption">* Адрес (Куда Вам доставить заказ):</p><span id="pleaseInputAddress2" class="red_text">Пожалуйста введите адрес</span>
						<input name="address" type="text" value="{$address|escape}" class="issue__input"  id="inputAdressForm2">
						<p class="issue__caption">Комментарий к заказу:</p>
						<textarea name="comment" id="order_commentForm2" class="issue__textarea">{$comment|escape}</textarea>
						<p class="issue__hint">* - Поля обязательные для заполнения</p>
						<!-- Кнопка перехода на ордер -->
						<input type="button" name="back" class="issue__send nextOrder back1" value="Назад" id="back2">
						<input type="button" name="checkout" class="issue__send" value="Продолжить" id="nextOrderForm2">

					</div>
					<!-- 2-2 end -->



			</form>
        {else}
			<span>В корзине нет товаров</span>
        {/if}


	</div>
</div>

{literal}
<script type="text/javascript">

</script>
{/literal}</div>


<!---------------->