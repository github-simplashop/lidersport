<div style="display: none;">
	<div class="popup p-sale-5-percents" data-popup-block="sale-5-percents">
		<div class="popup__close arcticmodal-close"></div>
        <div class="p-sale-5-percents__accent">-5 %</div>
		<div class ="p-sale-5-percents__title">
            Оформи заказ на сайте и <span>получи скидку!</span> *
		</div>
		<div class ="p-sale-5-percents__body">
			<div class="p-sale-5-percents__step">
                <div class="p-sale-5-percents__step__img">
                    <img src="/design/{$settings->theme}/images/popup/step_1.png" alt="">
                </div>
                <div class="p-sale-5-percents__step__label">
                    <div class="p-sale-5-percents__step__text">Шаг</div>
                    <div class="p-sale-5-percents__step__list">1</div>
                </div>
                <div class="p-sale-5-percents__step__description">
                    Выбери товары на сайте lidsport.ru
                </div>
            </div>

			<div class="p-sale-5-percents__step">
                <div class="p-sale-5-percents__step__img">
                    <img src="/design/{$settings->theme}/images/popup/step_2.png" alt="">
                </div>
                <div class="p-sale-5-percents__step__label">
                    <div class="p-sale-5-percents__step__text">Шаг</div>
                    <div class="p-sale-5-percents__step__list">2</div>
                </div>
                <div class="p-sale-5-percents__step__description">
                    Оформи заказ онлайн
                </div>
            </div>

			<div class="p-sale-5-percents__step">
                <div class="p-sale-5-percents__step__img">
                    <img src="/design/{$settings->theme}/images/popup/step_3.png" alt="">
                </div>
                <div class="p-sale-5-percents__step__label">
                    <div class="p-sale-5-percents__step__text">Шаг</div>
                    <div class="p-sale-5-percents__step__list">3</div>
                </div>
                <div class="p-sale-5-percents__step__description">
                    Получи скидку 5 %
                </div>
            </div>
		</div>
        <div class = "p-sale-5-percents__footer">
            <div class="p-sale-5-percents__button">Продолжить</div>
            <div class="p-sale-5-percents__footnote">* Скидка действует при любом способе оплаты</div>
            <div class="p-sale-5-percents__footnote">** Скидка не распространяется на товары с оранжевой ценой</div>
        </div>
	</div>
</div>

<div style="display: none;">
	<div class="popup p-youtube-video" data-popup-block="youtube-video">
		<div class="popup__close arcticmodal-close"></div>
		<div class ="p-youtube-video__title">

		</div>
		<div class ="p-youtube-video__body">

		</div>
	</div>
</div>

<div style="display: none;">
	<div class="popup p-input-city" data-popup-block="input-city">
		<div class="popup__close arcticmodal-close"></div>
		<div class ="p-input-city__title">
			Введите название Вашего населенного пункта
		</div>
		<div class ="p-input-city__body">
			<span id="city__input-alert" class="red_text">Пожалуйста введите название</span>
			<input name="city" type="text" value="" data-format=".+" data-notice="" class="issue__input"  id="city__input">
			<input type="button" class="issue__send" id="city__input-ok" value="Подтвердить"/>
		</div>
	</div>
</div>

<div style="display: none;">
	<div class="popup p-choice-city" data-popup-block="choice-city">
		<div class="popup__close arcticmodal-close"></div>
		<div class ="p-choice-city__title">

		</div>
		<div class ="p-choice-city__body">

		</div>
	</div>
</div>

<div style="display: none;">
	<div class="popup p-regions" data-popup-block="regions">
		<div class="popup__close arcticmodal-close"></div>
		<div class ="p-regions__title">

		</div>
		<div class ="p-regions__body">

		</div>

		<div class ="p-regions__footer">
			<div>Не нашли своего города?</div>
			<a href="#" class="p-cities__region-delivery">Региональная доставка</a>
		</div>
	</div>
</div>

