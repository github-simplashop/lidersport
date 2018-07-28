{foreach from=$category->path item=cat}
	{assign var=foocat value=$cat->name}
{/foreach}

{if $product->variants|count > 0}
	<script>
		{if $empty_color}
			var colorValue = false;
		{else}
			var colorValue = true;
		{/if}

		{if $empty_razmer} 
			var razmerValue = false;
		{else}
			var razmerValue = true;
		{/if}

		console.log(colorValue);
		console.log(razmerValue);

		var addColor = function() {
			if ($("#colors").hasClass("active")) {
				if ($("#colors").find("label").hasClass("active")) {
					colorValue = true;
				}	else {
					colorValue = false;
				}
			} else {
				colorValue = true;
			}
		}

		var addRazmer = function() {
			if ($("#variants").hasClass("active")) {
				if ($("#variants").hasClass("select")) {
					if ($("#variants option:selected").val() == '0') {
						razmerValue = false;
					}	else {
						razmerValue = true;
					}
				} else {
					if ($("#variants").find("label").hasClass("active")) {
						razmerValue = true;
					} else {
						razmerValue = false;
					}
				}
			}
		}

		var variants = [
      {foreach $product->variants as $v}
      	{literal}{{/literal}
      		'id':'{$v->id}',
      		'color':'{$color[$v->id]}',
      		'razmer':'{$razmers[$v->id]}',
      		'price':'{$v->price|convert}',
      		'compare_price':'{$v->compare_price}',
      		'stock':'{$v->stock}'
      	{literal}}{/literal},
      {/foreach}
    ];

    {literal}
	    function changeColor(eventObject) {
	    	if ($(eventObject).parent().hasClass('not_select')) {return true};
	    	if ($(eventObject).parent().hasClass('active')) {
	    		$(eventObject).parent().removeClass('active');
	    	}	else {
	    		$('#colors label').removeClass('active');
	    		$(eventObject).parent().addClass('active');
	    	}

	    	validateVariant();

	    	if ($('#variants label.active').length > 0) {
	    		return true
	    	} else {
	    		$('#variants option').hide();
	    		$('#variants option').eq(0).show();
	    		$('#variants label').addClass('not_select');
	    		$.each(variants, function(id, val){
	    			if (val.color==$(eventObject).val()) {
	    				$('#variants label:contains("'+val.razmer +'")').removeClass('not_select').addClass('select');
	    				$('#variants option:contains("'+val.razmer +'")').show();
	    			}
	    		});
	    	}

	    	if ($('#colors label.active').length <= 0) {
	    		$('#variants label').removeClass('not_select');
	    		$('#variants option').show();
	    	}
	    }
				
			function changeVariant(eventObject)	{
				if ($('#variants select').val() !== undefined)	{
					$('#colors label').addClass('not_select');

					$.each(variants, function(id, val) {
						if (val.razmer==$('#variants input').val()) {
							$('#colors label[rel="' + val.color + '"]').removeClass('not_select').addClass('select');
						}
						if (val.razmer==$(eventObject).val()) {
							$('#colors label[rel="' + val.color + '"]').removeClass('not_select').addClass('select');
						}
					});
					
					if ($(eventObject).val() == 0) {
						$('#colors label').removeClass('not_select');
					}
				}	else {
					if ($(eventObject).parent().hasClass('not_select')) {return true};
					if ($(eventObject).parent().hasClass('active'))	{
						$(eventObject).parent().removeClass('active');
						$('#colors label').removeClass('not_select');
					}	else {
						$('#variants label').removeClass('active');
						$(eventObject).parent().addClass('active');
						$('#colors label').addClass('not_select');

						$.each(variants, function(id, val) {
							if(val.razmer==$(eventObject).val()) {
								$('#colors label[rel="' + val.color + '"]').removeClass('not_select').addClass('select');
							}
							
							if(val.razmer==$('#variants select').val()) {
								$('#colors label[rel="' + val.color + '"]').removeClass('not_select').addClass('select');
							}
						});
					}
				}
				validateVariant();
			}
		{/literal}
			
		{if $empty_color || $empty_razmer}
			{literal}
				function validateVariant() {
					$.each(variants, function(id, val) {
						if ({/literal}{if $empty_razmer}val.razmer==$('#variants label.active input').val(){/if} {if $empty_razmer && $empty_color}&&{/if}{if $empty_color}val.color==$('#colors label.active input').val(){/if}{literal}) {
							var amount = Number($('.number__value').html());

							if(amount > val.stock) {
								$('.number__value').html(val.stock);
							}

							$('[name=variant]').remove();
							$('form.variants input[type="submit"]').before('<input type="radio" checked="checked" name="variant" style="display: none;" value="' + val.id + '" var_amount="'+ val.stock +'">');
							// $('form.variants input[type="submit"]').removeAttr('disabled');
							$('.price,.product-price').text(val.price);

							return false;
						}	else if ({/literal}{if $empty_razmer}val.razmer==$('#variants option:selected').val(){/if} {if $empty_razmer && $empty_color}&&{/if}{if $empty_color}val.color==$('#colors label.active input').val(){/if}{literal}) {
							var amount = Number($('.number__value').html());
							if(amount > val.stock) {
								$('.number__value').html(val.stock);
							}

							$('[name=variant]').remove();
							$('form.variants input[type="submit"]').before('<input type="radio" checked="checked" name="variant" style="display: none;" data="'+ amount +'" value="' + val.id + '" var_amount="'+ val.stock +'">');
							// $('form.variants input[type="submit"]').removeAttr('disabled');
							$('.price,.product-price').text(val.price);
							return false;
						}	else {
							// $('form.variants input[type="submit"]').attr('disabled','disabled');
						}
					});
				}
			{/literal}
		{else}
			{literal}
				$(document).ready(function() {
					$.each(variants, function(id, val) {
						var amount = Number($('.number__value').html());
						if (amount > val.stock) {
							$('.number__value').html(val.stock);
						}

						$('form.variants input[type="submit"]').before('<input type="radio" checked="checked" name="variant" style="display: none;" data="'+ amount +'" value="' + val.id + '"var_amount="'+ val.stock +'">');
						// $('form.variants input[type="submit"]').removeAttr('disabled');
						$('.price, .product-price').text(val.price);

						return false;
					});
				});
			{/literal}
		{/if}

		{literal}
			$(function() {
				$('#colors input').on('click', function() {
					changeColor(this);
					addColor();
				});

				$('#variants input').on('click', function(eventObject) {
					changeVariant(this);
					addRazmer();
				});

				$('#variants select').on('change', function(eventObject) {
					changeVariant(this);
					addRazmer();
				});
			});

			$(document).on("click", ".dataInProduct", function(e) {
				addColor();
				addRazmer();

				if (colorValue == false || razmerValue == false) {
					e.preventDefault();

					var id = $(this).attr("product");

					$.ajax({
						url: "/price/productInCatalog.php",
						type: "GET",
						data: {"productId": id},
						success: function(data) {
							$('.p-choose__content').html(data);
							$('[data-popup-block="choose"]').arcticmodal();
						}
					});
				}	else {

				}
			});
		{/literal}
	</script>
{/if}

	<div class="wrapper">
		{include file='filter.tpl'}
		<div class="window">
			{include file='navigation.tpl'}
			<div class="card"> 
				<div class="card__left">
					<div class="card__images images">
						{if $image_first}
							<div class="images__main">
								<a href="/images1c/{$image_first}" data-lightbox="item">
									<img src="/images1c/{$image_first}" alt="{$product->name|escape}">
								</a> 
							</div>
							{else}
							{if $product->image}
							<div class="images__main">
								<a href="{$product->image->filename|resize:1024:1024:w}" data-lightbox="item">
									<img src="{$product->image->filename|resize:1024:1024:w}" alt="{$product->name|escape}">
								</a>
							</div>
							{else}
							<div class="images__main">
								<img src="/design/{$settings->theme}/images/defaultPhoto.png" alt="defaultPhoto" >
							</div>  
							{/if}
						{/if}   
						{if $imagesc|count>1}
							<ul class="images__list">
								{* cut удаляет первую фотографию, если нужно начать 2-й - пишем cut:2 и тд *}
								{foreach $imagesc|cut as $i=>$image}
									<li class="images__item">
										<a href="/images1c/{$image}" data-lightbox="item">
											<img src="/images1c/{$image}" alt="{$product->name|escape}">
										</a>
									</li>  
								{/foreach}
							</ul>
						{elseif $product->images|count>1}
							<ul class="ul_dop_img">
								{* cut удаляет первую фотографию, если нужно начать 2-й - пишем cut:2 и тд *}
								{foreach $product->images|cut as $i=>$image}
									<li class="images__item">
										{if $product->image}
											<img src="{$image->filename|resize:108:80}" alt="{$product->name|escape}">
										{else}
											<img src="/design/{$settings->theme}/images/defaultPhoto.png" alt="{$product->name|escape}">
										{/if}
									</li>  
								{/foreach}
							</ul>
						{/if}
					</div>

					<ul class="card__links c-links">
						<li class="c-links__item">
							<img src="/design/{$settings->theme}/images/ico/paper_fly.svg" alt="paper-fly" class="c-links__ico">
							<a href="/dostavka-i-oplata" class="c-links__link">Доставка</a>
						</li>
						<li class="c-links__item">
							<img src="/design/{$settings->theme}/images/ico/star.svg" alt="star" class="c-links__ico">
							<a href="/contact" class="c-links__link">Пункты выдачи</a>
						</li>
						<li data-popup-button="installments" class="c-links__item">
							<img src="/design/{$settings->theme}/images/ico/installments.svg" alt="installments" class="c-links__ico">
							<span class="c-links__link">Рассрочка</span>
						</li>
					</ul>

					<div class="card__social social">
						<p class="social__caption">Рассказать друзьям</p>
						<ul class="social__list">
							<li class="social__item">
								<a href="/" class="social__link social__link--vk" onclick="window.open('http://vk.com/share.php?url=http%3A%2F%2Flidsport.ru%2Fcube%2Fu_velosiped-cube-2016-aim-pro-275&title=%D0%92%D0%B5%D0%BB%D0%BE%D1%81%D0%B8%D0%BF%D0%B5%D0%B4%20Cube%202016%20AIM%20PRO%2027%2C5%20-%20%D0%92%D0%B5%D0%BB%D0%BE%D1%81%D0%B8%D0%BF%D0%B5%D0%B4%D1%8B%2FCUBE&description=%D0%92%D0%B5%D0%BB%D0%BE%D1%81%D0%B8%D0%BF%D0%B5%D0%B4%D1%8B%2FCUBE%20%D0%92%D0%B5%D0%BB%D0%BE%D1%81%D0%B8%D0%BF%D0%B5%D0%B4%20Cube%202016%20AIM%20PRO%2027%2C5', '_blank', 'scrollbars=0, resizable=1, menubar=0, left=100, top=100, width=550, height=440, toolbar=0, status=0');return false"></a>
							</li>
							<li class="social__item">
								<a href="/" class="social__link social__link--twitter" onclick="window.open('https://twitter.com/intent/tweet?text=%D0%92%D0%B5%D0%BB%D0%BE%D1%81%D0%B8%D0%BF%D0%B5%D0%B4%20Cube%202016%20AIM%20PRO%2027%2C5%20-%20%D0%92%D0%B5%D0%BB%D0%BE%D1%81%D0%B8%D0%BF%D0%B5%D0%B4%D1%8B%2FCUBE&url=http%3A%2F%2Flidsport.ru%2Fcube%2Fu_velosiped-cube-2016-aim-pro-275', '_blank', 'scrollbars=0, resizable=1, menubar=0, left=100, top=100, width=550, height=440, toolbar=0, status=0');return false"></a>
							</li>
							<li class="social__item">
								<a href="/" class="social__link social__link--odnoklassniki" onclick="window.open('http://www.odnoklassniki.ru/dk?st.cmd=addShare&st._surl=http%3A%2F%2Flidsport.ru%2Fodezhda-sambovki-shorty-poyasa%2Fu_kurtka-oblegchennaya&title=%D0%9A%D1%83%D1%80%D1%82%D0%BA%D0%B0%20%D0%BE%D0%B1%D0%BB%D0%B5%D0%B3%D1%87%D0%B5%D0%BD%D0%BD%D0%B0%D1%8F%20-%20%D0%95%D0%B4%D0%B8%D0%BD%D0%BE%D0%B1%D0%BE%D1%80%D1%81%D1%82%D0%B2%D0%B0%2F%D0%9E%D0%B4%D0%B5%D0%B6%D0%B4%D0%B0%3A%20%D1%81%D0%B0%D0%BC%D0%B1%D0%BE%D0%B2%D0%BA%D0%B8%2C%20%D1%88%D0%BE%D1%80%D1%82%D1%8B%2C%20%D0%BF%D0%BE%D1%8F%D1%81%D0%B0', '_blank', 'scrollbars=0, resizable=1, menubar=0, left=100, top=100, width=550, height=440, toolbar=0, status=0');return false"></a>
							</li>
							<li class="social__item">
								<a href="/" class="social__link social__link--facebook" onclick="window.open('http://www.facebook.com/sharer.php?u=http%3A%2F%2Flidsport.ru%2Fcube%2Fu_velosiped-cube-2016-aim-pro-275', '_blank', 'scrollbars=0, resizable=1, menubar=0, left=100, top=100, width=550, height=440, toolbar=0, status=0');return false"></a>
							</li>
						</ul>
					</div>    
				</div>

				<div class="card__right">
					<p class="card__title">{$product->name|escape}</p>
					{if $product->pod_zakaz}
						<div class="card__price">
							{if $product->variant->price!=0}Цена: {$product->variant->price|convert} руб.{/if}<br> Этот товар вы можете приобрести под заказ. Цену уточняйте по тел.: 511-777<br>доставка 7 дней.
						</div>
					{elseif $product->variants|count > 0}
						<!-- Выбор варианта товара -->
						<form class="variants" action="/cart">
							<div class="card__price">
								{if $product->variants|count > 0}
									{if $product->variant->compare_price}
										{if $product->variant->compare_price > 0}
											<span class="card__old">{$product->variant->compare_price|convert}</span>
										{/if}
										<span class="card__new">{$product->variant->price|convert} <i class="fa fa-rub"></i></span>
									{else}
										{if $product->variant->compare_price > 0}
											<span class="card__old">{$product->variant->compare_price|convert}</span>
										{/if}
										<span class="card__new">{$product->variant->price|convert} <i class="fa fa-rub"></i></span>
									{/if}
								{/if}
							</div>
							{if $product->variants|count > 0}
								<div class="card__number number">
									<span class="number__caption">Количество</span>
									<span class="number__reduce">-</span>
									<span class="number__value">1</span>
									<span class="number__add">+</span>
								</div>
							{/if}
							<div class="card__block">
								<div class="catalog__add">
									<input type="submit" class="catalog__button catalog--by dataInProduct" product="{$product->id}" data-result-text="в корзине" value="в корзину">
								</div> 
								<a href="#onclick" data-popup-button="callback" class="card__onclick">Купить в 1 клик</a>
							</div>
							<div class="card__block">
								{if $empty_color}
									<div id="colors" class="card__colors {if $empty_color}active{/if}">
										<p class="card__caption">Цвета:</p>
										<ul class="colors">
											{foreach $color_u as $k=>$v}
												{if $v|strpos:"." !== false}
												<li class="colors__item">
													<label rel="{$v}" style="background: url('../images/textures/{$v}');" class="colors__color  {if $v@first}first{/if}">
														<input type="radio" class="colors__radio" value="{$v}" {if $v@first}checked{/if} />
													</label>    </li>
												{else}
												<li class="colors__item">
													<label rel="{$v}" style="background-color: {$v};" class="colors__color {if $v@first}first{/if}">
														<input type="radio" name="color" class="colors__radio" value="{$v}" {if $v@first}checked{/if} />
													</label>
													</li>
												{/if}
											{/foreach}
										</ul>
									</div>
								{/if}

								<div class="card__pay">
									<p class="card__caption">Способы оплаты:</p>
									<img src="/design/{$settings->theme}/images/cards.png" alt="cards">
								</div>
							</div>

							{if $empty_razmer}
								<div id="variants" class="card__block card__block--size {if $empty_razmer}active{/if} {if $category->plitka}point{else}select{/if}">
									<p class="card__caption">Размер:</p>
									{if $category->plitka}
										{foreach $razmers_u as $k=>$v}
											<label {if $v@first} class="first"{/if}>
												<input type="radio" name="razmers" value="{$v}"{if $v@first} checked{/if} />
												{$v}
											</label>
										{/foreach}
									{else}
										<select name="razmers">
											<option value="0">Выберите размер</option>
												{foreach $razmers_u as $k=>$v}   
													<option value="{$v}">{$v}</option> 
												{/foreach}
										</select>   
									{/if}
								</div>
							{/if}

							{foreach from=$category->path|@array_reverse item=cat}
								{if $cat->podobrat!=''}
									<p class="card__how" data-popup-button="choose-size" data-size-path="../files/categories/{$cat->podobrat}">Как подобрать размер</p>
								{break}
								{/if}
							{/foreach}
                                                        
                                                        {if $product->annotation}
								<div class="card__description">{$product->annotation}</div>
							{/if}
										
							{if $product->body}
								<div class="card__description">{$product->body}</div>
							{/if}
						</form> 
					{/if}
				</div>

				<div class="accordion">
					<ul class="accordion__menu">
						{if $product->features || $product->harakt}
							<li data-accordion-menu="1" class="accordion__item">Характеристики</li>
						{/if}
						<li data-accordion-menu="2" class="accordion__item">Отзывы <span class="accordion__reviews">{$comments|count}</span></li>
					</ul>
					<div class="accordion__tabs">
						{if $product->features || $product->harakt}
							<div data-accordion-tab="1" class="accordion__tab active">
								<table class="features__table">
									{foreach $product->features as $f}
										<tr>
											<td>{$f->name}</td>
											<td>{$f->value}</td>
										</tr>
									{/foreach}
								</table>
								{if $product->harakt}
									<div>{$product->harakt}</div>
								{/if}
							</div>
						{/if}
						<div data-accordion-tab="2" class="accordion__tab {if !$product->features && !$product->harakt}active{/if}">
							{foreach $comments as $comment}
								<a name="comment_{$comment->id}"></a>
								<div class="comment">
									<div class="comment__header-header">
										<span class="comment__author">
											{$comment->name|escape}
											{if !$comment->approved}
												<span class="bold">(ожидает модерации)</span>
											{/if}
										</span>
										<span class="comment__date">{$comment->date|date}, {$comment->date|time}</span>
									</div>
									<p class="comment__text">{$comment->text|escape|nl2br}</p>
								</div>
							{/foreach}
							{* Comment form *}
								<form class="comment__form" method="post">
									<h2 class="comment__caption">Оставить комментарий</h2>
									{if $error}
										<div class="comment__error">
											{if $error=='captcha'}
												Неверно введена капча
											{elseif $error=='empty_comment'}
												Введите комментарий
											{elseif $error=='empty_name'}
												Введите имя
											{/if}
										</div>
									{/if}
									<input id="comment_name" class="comment__name" type="text" name="name" value="{$comment_name}" placeholder="Имя" data-format=".+" data-notice="Введите имя">
									<textarea id="comment_text" class="comment__message" name="text" placeholder="Введите комментарий" data-format=".+" data-notice="Введите комментарий">{$comment_text}</textarea>
									<div class="comment__captcha captcha">
										<input id="comment_captcha" class="captcha__input" type="text" name="captcha_code_review" placeholder="Введите код" data-format="\d\d\d\d" data-notice="Введите капчу">
										<img src="/captcha/image.php?{math equation='rand(10,10000)'}&type=review" alt="captcha" class="captcha__image">
									</div> 
									<input class="comment__send" type="submit" name="comment" value="Отправить">
								</form>
						  {* End comment form *}
						</div>
					</div>
				</div>

				<ul class="card__c-advantages c-advantages">
					<li class="c-advantages__item">
						<img src="/design/{$settings->theme}/images/ico/phone.svg" alt="" class="c-advantages__ico">
						Не знаете, как выбрать?<br> проконсультируйтесь<br> у наших операторов.
					</li>
					<li class="c-advantages__item">
						<img src="/design/{$settings->theme}/images/ico/check_mark.svg" alt="" class="c-advantages__ico">
						Гаратия качества<br> на весь ассортимент<br> продукции!
					</li>
					<li class="c-advantages__item">
						<img src="/design/{$settings->theme}/images/ico/cube.svg" alt="" class="c-advantages__ico">
						Отправляем товар<br> в день заказа! Доставим<br> за 1-2 дня*
					</li>
				</ul>
				<p class="card__ps">* - Доставка товара за однин день по Ставрополю и СК!</p>
			</div>                
		</div>
   
		{if $related_products}
			<div class=""> 
				<p class="sale__title">Также советуем:</p> 
				<div class="catalog">
					{assign var="stock" value=""}
					{foreach $related_products as $related_product}
						{foreach $related_product->variants as $v}
							{$stock=$stock+$v}
						{/foreach}
						<div class="catalog__item"> 
							<a href="/{$related_product->cat_url}/u_{$related_product->url}" class="catalog__image">
								{if $related_product->imagesc}
									<img src="/images1c/{$related_product->imagesc}" alt="{$product->name|escape}" class="catalog__picture">
								{else}
									{if $related_product->image}
										<img src="{$related_product->image->filename|resize:190:140}" alt="{$product->name|escape}" class="catalog__picture">
									{else}
										<img src="/design/lidsport/images/defaultPhoto.png" alt="{$product->name|escape}" class="catalog__picture">
									{/if}
								{/if}
							</a> 
							<a href="/{$related_product->cat_url}/u_{$related_product->url}/" class="catalog__caption">{$related_product->name|escape}</a>

							{if $related_product->variants|count < 2}
								<form class="variants tocart" action="/cart">
									{foreach $related_product->variants as $v}
										{if $v->pod_zakaz==1}
											<div class="catalog__price catalog__price--none">Этот товар вы можете приобрести под заказ. Цену уточняйте по тел.:511-777</div>
										{else}
											<div class="catalog__price">
												<input id="related_{$v->id}" name="variant" value="{$v->id}" type="radio" class="variant_radiobutton}" {if $v@first}checked{/if} style="display:none;">
												{if $v->compare_price > 0}
													<span class="catalog__old">{$v->compare_price|convert}</span>
												{/if}
												<span class="catalog__new">{$v->price|convert} <i class="fa fa-rub"></i></span>
											</div>
											<div class="catalog__number number">
												<span class="number__caption">Количество</span>
												<span class="number__reduce">-</span>
												<span class="number__value">1</span>
												<input type="hidden" name="amount" value="2">
												<span class="number__add">+</span>
											</div>
											<div class="catalog__add">
	                      <input type="submit" data-popup-button="add-to-cart" class="catalog__button" data-result-text="добавлено" value="В корзину">
	                    </div>
										{/if}
									{/foreach}
								</form>
							{elseif $related_product->variants|count >1}
								{foreach $related_product->variants as $v}
									{if $v@key==0}
										{if $v->pod_zakaz ==1}
											<div class="catalog__price catalog__price--none">Этот товар вы можете приобрести под заказ. Цену уточняйте по тел.:511-777</div>
										{else}
											<div class="catalog__price">
												<input id="related_{$v->id}" name="variant" value="{$v->id}" type="radio" class="variant_radiobutton" {if $v@first}checked{/if} style="display:none;">
												{if $v->compare_price > 0}
													<span class="catalog__old">{$v->compare_price|convert}</span>
												{/if}
												<span class="catalog__new">{$v->price|convert} <i class="fa fa-rub"></i></span>
											</div>
											<div class="catalog__number number">
												<span class="number__caption">Количество</span>
												<span class="number__reduce">-</span>
												<span class="number__value">1</span>
												<input type="hidden" name="amount" value="2">
												<span class="number__add">+</span>
											</div>
											<div class="catalog__add">
												<input type="submit" class="catalog__button catalog--choose" product="{$related_product->id}" data-result-text="добавлено" value="В корзину">
											</div>
										{/if}
									{/if}    
								{break}
								{/foreach}
							{/if}
					  </div>
				  {/foreach}
			  </div>
			</div>
  	{/if}