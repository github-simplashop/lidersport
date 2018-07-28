
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
							//$('form.variants input[type="submit"]').before('<input type="radio" checked="checked" name="variant" style="display: none;" value="' + val.id + '" var_amount="'+ val.stock +'">');
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
							$('form.variants input[type="submit"]').removeAttr('disabled');
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

						$('form.product__to-cart input[type="submit"]').before('<input type="radio" checked="checked" name="variant" style="display: none;" data="'+ amount +'" value="' + val.id + '"var_amount="'+ val.stock +'">');
						 $('form.variants input[type="submit"]').removeAttr('disabled');
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
                            $('select').styler();
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
		{*{include file='filter.tpl'}*}
		<div class="window window__product">
			{include file='navigation.tpl'}

			<div class="card">
				<div class="card__left">

					<div class="card__sku">
						<span">Артикул: </span>
						<span id="variant_sku">{$product->variant->sku}</span>
					</div>

                    {if $product->attachment_files_one}
						<img class="product_action_img_list" src="/files/documents/{$product->attachment_files_one}" alt="">
                    {/if}
                    {if $product->variant->compare_price}
                        {if $product->equally_compare_price > 0 && $product->equally_price > 0}
							<span class="action_red_list">- {(($product->equally_compare_price - $product->equally_price) * 100 / $product->equally_compare_price)|string_format:"%d"} %</span>
                        {else}
							<span class="action_red_list">до - {(($product->min_compare_price - $product->min_price) * 100 / $product->min_compare_price)|string_format:"%d"} %</span>
                        {/if}
                    {/if}

                    {if $product->image}
						<div class="owl-carousel__window">
							<div class="owl-carousel owl-carousel__product">
								{foreach $product->images as $i=>$image}
									<div>
										<img src="{$image->filename|escape|resize:450:450}" alt="" />
									</div>
								{/foreach}
							</div>
						</div>

						<div class="galery__window">
							<div class="zoomWrapper" id="gallery">

								<a data-lightbox="item" href="{$product->image->filename|escape|resize:800:800}">
									<img id="zoom" src="{$product->image->filename|escape|resize:450:450}"  data-zoom-image="/images1c/{$product->image->filename|escape}" alt="{$product->product->name|escape}" />
								</a>
							</div>

							<div id="gallery_zoom" {if count($product->images) <= 1} style="display:none"{/if}>

								<ul>
									<li class="active">
										<a href="{$product->image->filename|escape|resize:800:800}" class="elevatezoom-gallery active" data-update="" data-image="{$product->image->filename|escape|resize:450:450}" data-zoom-image="/images1c/{$product->image->filename|escape}">
											<img src="{$product->image->filename|escape|resize:100:100}" width="100">
										</a>
									</li>

									{foreach $product->images|cut as $i=>$image}
										<li>
											<a data-lightbox="item" href="{$image->filename|escape|resize:800:800}" class="elevatezoom-gallery" data-update="" data-image="{$image->filename|escape|resize:450:450}" data-zoom-image="/images1c/{$image->filename|escape}">
												<img src="{$image->filename|escape|resize:100:100}">
											</a>
										</li>
									{/foreach}
								</ul>
							</div>

						</div>

                    {else}
						<div class="imageWrapper">
                    		<img src="/design/{$settings->theme}/images/defaultPhoto.png" alt="{$product->name|escape}" style="left: 0; top: 0; right: 0; bottom: 0; margin: auto">
						</div>
                    {/if}

					{*<div class="card__images images">*}
						{*{if $product->image}*}
							{*<div class="images__main">*}

								{*{if $product->attachment_files_one}*}
									{*<img class="product_action_img_list" src="/files/documents/{$product->attachment_files_one}" alt="">*}
								{*{/if}*}
								{*{if $product->variant->compare_price}*}
                                    {*{if $product->equally_compare_price > 0 && $product->equally_price > 0}*}
										{*<span class="action_red_list">- {(($product->equally_compare_price - $product->equally_price) * 100 / $product->equally_compare_price)|string_format:"%d"} %</span>*}
                                    {*{else}*}
										{*<span class="action_red_list">до - {(($product->min_compare_price - $product->min_price) * 100 / $product->min_compare_price)|string_format:"%d"} %</span>*}
                                    {*{/if}*}
								{*{/if}*}

								{*<a href="{$product->image->filename|escape|resize:800:800}" data-lightbox="item">*}
									{*<img id="zoom_01" src="{$product->image->filename|escape|resize:410:410}"  data-zoom-image="/images1c/{$product->image->filename|escape}" alt="{$product->product->name|escape}" />*}
								{*</a>*}



							{*</div>*}



                            {*{if $product->images|count>1}*}
								{*<ul class="ul_dop_img">*}
                                    {* cut удаляет первую фотографию, если нужно начать 2-й - пишем cut:2 и тд *}
                                    {*{foreach $product->images|cut as $i=>$image}*}
										{*<li class="images__item">*}
                                            {*{if $product->image}*}
												{*<a href="{$image->filename|resize:800:600}" data-lightbox="item">*}
													{*<img src="{$image->filename|resize:108:80}" alt="{$product->name|escape}">*}
												{*</a>*}
												{*<a href="#" class="elevatezoom-gallery" data-update="" data-image="<?php echo $image['thumb']; ?>" data-zoom-image="</images1c/{$product->image->filename|escape}">*}
													{*<img src="</images1c/{$product->image->filename|escape}" width="100">*}
												{*</a>*}
                                            {*{else}*}
												{*<img src="/design/{$settings->theme}/images/defaultPhoto.png" alt="{$product->name|escape}">*}
                                            {*{/if}*}
										{*</li>*}
                                    {*{/foreach}*}
								{*</ul>*}
                            {*{/if}*}


						{*{else}*}
							{*<div class="images__main">*}
							{**}
								{*{if $product->attachment_files_one}*}
									{*<img class="product_action_img_list" src="/files/documents/{$product->attachment_files_one}" alt="">*}
								{*{/if}*}

								{*{if $product->variant->compare_price}*}
									{*{if $product->variant->compare_price > 0}*}
										{*<span class="action_red_list">- {(($product->variant->compare_price - $product->variant->price) * 100 / $product->variant->compare_price)|string_format:"%d"} %</span>*}
									{*{/if}*}
								{*{/if}*}

								{*<a href="/design/{$settings->theme}/images/defaultPhoto.png" data-lightbox="item">*}
									{*<img src="/design/{$settings->theme}/images/defaultPhoto.png" alt="{$product->product->name|escape}" />*}
								{*</a> *}

							{*</div>*}
						{*{/if}*}

						{*{if $product->images|count>1}*}
							{*<ul class="ul_dop_img">*}
								{* cut удаляет первую фотографию, если нужно начать 2-й - пишем cut:2 и тд *}
								{*{foreach $product->images|cut as $i=>$image}*}
									{*<li class="images__item">*}
										{*{if $product->image}*}
											{*<a href="{$image->filename|resize:800:600}" data-lightbox="item">*}
											{*<img src="{$image->filename|resize:108:80}" alt="{$product->name|escape}">*}
										{*</a>*}
										{*{else}*}
											{*<img src="/design/{$settings->theme}/images/defaultPhoto.png" alt="{$product->name|escape}">*}
										{*{/if}*}
									{*</li>  *}
								{*{/foreach}*}
							{*</ul>*}
						{*{/if}*}
					{*</div> *}

					{*<ul class="card__links c-links">*}
						{*<li class="c-links__item">*}
							{*<img src="/design/{$settings->theme}/images/ico/paper_fly.svg" alt="paper-fly" class="c-links__ico">*}
							{*<a href="/dostavka-i-oplata" class="c-links__link">Доставка</a>*}
						{*</li>*}
						{*<li class="c-links__item">*}
							{*<img src="/design/{$settings->theme}/images/ico/star.svg" alt="star" class="c-links__ico">*}
							{*<a href="/contact" class="c-links__link">Пункты выдачи</a>*}
						{*</li>*}
						{*<li data-popup-button="installments" class="c-links__item">*}
							{*<img src="/design/{$settings->theme}/images/ico/installments.svg" alt="installments" class="c-links__ico">*}
							{*<span class="c-links__link">Рассрочка</span>*}
						{*</li>*}
					{*</ul>*}

					{*<div class="card__social social">*}
						{*<p class="social__caption">Рассказать друзьям</p>*}
						{*<ul class="social__list">*}
							{*<li class="social__item">*}
								{*<a href="/" class="social__link social__link--vk" onclick="window.open('http://vk.com/share.php?url=http%3A%2F%2Flidsport.ru%2Fcube%2Fu_velosiped-cube-2016-aim-pro-275&title=%D0%92%D0%B5%D0%BB%D0%BE%D1%81%D0%B8%D0%BF%D0%B5%D0%B4%20Cube%202016%20AIM%20PRO%2027%2C5%20-%20%D0%92%D0%B5%D0%BB%D0%BE%D1%81%D0%B8%D0%BF%D0%B5%D0%B4%D1%8B%2FCUBE&description=%D0%92%D0%B5%D0%BB%D0%BE%D1%81%D0%B8%D0%BF%D0%B5%D0%B4%D1%8B%2FCUBE%20%D0%92%D0%B5%D0%BB%D0%BE%D1%81%D0%B8%D0%BF%D0%B5%D0%B4%20Cube%202016%20AIM%20PRO%2027%2C5', '_blank', 'scrollbars=0, resizable=1, menubar=0, left=100, top=100, width=550, height=440, toolbar=0, status=0');return false"></a>*}
							{*</li>*}
							{*<li class="social__item">*}
								{*<a href="/" class="social__link social__link--twitter" onclick="window.open('https://twitter.com/intent/tweet?text=%D0%92%D0%B5%D0%BB%D0%BE%D1%81%D0%B8%D0%BF%D0%B5%D0%B4%20Cube%202016%20AIM%20PRO%2027%2C5%20-%20%D0%92%D0%B5%D0%BB%D0%BE%D1%81%D0%B8%D0%BF%D0%B5%D0%B4%D1%8B%2FCUBE&url=http%3A%2F%2Flidsport.ru%2Fcube%2Fu_velosiped-cube-2016-aim-pro-275', '_blank', 'scrollbars=0, resizable=1, menubar=0, left=100, top=100, width=550, height=440, toolbar=0, status=0');return false"></a>*}
							{*</li>*}
							{*<li class="social__item">*}
								{*<a href="/" class="social__link social__link--odnoklassniki" onclick="window.open('http://www.odnoklassniki.ru/dk?st.cmd=addShare&st._surl=http%3A%2F%2Flidsport.ru%2Fodezhda-sambovki-shorty-poyasa%2Fu_kurtka-oblegchennaya&title=%D0%9A%D1%83%D1%80%D1%82%D0%BA%D0%B0%20%D0%BE%D0%B1%D0%BB%D0%B5%D0%B3%D1%87%D0%B5%D0%BD%D0%BD%D0%B0%D1%8F%20-%20%D0%95%D0%B4%D0%B8%D0%BD%D0%BE%D0%B1%D0%BE%D1%80%D1%81%D1%82%D0%B2%D0%B0%2F%D0%9E%D0%B4%D0%B5%D0%B6%D0%B4%D0%B0%3A%20%D1%81%D0%B0%D0%BC%D0%B1%D0%BE%D0%B2%D0%BA%D0%B8%2C%20%D1%88%D0%BE%D1%80%D1%82%D1%8B%2C%20%D0%BF%D0%BE%D1%8F%D1%81%D0%B0', '_blank', 'scrollbars=0, resizable=1, menubar=0, left=100, top=100, width=550, height=440, toolbar=0, status=0');return false"></a>*}
							{*</li>*}
							{*<li class="social__item">*}
								{*<a href="/" class="social__link social__link--facebook" onclick="window.open('http://www.facebook.com/sharer.php?u=http%3A%2F%2Flidsport.ru%2Fcube%2Fu_velosiped-cube-2016-aim-pro-275', '_blank', 'scrollbars=0, resizable=1, menubar=0, left=100, top=100, width=550, height=440, toolbar=0, status=0');return false"></a>*}
							{*</li>*}
						{*</ul>*}
					{*</div>*}

				</div>


				<div class="card__right">
					<p class="card__title">{$product->name|escape}</p>
					<div class="aver_rating"></div>
					<div class="aver_rating__count"><a href="#accordion__reviews" id="scroll__reviews" class="aver_rating--count"></a></div>

                    {if $product->pod_zakaz}
						<div class="card__price">
                            {if $product->variant->price!=0}Цена: {$product->variant->price|convert} руб.{/if}<br> Этот товар вы можете приобрести под заказ. Цену уточняйте по тел.: 8 (8652) 99-00-59 <br>доставка до 14 дней.
						</div>
                        {*{if $product->annotation}*}
							{*<div class="card__description">{$product->annotation}</div>*}
                        {*{/if}*}

                        {*{if $product->body}*}
							{*<div class="card__description">{$product->body}</div>*}
                        {*{/if}*}

                    {elseif $product->variants|count > 0}
						<!-- Выбор варианта товара -->
						<form class="variants tocart product__to-cart">
							<div class="card__price">
                                {if $product->variants|count > 0}
                                    {if $product->variant->price}
                                        {if $product->equally_price > 0}
											<span class="card__new{if $product->max_sale < 0} card__max-sale{/if}">{$product->equally_price|convert} <i class="fa fa-rub"></i></span>
                                        {else}
											<span class="card__new{if $product->max_sale < 0} card__max-sale{/if}">от {$product->min_price|convert} <i class="fa fa-rub"></i></span>
                                        {/if}
                                        {if $product->variant->compare_price > 0}
                                            {if $product->equally_compare_price > 0}
												<span class="card__old">{$product->equally_compare_price|convert} <i class="fa fa-rub"></i></span>
                                                {if $product->max_sale > 0}
													<span class="card__sale--icon">-5%</span><span class="card__sale--text">за покупку на сайте</span>
                                                {/if}
                                            {else}
												<span class="card__old">от {$product->min_compare_price|convert} <i class="fa fa-rub"></i></span>
                                                {if $product->max_sale > 0}
													<span class="card__sale--icon">-5%</span><span class="card__sale--text">за покупку на сайте</span>
                                                {/if}
                                            {/if}
                                        {else}
											<span class="card__old"></span>
                                            {if $product->max_sale > 0}
												<span class="card__sale--icon">-5%</span><span class="card__sale--text">за покупку на сайте</span>
                                            {/if}
                                        {/if}
                                    {/if}

                                {/if}
							</div>
							<div class="card__sale"></div>

                        {if $empty_razmer}

							<div id="variants" class="card__block card__block--size {if $empty_razmer}active{/if} {if $category->plitka}point{else}select{/if}">
									{*<p class="card__caption">Размер/вес</p>*}
                                {if $category->plitka}
                                    {foreach $razmers_u as $k=>$v}
										<label {if $v@first} class="first"{/if}>
													<input type="radio" name="razmers" value="{$v}"{if $v@first} checked{/if} />
                                            {$v}
												</label>
                                    {/foreach}
										{else}
											<select name="razmers">
												<option value="0" >Выбрать размер/вес</option>
                                    {foreach $razmers_u as $k=>$v}
										<option value="{$v}">{$v}</option>
                                    {/foreach}
											</select>
                                {/if}
								<!-- <div class="card__how" data-popup-button="choose-size" data-size-path="../files/categories/{$cat->podobrat}">Как выбрать размер?</div> -->
								</div>


                        {/if}

                        {*{if $product->annotation}*}
							{*<div class="card__description">{$product->annotation}</div>*}
                        {*{/if}*}

							{*{if $product->variants|count > 0}*}
								{*<div class="card__number number">*}
									{*<span class="number__caption">Количество</span>*}
									{*<span class="number__reduce">-</span>*}
									{*<span class="number__value">1</span>*}
									{*<span class="number__add">+</span>*}
								{*</div>*}
							{*{/if}*}

							<div class="card__info-block">
								<div class="catalog__add">
									<input type="submit" onclick="yaCounter36200345.reachGoal('CART'); return true;" class="catalog__button catalog--by dataInProduct" product="{$product->id}" data-result-text="В корзине" value="В корзину">
								</div>
								<div>
									<a href="#onclick" data-popup-button="callback" class="card__onclick">Быстрый заказ</a>
								</div>

								<div class="clear"></div>

								<div class="card__amount">
                                	{$product->variant->stock|plural:'Осталась':'Осталось':'Осталось'} {$product->variant->stock} {$product->variant->stock|plural:'штука':'штук':'штуки'}
									<span id="shop_sclad" style="display: none">{$product->variant->shop_sclad}</span>
									<span id="shop_makarova" style="display: none">{$product->variant->shop_makarova}</span>
									<span id="shop_204" style="display: none">{$product->variant->shop_204}</span>
									<span id="shop_mira" style="display: none">{$product->variant->shop_mira}</span>
									<span id="shop_yog" style="display: none">{$product->variant->shop_yog}</span>
									<span id="shop_passaj" style="display: none">{$product->variant->shop_passaj}</span>
									<span id="shop_mihailovsk" style="display: none">{$product->variant->shop_sclad}</span>
								</div>

								<div class="card__delivery">
									{if $product->variant->stock}
										<div class="card__delivery__title">Есть в наличии, товар можно получить:</div>
										<div style="vertical-align: top;">
											<table>
												<tr>
													<td class="card__delivery__date--icon"></td>
													<th>Доставка</th>
													<td class="card__delivery__date" style="position: relative;">

														<p class="special-text">
															<span class="card__delivery__date--value">уточняйте по телефону</span>
														  <span class="special-text__tooltip">
															<strong>Самый выгодный способ доставки:</strong><br/>
														  	Транспортная компания: <strong>DPD</strong><br/>
															Стоимость доставки: <strong><span class="card__delivery__date--cost"></span> рублей</strong><br/>
														  	Срок доставки: <strong><span class="card__delivery__date--value"></span></strong><br/>
														  	<span class="card__delivery__date--note">Все варианты доставки можно посмотреть и выбрать в корзине при оформлении заказа</span>
														  </span>
															<span class="special-text__tooltip special-text__tooltip--stavropol">
															<strong>Доставка:</strong><br/>
															<span>по г. Ставрополю <strong>150 рублей</strong></span><br/>
															<span>по г. Михайловску <strong>300 рублей</strong></span><br/>
															<span class="card__delivery__date--note">При заказе от <strong>2 900 рублей</strong> - доставка <strong>бесплатно</strong></span>
														  </span>
														</p>
													</td>
												</tr>
												<tr>
													<td class="card__delivery__shops--icon"></td>
													<th>Самовывоз</th>
													<td class="card__delivery__shops">
														<a href="#accordion__delivery" id="scroll__delivery" class="card__delivery__shops--value">уточняйте по телефону</a>
													</td>
												</tr>
											</table>

										</div>
									{else}
										<div class="card__delivery__title card__delivery__title--none">Нет в наличии</div>
                                    {/if}


								</div>

							</div>


						</form>
					{/if}
				</div>

				<div class="accordion">
					<ul class="accordion__menu">
						{if $product->features || $product->harakt}
							<li data-accordion-menu="1" class="accordion__item active">Описание</li>
						{/if}
						<li data-accordion-menu="2" class="accordion__item {if !$product->features && !$product->harakt}active{/if}" id="accordion__reviews">Отзывы <span class="accordion__reviews">{$comments|count}</span></li>
						<li data-accordion-menu="3" class="accordion__item" id="accordion__delivery">Доставка</li>
					</ul>
					<div class="accordion__tabs">
						{if $product->features || $product->harakt}
							<div data-accordion-tab="1" class="accordion__tab active">
								<div class="accordion__tab__wrapper">
									{if $product->body}
										<div class="card__description">{$product->body}</div>
									{/if}

									<div class="card__features">
										<div class="card__features__title">Краткие характеристики</div>
										<table class="features__table">
											{foreach $product->features as $f}
												{if $f->name == "Вес изделия, кг"}
													<tr>
														<td>{$f->name}</td>
														<td id="packing_weight">{$f->value}</td>
													</tr>
												{elseif $f->name == "Размер в  упаковке (ДхШхВ), см"}
													<tr>
														<td>{$f->name}</td>
														<td id="packing_params">{$f->value}</td>
													</tr>
												{else}
													<tr>
														<td>{$f->name}</td>
														<td>{$f->value}</td>
													</tr>
												{/if}
											{/foreach}
										</table>

										{if $category->name == "Санки и ледянки"}
											<div class="card__video">
												<iframe width="100%" height="100%" src="https://www.youtube.com/embed/UjtZD4x-S04" frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen></iframe>
											</div>
										{/if}
										{if $category->name == "Снегокаты"}
											<div class="card__video">
												<iframe width="100%" height="100%" src="https://www.youtube.com/embed/vwU6AeADIUY" frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen></iframe>
											</div>
										{/if}
										{if $category->name == "Ёлки искусственные"}
											<div class="card__video">
												<iframe width="100%" height="100%" src="https://www.youtube.com/embed/YnZhMY01r_M" frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen></iframe>
											</div>
										{/if}
									</div>

								</div>

							</div>
						{/if}
						<div data-accordion-tab="2" class="accordion__tab accordion__tab__2 {if !$product->features && !$product->harakt}active{/if}">
							<div class="accordion__tab__wrapper">
								{if $comments}
									<div class="comment_rating">
										<div class="aver_rating"></div><br/>
										<div class="aver_rating__desc"><span class="aver_rating--desc"></span></div>
										<div class="aver_rating__count"><span class="aver_rating--count"></span></div>
										<div class="aver_rating__button"><a href="#comment__caption" class="aver_rating__button--a">Написать отзыв</a></div>
									</div>

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
												<div class="comment__score" data-score="{$comment->rating|escape}"></div>
											</div>
											<p class="comment__text">{$comment->text|escape|nl2br}</p>
										</div>
									{/foreach}
                                {/if}

								{* Comment form *}
								<form class="comment__form" method="post">
									<h2 class="comment__caption" id="comment__caption">Написать отзыв</h2>
									<p>Ваш отзыв поможет кому-то сделать выбор. Спасибо, что делитесь опытом!</p>

									<div class="comment__input">
										<div class="comment__input_label">Имя *</div>
										<input id="comment_name" class="comment__name" type="text" name="name" value="{$comment_name}" placeholder="" data-format=".+" data-notice="Введите имя">
										<span class="red_text" id="comment__pleaseInputName" style="display: none;">Пожалуйста введите имя</span>
									</div>
									<div class="comment__input">
										<div class="comment__input_label">Email *</div>
										<input id="comment_email" class="comment__name" type="text" name="email" value="{$comment_email}" placeholder="" data-format=".+" data-notice="Введите Email">
										<span class="red_text" id="comment__pleaseInputEmail" style="display: none;">Пожалуйста введите корректый Email</span>
									</div>

									<div>Ваша оценка товара *</div>
									<div class="comment_star" id="comment_star"></div>
									<span class="red_text" id="comment__pleaseInputRating" style="display: none;">Пожалуйста поставьте оценку</span>

									<div>Отзыв *</div>
									<textarea id="comment_text" class="comment__message" name="text" placeholder="" data-format=".+" data-notice="Введите отзыв">{$comment_text}</textarea>
									<span class="red_text" id="comment__pleaseInputMessage" style="display: none;">Пожалуйста напишите отзыв</span>

									<div class="comment__captcha captcha">
										<input id="comment_captcha" class="captcha__input" type="text" name="captcha_code_review" placeholder="Введите код" data-format="\d\d\d\d" data-notice="Введите капчу">
										<span class="red_text" id="comment__pleaseInputCaptcha" style="display: none;">Пожалуйста введите код, изображенный на картинке</span>
										<img src="/captcha/image.php?{math equation='rand(10,10000)'}&type=review" alt="captcha" class="captcha__image">
									</div>
									<input class="comment__send" type="button" name="comment" value="Отправить отзыв">
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
								</form>
								{* End comment form *}
							</div>
						</div>

						<div data-accordion-tab="3" class="accordion__tab accordion__tab__3 map">
							<div class="accordion__tab__wrapper">
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
						</div>

					</div>

				</div>

				{*<ul class="card__c-advantages c-advantages">*}
					{*<li class="c-advantages__item">*}
						{*<img src="/design/{$settings->theme}/images/ico/phone.svg" alt="" class="c-advantages__ico">*}
						{*Не знаете, как выбрать?<br> проконсультируйтесь<br> у наших операторов.*}
					{*</li>*}
					{*<li class="c-advantages__item">*}
						{*<img src="/design/{$settings->theme}/images/ico/check_mark.svg" alt="" class="c-advantages__ico">*}
						{*Гаратия качества<br> на весь ассортимент<br> продукции!*}
					{*</li>*}
					{*<li class="c-advantages__item">*}
						{*<img src="/design/{$settings->theme}/images/ico/cube.svg" alt="" class="c-advantages__ico">*}
						{*Отправляем товар<br> в день заказа! Доставим<br> за 1-2 дня**}
					{*</li>*}
				{*</ul>*}
				{*<p class="card__ps">* - Доставка товара за однин день по Ставрополю и СК!</p>*}
			</div>                
		</div>
   
		{if $related_products}
			<p class="sale__title">С этим товаром покупают</p>
			<div class="catalog">
				{assign var="stock" value=""}
				{foreach $related_products as $related_product}
					{foreach $related_product->variants as $v}
						{$stock=$stock+$v}
					{/foreach}
					<div class="catalog__item related__item">
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
							{*<form class="variants tocart">*}
								{*{foreach $related_product->variants as $v}*}
									{*{if $v->pod_zakaz==1}*}
										{*<div class="catalog__price catalog__price--none">Этот товар вы можете приобрести под заказ. Цену уточняйте по тел.:511-777</div>*}
									{*{else}*}
										{*<div class="catalog__price">*}
											{*<input id="related_{$v->id}" name="variant" value="{$v->id}" type="radio" class="variant_radiobutton}" {if $v@first}checked{/if} style="display:none;">*}
											{*{if $v->compare_price > 0}*}
												{*<span class="catalog__old">{$v->compare_price|convert}</span>*}
											{*{/if}*}
											{*<span class="catalog__new {if $related_product->max_sale <= 0}catalog__max-sale{/if}">{$v->price|convert} <i class="fa fa-rub"></i></span>*}
										{*</div>*}
										{*<div class="catalog__number number">*}
											{*<span class="number__caption">Количество</span>*}
											{*<span class="number__reduce">-</span>*}
											{*<span class="number__value">1</span>*}
											{*<input type="hidden" name="amount" value="2">*}
											{*<span class="number__add">+</span>*}
										{*</div>*}
										{*<div class="catalog__add">*}
					  {*<input type="submit" data-popup-button="add-to-cart" class="catalog__button" data-result-text="добавлено" value="В корзину">*}
					{*</div>*}
									{*{/if}*}
								{*{/foreach}*}
							{*</form>*}

							{*<form class="variants tocart">*}
								{*{foreach $related_product->variants as $v}*}
									{*{if $v->pod_zakaz == 1}*}
										{*<div class="catalog__price catalog__price--none">Этот товар вы можете приобрести под заказ. Цену уточняйте по тел.: <br/> 8 (8652) 99-00-59</div>*}
									{*{else}*}
										{*<input id="variants_{$v->id}" name="variant" value="{$v->id}" type="radio" class="variant_radiobutton" {if $v@first}checked{/if} style="display: none;"/>*}
										{*<div class="catalog__price">*}
											{*{if $v->compare_price > 0}*}
												{*<span class="catalog__old">{$v->compare_price|convert}</span>*}
											{*{/if}*}
											{*<span class="catalog__new {if $product->max_sale < 0}catalog__max-sale{/if}">{$v->price|convert} <i class="fa fa-rub"></i></span>*}
										{*</div>*}
										{*<div class="catalog__number number">*}
											{*<span class="number__caption">Количество</span>*}
											{*<span class="number__reduce">-</span>*}
											{*<span class="number__value">1</span>*}
											{*<span class="number__add">+</span>*}
										{*</div>*}
										{*<div class="catalog__add">*}
											{*<input type="submit" onclick="yaCounter36200345.reachGoal('CART'); return true;" class="catalog__button" data-result-text="в корзине" value="купить">*}
											{*<input type="submit" class="catalog__button" data-result-text="в корзине" value="купить">*}
										{*</div>*}
										{*<!-- <p class="catalog__prewie">Предпросмотр товара</p> -->*}
									{*{/if}*}
								{*{/foreach}*}
							{*</form>*}

							<form class="variants tocart products__to-cart">
								{foreach $related_product->variants as $v}
									{if $v->pod_zakaz == 1}
										<div class="catalog__price catalog__price--none">Этот товар вы можете приобрести под заказ. Цену уточняйте по тел.: <br/> 8 (8652) 99-00-59</div>
									{else}
										<input id="variants_{$v->id}" name="variant" value="{$v->id}" type="radio" class="variant_radiobutton" {if $v@first}checked{/if} style="display: none;"/>
										<div class="catalog__price">
											<span class="catalog__new {if $related_product->max_sale < 0}catalog__max-sale{/if}">{$v->price|convert} <i class="fa fa-rub"></i></span>
											{if $v->compare_price > 0}
												<span class="catalog__old">{$v->compare_price|convert} <i class="fa fa-rub"></i></span>
											{/if}
										</div>
										<div class="catalog__number number">
											<span class="number__caption">Количество</span>
											<span class="number__reduce">-</span>
											<span class="number__value">1</span>
											<span class="number__add">+</span>
										</div>
										<div class="catalog__add">
											<input type="submit" onclick="yaCounter36200345.reachGoal('CART'); return true;" class="catalog__button" data-result-text="в корзине" value="купить">
											{*<input type="submit" class="catalog__button" data-result-text="в корзине" value="купить">*}
										</div>
										<!-- <p class="catalog__prewie">Предпросмотр товара</p> -->
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
												<span class="catalog__old">{$v->compare_price|convert} <i class="fa fa-rub"></i></span>
											{/if}
											<span class="catalog__new {if $related_product->max_sale <= 0}catalog__max-sale{/if}">{$v->price|convert} <i class="fa fa-rub"></i></span>
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
  	{/if}



