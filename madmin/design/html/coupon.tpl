{* Вкладки *}
{capture name=tabs}
	<li><a href="index.php?module=UsersAdmin">Покупатели</a></li>
	<li><a href="index.php?module=GroupsAdmin">Группы</a></li>
	<li class="active"><a href="index.php?module=CouponsAdmin">Купоны</a></li>
{/capture}

{if $coupon->code}
{$meta_title = $coupon->code scope=parent}
{else}
{$meta_title = 'Новый купон' scope=parent}
{/if}

{* Подключаем Tiny MCE *}
{include file='tinymce_init.tpl'}

<script src="design/js/jquery/datepicker/jquery.ui.datepicker-ru.js"></script>
{literal}
<script>
$(function() {

	$('input[name="expire"]').datepicker({
		regional:'ru'
	});
	$('input[name="end"]').datepicker({
		regional:'ru'
	});

	// On change date
	$('input[name="expire"]').focus(function() {
 
    	$('input[name="expires"]').attr('checked', true);

	});

});
</script>
{/literal}

{if $message_success}
<!-- Системное сообщение -->
<div class="message message_success">
	<span>{if $message_success == 'added'}Купон добавлен{elseif $message_success == 'updated'}Купон изменен{/if}</span>
	{if $smarty.get.return}
	<a class="button" href="{$smarty.get.return}">Вернуться</a>
	{/if}
</div>
<!-- Системное сообщение (The End)-->
{/if}

{if $message_error}
<!-- Системное сообщение -->
<div class="message message_error">
	<span>{if $message_error == 'code_exists'}Купон с таким кодом уже существует{/if}</span>
	<a class="button" href="">Вернуться</a>
</div>
<!-- Системное сообщение (The End)-->
{/if}


<!-- Основная форма -->
<form method=post id=product enctype="multipart/form-data">
<input type=hidden name="session_id" value="{$smarty.session.id}">
	<div id="name">
		<input class="name" name="code" type="text" value="{$coupon->code|escape}"/>
		<input name="id" class="name" type="hidden" value="{$coupon->id|escape}"/>		
	</div> 

	<!-- Левая колонка свойств товара -->
	<div id="column_left">
			
		<div class="block layer">
			<ul>
				<li>
					<label class=property>Скидка</label><input name="value" class="coupon_value" type="text" value="{$coupon->value|escape}" />
					<select class="coupon_type" name="type">
						<option value="percentage" {if $coupon->type=='percentage'}selected{/if}>%</option>
						<option value="absolute" {if $coupon->type=='absolute'}selected{/if}>{$currency->sign}</option>
					</select>
				</li>
				<li>
					<label class=property>Для заказов от</label>
					<input class="coupon_value" type="text" name="min_order_price" value="{$coupon->min_order_price|escape}"> {$currency->sign}		
				</li>
				<li>
					<h2>Использовать в категориях</h2>
					<select class=multiple_categories multiple name="coupon_categories[]">
                        {function name=category_select selected_id=$product_category level=0}
                            {foreach from=$categories item=category}
								<option value='{$category->id}' {if in_array($category->id, $coupon_categories)}selected{/if} category_name='{$category->single_name}'>{section name=sp loop=$level}&nbsp;&nbsp;&nbsp;&nbsp;{/section}{$category->name}</option>
                                {category_select categories=$category->subcategories selected_id=$selected_id level=$level+1}
                            {/foreach}
                        {/function}
                        {category_select categories=$categories}
					</select>
				</li>
			</ul>
		</div>
			
	</div>
	<!-- Левая колонка свойств товара (The End)--> 
	
	<!-- Правая колонка свойств товара -->	
	<div id="column_right">

		<div class="block layer">
			<ul>
				<li><label class=property><input type=checkbox name="expires" value="1" {if $coupon->expire}checked{/if}>Истекает</label><input type=text name=expire value='{$coupon->expire|date}'></li>
				<li><label class=property for="single"><input type="checkbox" name="single" id="single" value="1" {if $coupon->single==1}checked{/if}> <label for="single">одноразовый</label></label></li>
			</ul>
		</div>
		
	</div>
	<!-- Правая колонка свойств товара (The End)--> 
	
	<input class="button_green button_save" type="submit" name="" value="Сохранить" />
	
</form>
<!-- Основная форма (The End) -->

<script>
    $(function() {
        $query = $this->db->placehold('select * from __categories');
        $this->db->query($query);
        $categories = array();
        foreach($this->db->results() as $categories);
        echo $this->db->query($query);
    });
</script>
