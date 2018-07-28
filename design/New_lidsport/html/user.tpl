<div class="user">
	<div class="user__wrapper wrapper">
		<h1 class="user__title">Личный кабинет</h1>
		<p class="user__name">{$user->name|escape}</p>

		<form class="user__form form" method="post">
			{if $error}
				<div class="user__error">
					{if $error == 'empty_name'}Введите имя
						{elseif $error == 'empty_email'}Введите email
						{elseif $error == 'empty_password'}Введите пароль
						{elseif $error == 'user_exists'}Пользователь с таким email уже зарегистрирован
					{else}{$error}{/if}
				</div>
			{/if}

			<label class="user__label">Изменить имя:</label>
			<input class="user__input" data-format=".+" data-notice="Введите имя" value="{$name|escape}" name="name" maxlength="255" type="text">

			<label class="user__label">Изменить email:</label>
			<input class="user__input" data-format="email" data-notice="Введите email" value="{$email|escape}" name="email" maxlength="255" type="text">

			<label class="user__label">Изменить пароль:</label>
			<input class="user__input" id="password" value="" name="password" type="password">
			<input type="submit" class="user__button" value="Сохранить">
		</form>

		{if $orders}
		<p class="user__caption">Ваши заказы</p>
		<ul id="orders_history" class="user__list">
			{foreach name=orders item=order from=$orders}
			<li class="user__item">
				{$order->date|date}
				<a href='order/{$order->url}' class="user__link">Заказ №{$order->id}</a>
				{if $order->paid == 1} 
					&nbsp;- оплачен,
				{/if} 
				{if $order->status == 0}
					&nbsp;ждет обработки.
				{elseif $order->status == 1}
					&nbsp;в обработке.
				{elseif $order->status == 2}
					&nbsp;выполнен.
				{/if}
			</li>
			{/foreach}
		</ul>
		{/if}
	</div>
</div>