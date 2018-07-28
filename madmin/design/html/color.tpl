{capture name=tabs}

		<li><a href="index.php?module=ProductsAdmin">Товары</a></li>

		<li><a href="index.php?module=CategoriesAdmin">Категории</a></li>

		<li ><a href="index.php?module=BrandsAdmin">Бренды</a></li>

		<li><a href="index.php?module=FeaturesAdmin">Свойства</a></li>
        
        <li class="active"><a href="index.php?module=ColorsAdmin">Цвета</a></li>

{/capture}
{literal}
<script src="design/js/jquery.colorPicker.js"></script>
<script>
        jQuery(document).ready(function($) {
    $('.color1').colorPicker();
  });

    $('input .color1').on('click', function(){
        $('.color_label').html() = $('.colorPicker-picker').attr('style');
    })



 /*variant_image*/
    // Удаление изображений вариантов
	$("li.variant_image a.delete").live('click', function() {
        closet = $(this).closest("li");
        closet.find('img, a, input[type=hidden]').fadeOut(200, function() { $(this).remove(); });
        closet.removeAttr('style');
        return false;
	});
    /*/variant_image*/
	// Загрузить изображение с компьютера
	$('#upload_image').click(function() {
		$("<input class='upload_image' name=images[] type=file multiple  accept='image/jpeg,image/png,image/gif'>").appendTo('div#add_image').focus().click();
	});
	// Или с URL
	$('#add_image_url').click(function() {
		$("<input class='remote_image' name=images_urls[] type=text value='http://'>").appendTo('div#add_image').focus().select();
	});
</script>
{/literal}

{if $color->id}

{$meta_title = $color->word scope=parent}

{else}

{$meta_title = 'Новый цвет' scope=parent}

{/if}





{if $message_success}

<!-- Системное сообщение -->

<div class="message message_success">

	<span>{if $message_success=='added'}Цвет добавлен{elseif $message_success=='updated'}Цвет обновлен{else}{$message_success}{/if}</span>


	

</div>
{/if}
<!-- Системное сообщение (The End)-->





{if $message_error}

<!-- Системное сообщение -->

<div class="message message_error">

	<span>{if $message_error=='url_exists'}Цвет с таким названием уже существует{else}{$message_error}{/if}</span>

	<a class="button" href="">Вернуться</a>

</div>

<!-- Системное сообщение (The End)-->

{/if}





<!-- Основная форма -->

<form method=post id=product enctype="multipart/form-data">

<input type=hidden name="session_id" value="{$smarty.session.id}">

	<div id="name">

		<input class="name" name="word" type="text" value="{$color->word|escape}"/> 

		<input name=id type="hidden" value="{$color->id|escape}"/> 

	</div> 



 		

	<!-- Левая колонка свойств товара -->

	<div id="column_left">

			

		<!-- Параметры страницы -->

		<div class="block layer">

			<h2>Соответствие</h2>

			<ul>
                <li class="variant_color">
                    <div class="colorhex">
                        <label for="html1" class=property>HEX1</label>
                        <span class="color_label" for="color1"></span>
                        <input class="color1" name="html1" type="text" value="{$color->html1|escape}" />
                    </div>
                </li>
                

{*variant_image*}
            <li class="variant_image" {if $color->textura}style="height: 80px"{/if}>
            <label for="html1" class=property>Текстура</label>
                {if $color->textura}
                    <img src="/images/textures/{$color->textura}" alt="Image" />
                    <a href='#' class="delete"><img src='design/images/cross-circle-frame.png'></a>
                    <input name="variant_image[]" type="hidden" value="{$variant->id}" />
                {/if}
                <input class="upload_image" name="variant_image[]" type="file" value="" />
            </li>
            {*/variant_image*}


			</ul>

		</div>

		<!-- Параметры страницы (The End)-->

		

 		{*

		<!-- Экспорт-->

		<div class="block">

			<h2>Экспорт товара</h2>

			<ul>

				<li><input id="exp_yad" type="checkbox" /> <label for="exp_yad">Яндекс Маркет</label> Бид <input class="simpla_inp" type="" name="" value="12" /> руб.</li>

				<li><input id="exp_goog" type="checkbox" /> <label for="exp_goog">Google Base</label> </li>

			</ul>

		</div>

		<!-- Свойства товара (The End)-->

		*}

			

	<input class="button_green button_save" type="submit" name="" value="Сохранить" />

	</div>

	<!-- Левая колонка свойств товара (The End)--> 

	

	<!-- Правая колонка свойств товара -->	

	<div id="column_right">

		

		

	</div>

	<!-- Правая колонка свойств товара (The End)--> 

	


	<input class="button_green button_save" type="submit" name="" value="Сохранить" />

	

	

</form>

<!-- Основная форма (The End) -->



