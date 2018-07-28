{$meta_title = "Корзина" scope=parent}

<div class="cart">
	<div class="cart__wrapper wrapper cart__wrapper__header">
		<a href="/" class="header__logo cart__logo">
			<img src="/design/{$settings->theme}/images/logo.png" alt="logo">
		</a>
		<a href="tel:+78652221577" class="footer__phone cart__phone">8 (8652) 22-15-77</a>
		<h1 class="cart__title">Корзина</h1>
    </div>

        {if $cart->purchases}

            <form method="post" name="cart" class="cart__form cart_page mb20">
                <div class="cart__wrapper wrapper">
                <ul id="purchases" class="cart__list">

                    {foreach $cart->purchases as $purchase}
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
                                {foreach $cart->discount_text as $key=>$cdt}
                                    {if $purchase->product->id == $key}
                                        {if ($cdt > 0)}
                                            {if $cart->coupon}
                                                <p class="cart__coupon-status">Скидка {($cdt|convert / ($purchase->variant->price * $purchase->amount|convert / 100) )|convert} % по промокоду</p>
                                            {else}
                                                <p class="cart__coupon-status">Скидка {($cdt|convert / ($purchase->variant->price * $purchase->amount|convert / 100) )|convert} % за покупку через сайт </p>
                                            {/if}
                                        {else}
                                            <p class="cart__coupon-status">На данный товар скидка не распространяется</p>
                                        {/if}
                                    {/if}
                                {/foreach}
                            </div>

                            <div class="cart__price">
                                <span class="cart__label">Цена</span>
                                <div class="cart__body">
                                    {if $cart->discount_text}
                                        {foreach $cart->discount_text as $key=>$cdt}
                                            {if $purchase->product->id == $key}
                                                {if ($cdt > 0)}
                                                    <span class="cart__price__new"> {($purchase->variant->price - ($cdt/$purchase->amount))|convert} <i class="fa fa-rub"></i></span>
                                                    <span class="cart__price__old">{$purchase->variant->price|convert} <i class="fa fa-rub"></i></span>
                                                {else}
                                                    <span class="cart__price__new">{$purchase->variant->price|convert} <i class="fa fa-rub"></i></span>
                                                {/if}


                                            {/if}
                                        {/foreach}
                                        {if $discount_item == "false"}
                                            <span>{($purchase->variant->price*$purchase->amount)|convert} <i class="fa fa-rub"></i></span>
                                        {/if}
                                    {else}
                                        <span>{($purchase->variant->price*$purchase->amount)|convert} <i class="fa fa-rub"></i></span>
                                    {/if}
                                </div>
                            </div>

                            <div class="cart__value">
                                <span class="cart__label">Количество</span>
                                <div class="cart__body">
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
                            </div>

                            <div class="card__amount">
                                <span class="shop_sclad" style="display: none">{$purchase->variant->shop_sclad}</span>
                                <span class="shop_makarova" style="display: none">{$purchase->variant->shop_makarova}</span>
                                <span class="shop_204" style="display: none">{$purchase->variant->shop_204}</span>
                                <span class="shop_mira" style="display: none">{$purchase->variant->shop_mira}</span>
                                <span class="shop_yog" style="display: none">{$purchase->variant->shop_yog}</span>
                                <span class="shop_passaj" style="display: none">{$purchase->variant->shop_passaj}</span>
                                <span class="shop_mihailovsk" style="display: none">{$purchase->variant->shop_sclad}</span>
                            </div>

                            <div class="cart__price">
                                <span class="cart__label">Всего</span>
                                <div class="cart__body">
                                    {if $cart->discount_text}
                                        {assign var="discount_item" value="false"}
                                        {foreach $cart->discount_text as $key=>$cdt}
                                            {if $purchase->product->id == $key}
                                                {if ($cdt > 0)}
                                                    <span class="cart__price__new"> {($purchase->variant->price*$purchase->amount - $cdt)|convert} <i class="fa fa-rub"></i></span>
                                                    <span class="cart__price__old"> {($purchase->variant->price*$purchase->amount)|convert} <i class="fa fa-rub"></i></span>
                                                    {assign var="discount_item" value="true"}
                                                {else}
                                                    <span class="cart__price__new">{($purchase->variant->price*$purchase->amount)|convert} <i class="fa fa-rub"></i></span>
                                                    {assign var="discount_item" value="not_sale"}
                                                {/if}


                                            {/if}
                                        {/foreach}
                                        {if $discount_item == "false"}
                                            <span>{($purchase->variant->price*$purchase->amount)|convert} <i class="fa fa-rub"></i></span>
                                        {/if}
                                    {else}
                                        <span>{($purchase->variant->price*$purchase->amount)|convert} <i class="fa fa-rub"></i></span>
                                    {/if}
                                </div>
                            </div>

                            <div class="cart__delete">
                                <a href="/cart/remove/{$purchase->variant->id}">
                                    <img src="/design/{$settings->theme}/images/ico/close_mobile_menu.svg" alt="delete">
                                </a>
                                {*<span data-remove ="/cart/remove/{$purchase->variant->id}">*}
                                    {*<img src="/design/{$settings->theme}/images/ico/close_mobile_menu.svg" alt="delete">*}
                                {*</span>*}
                            </div>

                        </li>
                    {/foreach}
                </ul>

                {if $coupon_request}
                    <div class="cart__coupon">
                        <div class="cart__coupon--active">
                            <div>
                                <input type="text" name="coupon_code" value="{$cart->coupon->code|escape}" class="cart__coupon__code" placeholder="Промокод">
                                <span name="apply_coupon" class="cart__coupon__apply">Применить</span>
                            </div>
                            {if $coupon_error}
                            <div class="message_error">

                                    {if $coupon_error == 'invalid'}Купон недействителен{/if}

                            </div>
                            {/if}
                            {if $cart->coupon->min_order_price>0}
                                <div>
                                    (купон {$cart->coupon->code|escape} действует для заказов от {$cart->coupon->min_order_price|convert} {$currency->sign})
                                </div>
                            {/if}
                        </div>
                        {*<div class="cart__coupon--open">*}
                            {*<span>Есть промокод?</span>*}
                        {*</div>*}

                    </div>

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

                <p class="cart__total">
                    {if $cart->purchases}
                        {*В корзине {$cart->total_products} {$cart->total_products|plural:'товар':'товаров':'товара'} общей стоимостью - {$cart->total_price|convert} <i class="fa fa-rub"></i>*}
                        Итого:
                        {if $user->discount}
                            <span>{$user->discount|convert}%</span>
                        {/if}
                        <span  class="cart__price__new">{$cart->total_price|convert} <i class="fa fa-rub"></i></span>
                        {if $coupon_request && $cart->coupon_discount > 0}
                            <span  class="cart__price__old">{($cart->total_price + $cart->coupon_discount)|convert}&nbsp;<i class="fa fa-rub"></i></span>
                        {/if}

                        {if ($cart->coupon_discount)}
                            {if $cart->coupon}
                                <span class="cart__coupon-status">Скидка {$cart->coupon_discount|convert} <i class="fa fa-rub"></i> по промокоду</span>
                            {else}
                                <span class="cart__coupon-status">Скидка {$cart->coupon_discount|convert} <i class="fa fa-rub"></i> за покупку через сайт </span>
                            {/if}
                        {else}

                        {/if}
                    {else}
                        Корзина пуста
                    {/if}
                </p>

                    <!------- Шаг 0 Поле: имя телефон -------->

                    <div class="cart__issue issue">
                        <div class="firstForm">

                            <input name="tovar" type="text" value="{$purchase->product->name|escape}" data-format=".+" style="display: none;" id="inputTovar">
                            <p class="issue__caption">Имя*</p> <span class="red_text" id="pleaseInputName" >Пожалуйста введите имя</span>
                            <input name="name" type="text" value="{$name|escape}" data-format=".+" data-notice="Введите имя" class="issue__input" id="inputName" required>

                            <p class="issue__caption">Телефон*</p> <span class="red_text" id="pleaseInputPhone">Пожалуйста введите корректый телефон</span>
                            <input name="phone" type="text" value="{$phone|escape}" class="issue__input" id="inputPhone" required>

                            <div class="cart__issue__checkcheck">
                                <span class="red_text" id="pleaseInputPers">Вы должны должны подтвердить согласие на обработку персональных данных</span>
                                <input type="checkbox" required checked id="inputPers">
                                <span class= "checkcheck">Я даю свое согласие на обработку персональных данных
                                и соглашаюсь с условиями и <a href="/confid">политикой конфиденциальности</a></span>
                            </div>

                            <input type="button" name="changeform" class="issue__send" id="changeform" value="Оформить заказ" style="margin-bottom: 100px;">

                        </div>

                    </div>

                    <!--------- 0 end ----------->

                </div>

                    <!------- Шаг 1 Способ получения -------->

                    {if $deliveries}

                        <div class="cart__deliverie">
                            <div class="cart__deliverie__inner cart__deliverie__inner__step-one cart__deliverie__inner--active">

                                    <div class="cart__deliverie__step cart__deliverie__step-one">
                                        <div class="wrapper step__title">
                                            <div class="step__list">1</div>
                                            <span class="step__name">Способ получения</span>
                                        </div>
                                        <div class="step__body">
                                            <div class="wrapper cart__deliverie__metods__wrapper">
                                                <div class="cart__deliverie__metods">
                                                    <div class="cart__deliverie__metod-item cart__deliverie__metod-item--active" id="cart__deliverie__metod__1">
                                                        <div class="metod-item__icon"></div>
                                                        <div class="metod-item__title">Самовывоз</div>
                                                    </div>
                                                    <div class="cart__deliverie__metod-item" id="cart__deliverie__metod__2">
                                                        <div class="metod-item__icon"></div>
                                                        <div class="metod-item__title">Курьером</div>
                                                    </div>
                                                    <div class="cart__deliverie__metod-item" id="cart__deliverie__metod__3">
                                                        <div class="metod-item__icon"></div>
                                                        <div class="metod-item__title">EMS</div>
                                                    </div>
                                                    <div class="cart__deliverie__metod-item" id="cart__deliverie__metod__4">
                                                        <div class="metod-item__icon"></div>
                                                        <div class="metod-item__title">Почта России</div>
                                                    </div>
                                                </div>

                                                <div class="cart__deliverie__choice-city p-regions__body--open">Ставрополь</div>
                                            </div>
                                            <div class="cart__deliverie__inner cart__deliverie__metods__body">
                                                <div class="wrapper">
                                                    <div class="cart__deliverie__metod__body cart__deliverie__metod__body__1">
                                                        <div class="cart__deliverie__shops">

                                                            <div class="cart__deliverie__shops__title">
                                                                <i class="fa fa-map-marker" aria-hidden="true"></i>
                                                                <div>Выберите магазин или пункт выдачи</div>
                                                            </div>

                                                            <div class="cart__deliverie__shops__body">

                                                            </div>

                                                        </div>
                                                        <div class="cart__deliverie__map-container" id="deliverie_map"></div>
                                                    </div>

                                                    <div class="cart__deliverie__metod__body cart__deliverie__metod__body__2">
                                                        <div>
                                                            <div class="metod__body__title">Доставка курьером до двери</div>
                                                            <div>При выборе данного способа доставки, на указанный Вами адрес приедет курьер и привезет Ваш заказ. Доставка осуществляется в рабочие дни после того, как заказ будет собран. <span class="page__delivery__cost">Стоимость доставки в среднем 500-1000 рублей (уточняется у менеджера).</span> Срок доставки 1-2 дня (в период праздников и распродаж срок доставки может увеличиваться).</div>
                                                        </div>
                                                    </div>

                                                    <div class="cart__deliverie__metod__body cart__deliverie__metod__body__3">
                                                        <div>
                                                            <div class="metod__body__title">Доставка EMS</div>
                                                            <div>EMS - курьерская доствка почты России. Средний срок доставки 3-8 дней в зависимости от региона, средняя стоимость: 500-800 рублей. Стоимость доставки зависит от Вашего местоположения, веса и габарита посылки, а также дополнительных опций и уточняется у менеджера.</div>
                                                        </div>
                                                    </div>

                                                    <div class="cart__deliverie__metod__body cart__deliverie__metod__body__4">
                                                        <div>
                                                            <div class="metod__body__title">Доставка почтой России</div>
                                                            <div>Средний срок доставки 5-14 дней в зависимости от региона, средняя стоимость: 200-400 рублей. Стоимость доставки зависит от Вашего местоположения, веса и габарита посылки, а также дополнительных опций и уточняется у менеджера.</div>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>

                                            <div class="wrapper cart__delivery__next">
                                                <input type="button" name="new_changeform" class="issue__send" id="samovyvoz-button" value="Продолжить оформление">
                                            </div>
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
                                        <div class="wrapper cart__deliverie__contacts__wrapper">
                                            <div class="cart__deliverie__contacts">

                                                <p class="deliverie__title">ШАГ 2. ЗАПОЛНИТЕ ДАННЫЕ ДЛЯ ДОСТАВКИ</p>

                                                <div class="cart__deliverie__contacts__left">
                                                    <p class="issue__caption">Имя*</p> <span id="pleaseInputName1" class="red_text">Пожалуйста введите имя</span>
                                                    <input name="name" type="text" value="{$name|escape}" data-format=".+" data-notice="Введите имя" class="issue__input" id="inputNameForm3">
                                                    <p class="issue__caption">Телефон*</p><span id="pleaseInputPhone1" class="red_text">Пожалуйста введите корректный телефон</span>
                                                    <input name="phone" type="text" value="{$phone|escape}" class="issue__input" id="inputPhoneForm3">
                                                    <p class="issue__caption">E-mail*</p><span id="pleaseInputEmail1" class="red_text">Пожалуйста введите корректный E-mail</span>
                                                    <input name="email" type="text" value="{$email|escape}" data-format="email" data-notice="Введите email" class="issue__input" id="inputMailForm3">
                                                    <p class="issue__caption">Комментарий к заказу</p>
                                                    <div class="cart__deliverie__contacts__textarea">
                                                        <textarea name="comment" id="order_commentForm3" class="issue__textarea">{$comment|escape}</textarea>
                                                        <p class="issue__hint">* - Поля обязательные для заполнения</p>
                                                    </div>
                                                </div>

                                                <div class="cart__deliverie__contacts__right">
                                                    <p class="issue__caption">Город*</p> <span id="pleaseInputCityForm3" class="red_text">Пожалуйста введите город</span>
                                                    <input name="city" type="text" value="" data-format=".+" data-notice="" class="issue__input"  id="inputCityForm3">
                                                    <p class="issue__caption">Улица*</p> <span id="pleaseInputStreetForm3" class="red_text">Пожалуйста введите улицу</span>
                                                    <input name="street" type="text" value="" data-format=".+" data-notice="" class="issue__input"  id="inputStreetForm3">

                                                    <div class="cart__deliverie__contacts__address-block">
                                                        <div>
                                                            <p class="issue__caption">Дом*</p> <span id="pleaseInputHomeForm3" class="red_text">Пожалуйста введите дом</span>
                                                            <input name="house" type="text" value="" data-format=".+" data-notice="" class="issue__input"  id="inputHomeForm3">
                                                        </div>

                                                        <div>
                                                            <p class="issue__caption">Корпус</p>
                                                            <input name="block" type="text" value="" data-format=".+" data-notice="" class="issue__input"  id="inputBlocForm3">
                                                        </div>

                                                        <div>
                                                            <p class="issue__caption">Квартира</p>
                                                            <input name="nomber" type="text" value="" data-format=".+" data-notice="" class="issue__input"  id="inputApartmentForm3">
                                                        </div>
                                                    </div>

                                                    <input name = "delivery_id" type="hidden" value="2" id="inputDelivery_idForm3">
                                                    <input name = "address" type="hidden" value="" id="inputAddressForm3">
                                                </div>

                                            </div>
                                        </div>

                                        <div class="wrapper cart__delivery__next">
                                            <input type="button" name="checkout" class="issue__send nextOrder" value="Продолжить оформление" id="nextOrderForm3">
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <div class="cart__deliverie__inner cart__deliverie__inner__step-three">

                                <div class="cart__deliverie__step cart__deliverie__step-three">
                                    <div class="wrapper step__title">
                                        <div class="step__list">3</div>
                                        <span class="step__name">Способ оплаты</span>
                                    </div>
                                </div>

                            </div>

                        </div>

                    {/if}

            </form>
        {else}
            <div class="wrapper">
                <p>В корзине нет товаров</p>
            </div>

        {/if}
</div>

<!---------------->