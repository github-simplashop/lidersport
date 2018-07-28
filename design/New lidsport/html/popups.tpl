<div style="display: none;">
	<div class="popup p-callback" data-popup-block="callback">
		<div class="popup__close arcticmodal-close"></div>
		<p class="p-callback__title">Оставьте заявку и мы Вам перезвоним</p>
		<form class="p-callback__form">
			<input type="text" class="p-callback__input" placeholder="Имя" name="name">
			<input type="text" class="p-callback__input" placeholder="Телефон" name="phone">
			<input type="submit" class="p-callback__button" name="send">
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
				<input name="" type="checkbox" value="" id="remind" class="p-enter__chek">
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
	<div class="popup p-remember" action="/user/password_remind" data-popup-block="remind">
		<div class="popup__close arcticmodal-close"></div>
		<form method="post form" class="p-remember__form">
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
			<input class="p-register__input" type="text" name="name" data-format=".+" data-notice="Введите имя" value="{$name|escape}" maxlength="255" placeholder="Введите имя">
			<input class="p-register__input" type="text" name="email" data-format="email" data-notice="Введите email" value="{$email|escape}" maxlength="255" placeholder="Введите email">
			<input class="p-register__input" type="password" name="password" data-format=".+" data-notice="Введите пароль" value="" placeholder="Введите пароль">
			<div class="p-register__captcha captcha">
				<input id="comment_captcha" class="captcha__input" type="text" name="captcha_code" placeholder="Введите код" data-format="\d\d\d\d" data-notice="Введите капчу">
				<img src="/captcha/image.php?{math equation='rand(10,10000)'}" alt="captcha" class="captcha__image">
			</div> 
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

<div style="display: none;">
	<div class="popup" data-popup-block="choose-size">
		<div class="popup__close arcticmodal-close"></div>
		<div class="p-choose__content">
                	<img src="" class="p-size__image">
                </div>
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
				<input name="" type="checkbox" value="" id="remind" class="p-enter__chek">
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
	<div class="popup p-remember" action="/user/password_remind" data-popup-block="remind">
		<div class="popup__close arcticmodal-close"></div>
		<form method="post form" class="p-remember__form">
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
			<input class="p-register__input" type="text" name="name" data-format=".+" data-notice="Введите имя" value="{$name|escape}" maxlength="255" placeholder="Введите имя">
			<input class="p-register__input" type="text" name="email" data-format="email" data-notice="Введите email" value="{$email|escape}" maxlength="255" placeholder="Введите email">
			<input class="p-register__input" type="password" name="password" data-format=".+" data-notice="Введите пароль" value="" placeholder="Введите пароль">
			<div class="p-register__captcha captcha">
				<input id="comment_captcha" class="captcha__input" type="text" name="captcha_code" placeholder="Введите код" data-format="\d\d\d\d" data-notice="Введите капчу">
				<img src="/captcha/image.php?{math equation='rand(10,10000)'}" alt="captcha" class="captcha__image">
			</div> 
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