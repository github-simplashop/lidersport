{capture name=tabs}
    <li><a href="index.php?module=ProductsAdmin">Товары</a></li>
	<li><a href="index.php?module=CategoriesAdmin">Категории</a></li>
	<li><a href="index.php?module=BrandsAdmin">Бренды</a></li>
	<li><a href="index.php?module=FeaturesAdmin">Свойства</a></li>
    <li class="active"><a href='index.php?module=TagsAdmin'>Теги</a></li>
{/capture}

{* Title *}
{$meta_title='Теги' scope=parent}

{* Поиск *}
{if $tags || $keyword}
<form method="get">
<div id="search">
	<input type="hidden" name="module" value='TagsAdmin'>
	<input class="search" type="text" name="keyword" value="{$keyword|escape}" />
	<input class="search_button" type="submit" value=""/>
</div>
</form>
{/if}
		
{* Заголовок *}
<div id="header">
	{if $keyword && $tags_count}
	<h1>{$tags_count|plural:'Нашелся':'Нашлись':'Нашлись'} {$tags_count} {$tags_count|plural:'тег':'тегов':'тега'}</h1>
	{elseif $tags_count}
	<h1>{$tags_count} {$tags_count|plural:'тег':'тегов':'тега'}</h1>
	{else}
	<h1>Нет тегов</h1>
	{/if}
	<a class="add" href="{url module=TagAdmin return=$smarty.server.REQUEST_URI}">Добавить тег</a>
</div>	

{if $tags}
<div id="main_list">
	
	<!-- Листалка страниц -->
	{include file='pagination.tpl'}	
	<!-- Листалка страниц (The End) -->

	<form id="form_list" method="post">
	<input type="hidden" name="session_id" value="{$smarty.session.id}">
	
		<div id="list">
			{foreach $tags as $tag}
			<div class="row">
		 		<div class="checkbox cell">
					<input type="checkbox" name="check[]" value="{$tag->id}" />				
				</div>
				<div class="name cell">		
					<a href="{url module=TagAdmin id=$tag->id return=$smarty.server.REQUEST_URI}">{$tag->name|escape}</a>
                    {if !$tag->url}(Пустой url тега){/if}
				</div>
				<div class="icons cell">
                    {if !$tag->url}
                        <img src='design/images/error.png' alt='Пустой url тега' title='Пустой url тега' >
                    {else}
                        <a class="preview" title="Предпросмотр в новом окне" href="../tags/{$tag->url}" target="_blank"></a>
                    {/if}
					<a class="delete" title="Удалить" href="#"></a>
				</div>
				<div class="clear"></div>
			</div>
			{/foreach}
		</div>
		
	
		<div id="action">
		<label id="check_all" class="dash_link">Выбрать все</label>
	
		<span id="select">
		<select name="action">
			<option value="delete">Удалить</option>
		</select>
		</span>
	
		<input id="apply_action" class="button_green" type="submit" value="Применить">
		
		</div>
				
	</form>	

	<!-- Листалка страниц -->
	{include file='pagination.tpl'}	
	<!-- Листалка страниц (The End) -->
	
</div>
{/if}

{* On document load *}
{literal}

<script>
$(function() {

	// Раскраска строк
	function colorize()
	{
		$("#list div.row:even").addClass('even');
		$("#list div.row:odd").removeClass('even');
	}
	// Раскрасить строки сразу
	colorize();

	// Выделить все
	$("#check_all").click(function() {
		$('#list input[type="checkbox"][name*="check"]').attr('checked', $('#list input[type="checkbox"][name*="check"]:not(:checked)').length>0);
	});	

	// Удалить 
	$("a.delete").click(function() {
		$('#list input[type="checkbox"][name*="check"]').attr('checked', false);
		$(this).closest(".row").find('input[type="checkbox"][name*="check"]').attr('checked', true);
		$(this).closest("form").find('select[name="action"] option[value=delete]').attr('selected', true);
		$(this).closest("form").submit();
	});
	
	// Подтверждение удаления
	$("form").submit(function() {
		if($(this).find('select[name="action"]').val()=='delete' && !confirm('Подтвердите удаление'))
			return false;	
	});
});

</script>
{/literal}