<script>


//Размер

$('select').styler();

$('select[name=razmers]').change(function() {ldelim}
	var value = $('select[name=razmers] option:selected').text();
		{foreach $product->variants as $v}
			if (value == "{$v->name}") {ldelim}
                {if $product->variant->compare_price > 0}
                	$(".card__old").html('{$v->compare_price|convert} <i class="fa fa-rub"></i>');
					$(".action_red_list").text('- {(($v->compare_price - $v->price) * 100 / $v->compare_price)|string_format:"%d"} %');
                {/if}
                $(".card__new").html('{$v->price|convert} <i class="fa fa-rub"></i>');


			{rdelim}

		{/foreach}
    	if (value == "Выберать") {ldelim}
            {if $product->variant->compare_price > 0}
				{if $product->equally_compare_price > 0}
					$(".card__old").html('{$product->equally_compare_price|convert} <i class="fa fa-rub"></i>');
				{else}
					$(".card__old").html('от {$product->min_compare_price|convert} <i class="fa fa-rub"></i>');
				{/if}

				{if $product->equally_price > 0}
					$(".card__new").html('{$product->equally_price|convert} <i class="fa fa-rub"></i>');
				{else}
					$(".card__new").html('от {$product->min_price|convert} <i class="fa fa-rub"></i>');
				{/if}

            	{if $product->equally_compare_price > 0 && $product->equally_price > 0}
        			$(".action_red_list").text('- {(($product->equally_compare_price - $product->equally_price) * 100 / $product->equally_compare_price)|string_format:"%d"} %');
				{else}
            		$(".action_red_list").text('до - {(($product->min_compare_price - $product->min_price) * 100 / $product->min_compare_price)|string_format:"%d"} %');
            	{/if}
            {/if}
        {rdelim}



{rdelim});

//Размер
</script>