<div style="display: none;">
	<div class="popup p-cities" data-popup-block="cities">
		<div class="popup__close arcticmodal-close"></div>
		<div class ="p-cities__title">

		</div>
		<div class ="p-cities__body">

		</div>

		<div class ="p-cities__footer">
			<div>Не нашли своего города?</div>
			<a href="#" class="p-cities__region-delivery">Региональная доставка</a>
		</div>
	</div>
</div>

<div style="display: none;">
	<div class="popup p-promo_d" data-popup-block="promo_d">
		<div class="popup__close arcticmodal-close"></div>
		<div class ="p-promo_d__body">
			<div class="p-promo_d__title">Ваш персональный промокод на скидку 10%</div>
			<div class="p-promo_d__promocode"></div>
			<div class="p-promo_d__date"></div>
			<form class="p-promo_d__form">
				<input type="text" value="{$email|escape}" maxlength="255" placeholder="E-mail адрес" class="p-promo_d__input">
				<input type="button" class="p-promo_d__button" name="send_promo" id=p-promo_d__button" value="Выслать на почту">
				<span id="p-promo_d__pleaseInputEmail"></span>
				<div class="p-promo_d__checkcheck">
					<input name="checkbox" type="checkbox" required checked disabled>
					<div>Я даю свое согласие на обработку персональных данных и соглашаюсь с условиями и <a href="/confid" target="_blank">политикой конфиденциальности</a></div>
				</div>
			</form>
			<div class="p-promo_d__rules">
				<p class="p-promo_d__rules__title">Как воспользоваться?</p>
				<p class="p-promo_d__rules__body">Сделайте заказ на сайте и введите промокод в соответсвующее поле при
					оформлении заказа или сообщите этот промокод продавцу в любом магазине Лидерспорт <br/>
					<span>и получите скидку 10% на вашу покупку</span>
				</p>
			</div>
		</div>
	</div>
</div>

<div style="display: none;">
	<div class="popup p-callback" data-popup-block="callback">
		<div class="popup__close arcticmodal-close"></div>
		<p class="p-callback__title">Оставьте заявку и мы Вам перезвоним</p>
		<form class="p-callback__form">
			<input type="text" class="p-callback__input" placeholder="Имя" name="name" required>
			<input type="text" class="p-callback__input" placeholder="Телефон" name="phone" required>
                        <input name="checkbox" type="checkbox" style="position: relative; top: 3px; left: 0; margin: 0;" required checked disabled>	<p class= "checkcheck">Я даю свое согласие на обработку персональных данных 
                 и соглашаюсь с условиями и <a href="/confid">политикой конфиденциальности</a></p>
			<input onclick="yaCounter36200345.reachGoal('LEADBUTTON'); return true;" type="submit" class="p-callback__button" name="send" id="p-callback__button">
		</form>
	</div>
</div>

<div style="display: none;">
	<div class="popup p-message">
		<div class="popup__close arcticmodal-close"></div>
		<p class="p-message__text"></p>
	</div>
</div>

<div style="display: none;">
	<div class="popup p-add" data-popup-block="add-to-cart">
		<div class="popup__close arcticmodal-close"></div>
		<div class="p-add__info">
			<p class="p-add__title">Товар добавлен в корзину!</p>
			<p class="p-add__continue arcticmodal-close">Продолжить<br> покупки</p>
			<a href="/cart" class="p-add__tocart">Перейти в<br> корзину</a>
		</div>
	</div>
</div>

