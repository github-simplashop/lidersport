{capture name=tabs}
		<li><a href="index.php?module=ProductsAdmin">Товары</a></li>
		<li><a href="index.php?module=CategoriesAdmin">Категории</a></li>
		<li><a href="index.php?module=BrandsAdmin">Бренды</a></li>
		<li class="active"><a href="index.php?module=FeaturesAdmin">Свойства</a></li>
                <li><a href='index.php?module=TagsAdmin'>Теги</a></li>
{/capture}

{if $feature->id}
{$meta_title = $feature->name scope=parent}
{else}
{$meta_title = 'Новое свойство' scope=parent}
{/if}

{* On document load *}
{literal}
<script>
$(function() {

    /* chpu_filter */
    url_touched = true;

    if($('input[name="url"]').val() == generate_url() || $('input[name="url"]').val() == '')
        url_touched = false;

    $('input[name="url"]').change(function() { url_touched = true; });

    $('input[name="name"]').keyup(function() {
        if(!url_touched)
            $('input[name="url"]').val(generate_url());
    });

    /* chpu_filter /*/

});
/* chpu_filter */
function generate_url()
{
    url = $('input[name="name"]').val();
    url = url.replace(/[\s-_]+/gi, '');
    url = translit(url);
    url = url.replace(/[^0-9a-z\-]+/gi, '').toLowerCase();
    return url;
}

function translit(str)
{
    var ru=("А-а-Б-б-В-в-Ґ-ґ-Г-г-Д-д-Е-е-Ё-ё-Є-є-Ж-ж-З-з-И-и-І-і-Ї-ї-Й-й-К-к-Л-л-М-м-Н-н-О-о-П-п-Р-р-С-с-Т-т-У-у-Ф-ф-Х-х-Ц-ц-Ч-ч-Ш-ш-Щ-щ-Ъ-ъ-Ы-ы-Ь-ь-Э-э-Ю-ю-Я-я-'_'").split("-")
    var en=("A-a-B-b-V-v-G-g-G-g-D-d-E-e-E-e-E-e-ZH-zh-Z-z-I-i-I-i-I-i-J-j-K-k-L-l-M-m-N-n-O-o-P-p-R-r-S-s-T-t-U-u-F-f-H-h-TS-ts-CH-ch-SH-sh-SCH-sch-'-'-Y-y-'-'-E-e-YU-yu-YA-ya-''").split("-")
    var res = '';
    for(var i=0, l=str.length; i<l; i++)
    {
        var s = str.charAt(i), n = ru.indexOf(s);
        if(n >= 0) { res += en[n]; }
        else { res += s; }
    }
    return res;
}
/* chpu_filter /*/
</script>
{/literal}

{if $message_success}
<!-- Системное сообщение -->
<div class="message message_success">
	<span>{if $message_success=='added'}Свойство добавлено{elseif $message_success=='updated'}Свойство обновлено{else}{$message_success}{/if}</span>
	{if $smarty.get.return}
	<a class="button" href="{$smarty.get.return}">Вернуться</a>
	{/if}
</div>
<!-- Системное сообщение (The End)-->
{/if}

{if $message_error}
<!-- Системное сообщение -->
<div class="message message_error">
	<span>{$message_error}</span>
	<a class="button" href="">Вернуться</a>
</div>
<!-- Системное сообщение (The End)-->
{/if}

<!-- Основная форма -->
<form method=post id=product>

	<div id="name">
		<input class="name" name=name type="text" value="{$feature->name|escape}"/> 
		<input name=id type="hidden" value="{$feature->id|escape}"/> 
	</div> 

	<!-- Левая колонка свойств товара -->
	<div id="column_left">
			
		<!-- Категории -->	
		<div class="block">
			<h2>Использовать в категориях</h2>
					<select class=multiple_categories multiple name="feature_categories[]">
						{function name=category_select selected_id=$product_category level=0}
						{foreach from=$categories item=category}
								<option value='{$category->id}' {if in_array($category->id, $feature_categories)}selected{/if} category_name='{$category->single_name}'>{section name=sp loop=$level}&nbsp;&nbsp;&nbsp;&nbsp;{/section}{$category->name}</option>
								{category_select categories=$category->subcategories selected_id=$selected_id  level=$level+1}
						{/foreach}
						{/function}
						{category_select categories=$categories}
					</select>
		</div>
 
	</div>
	<!-- Левая колонка свойств товара (The End)--> 
	
	<!-- Правая колонка свойств товара -->	
	<div id="column_right">
		
		<!-- Параметры страницы -->
		<div class="block">
			<h2>Настройки свойства</h2>
			<ul>
                {* chpu_filter *}
				<li><label for=url>url</label> <input type=text name=url id=url value="{$feature->url}"></li>
                {* chpu_filter /*}
				<li><input type=checkbox name=in_filter id=in_filter {if $feature->in_filter}checked{/if} value="1"> <label for=in_filter>Использовать в фильтре</label></li>
			</ul>
		</div>
		<!-- Параметры страницы (The End)-->
		<input type=hidden name='session_id' value='{$smarty.session.id}'>
		<input class="button_green" type="submit" name="" value="Сохранить" />
		
	</div>
	<!-- Правая колонка свойств товара (The End)--> 
	

</form>
<!-- Основная форма (The End) -->