<div style="display: none;">
	<div class="popup p-enter" data-popup-block="enter">
		<div class="popup__close arcticmodal-close"></div>
		<form method="post" action="/user/login" class="p-enter__form">
			<div class="p-enter__title">Войти на лидерспорт</div>
			<input type="text" name="email" data-format="email" data-notice="Введите email" value="{$email|escape}" maxlength="255" placeholder="E-mail адрес" class="p-enter__input">
			<input type="password" name="password" data-format=".+" data-notice="Введите пароль" value="" placeholder="Пароль" class="p-enter__input">
			<div class="p-enter__wrapper">
				<input name="remind" type="checkbox" value="" id="remind" class="p-enter__chek">
				<label for="remind" class="zapom fl">Запомнить меня</label>
				<div class="p-enter__links">
					<p class="p-enter__link" data-popup-button="remind">Забыли пароль</p>
					<p class="p-enter__link" data-popup-button="register">Регистрация</p>
				</div>
			</div>
			<input type="submit" class="p-enter__button" name="login" value="Войти">
		</form>
		{if $error}
			<div class="popup__error">
				{if $error == 'login_incorrect'}
					Неверный логин или пароль
				{elseif $error == 'user_disabled'}
					Ваш аккаунт еще не активирован.
				{else}
					{$error}
				{/if}
			</div>
		{/if}
	</div>
</div>

<div style="display: none;">
	<div class="popup p-remember" data-popup-block="remind">
		<div class="popup__close arcticmodal-close"></div>
		<form method="post" class="p-remember__form" action="/user/password_remind">
			<p class="p-remember__title">Восстановление пароля</p>
			<p class="p-remember__description">Введите email, который вы указывали при регистрации</p>
			<input type="text" name="email" data-format="email" data-notice="Введите email" value="{$email|escape}" maxlength="255" class="p-remember__input">
			<input type="submit" class="p-remember__button" value="Вспомнить">
		</form>
		{if $email_sent}
			<p>На {$email|escape} отправлено письмо для восстановления пароля.</p>
		{else}
			{if $error}
				<div class="popup__error">
					{if $error == 'user_not_found'}
						Пользователь не найден
					{else}
						{$error}
					{/if}
				</div>
			{/if}
		{/if}
	</div>
</div>

<div style="display: none;">
	<div class="popup p-register" data-popup-block="register">
		<div class="popup__close arcticmodal-close"></div>
		{if $error}
		<div class="p-register__error">
			{if $error == 'empty_name'}Введите имя
			{elseif $error == 'empty_email'}Введите email
			{elseif $error == 'empty_password'}Введите пароль
			{elseif $error == 'user_exists'}Пользователь с таким email уже зарегистрирован
			{elseif $error == 'captcha'}Неверно введена капча
			{else}{$error}{/if}
		</div>
		{/if}
		<p class="p-register__title">Регистрация</p>
		<form class="p-register__form form" action="/user/register" method="post">
			<input required class="p-register__input" type="text" name="name" data-format=".+" data-notice="Введите имя" value="{$name|escape}" maxlength="255" placeholder="Введите имя">
			<input required class="p-register__input" type="text" name="email" data-format="email" data-notice="Введите email" value="{$email|escape}" maxlength="255" placeholder="Введите email">
			<input required class="p-register__input" type="password" name="password" data-format=".+" data-notice="Введите пароль" value="" placeholder="Введите пароль">
			<div class="p-register__captcha captcha">
				<input required id="comment_captcha" class="captcha__input" type="text" name="captcha_code" placeholder="Введите код" data-format="\d\d\d\d" data-notice="Введите капчу">
				<img src="/captcha/image.php?{math equation='rand(10,10000)'}" alt="captcha" class="captcha__image">
			</div> 
                        <p><input type="checkbox" style="position: relative; top: 15px; margin: 0;" required checked>	<p class= "checkcheck">Я даю свое согласие на обработку персональных данных 
                 и соглашаюсь с условиями и <a href="/confid">политикой конфиденциальности</a></p>
					<p class="issue__hint">* - Поля обязательные для заполнения</p>
			<input type="submit" class="p-register__button" name="register" value="Зарегистрироваться">
		</form>
	</div>
</div>

<div style="display: none;">
	<div class="popup p-choose" data-popup-block="choose">
		<div class="popup__close arcticmodal-close"></div>
		<div class="p-choose__content"></div>
	</div>
</div>



