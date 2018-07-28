<link href="design/css/slides.css" rel="stylesheet" type="text/css" />
{capture name=tabs}
	<li class="active"><a href="index.php?module=SlidesAdmin">Слайдер</a></li>
{/capture}

{if $slide->id}
{$meta_title = $slide->name scope=parent}
{else}
{$meta_title = 'Новый слайд' scope=parent}
{/if}

{* On document load *}
{literal}
<script>
$(function() {

	// Удаление изображений
	$("a.button_slide_delete").click( function() {
		$("input[name='delete_image']").val('1');
		$(this).closest("ul").fadeOut(200, function() { $(this).remove(); });
		return false;
	});

});
</script>
{/literal}

{if $message_success}
<!-- Системное сообщение -->
<div class="message message_success">
	<span>{if $message_success=='added'}Слайд добавлен{elseif $message_success=='updated'}Слайд обновлен{else}{$message_success}{/if}</span>
	{if $smarty.get.return}
	<a class="button" href="{$smarty.get.return}">Вернуться</a>
	{/if}
</div>
<!-- Системное сообщение (The End)-->
{/if}

<!-- Основная форма -->
<form method=post  enctype="multipart/form-data">
	
	<input type=hidden name="session_id" value="{$smarty.session.id}">
		
	<ul class="slide">
		<li>
			<div><h2>{if $slide->id}Редактирование слайда{else}Добавление слайда{/if}</h2></div>
		</li>
		<li>
			<label>Название:</label>
			<div>
				<input class="name" name=name type="text" value="{$slide->name|escape}"/> 
				<input name=id type="hidden" value="{$slide->id|escape}"/> 
			</div>
		</li>
		<li>
			<label>Адрес:</label>
			<div>
				<input name="url" class="page_url" type="text" value="{$slide->url|escape}" />
				<div class="tip">Например: <strong>products/samsung-s5570-galaxy-mini</strong> или <strong>http://www.simplacms.ru</strong></div>
			</div>
		</li>
		<li>
			<label>Изображение:</label>
			<div>
				<ul>
					<li>
						<input class='upload_image' name=image type=file value="test">			
						<input type=hidden name="delete_image" value="">
						<input class="button_slide" type="submit" name="" value="{if $slide->image}Обновить{else}Загрузить{/if}" />
						
					</li>
					{if $slide->image}
					<ul>

						<li>
							<div class="tip">Файл: {$config->root_url}/{$slide->image}</div>
							<a href='#' class="button_slide_delete">Удалить</a>
						</li>
						<li class="image">
							
							<img src="../{$slide->image}" alt="" />
						</li>
						
					</ul>
					{/if}
				</ul>
			</div>
		</li>
		<li>
			<label>Описание:</label>
			<div>
				<textarea name="description" class="description">{$slide->description|escape}</textarea>
				<div class="tip">Описание выводится внизу изображения. Можно использовать html/css/js</div>
			</div>
		</li>
		<li>
			<input class="button_slide" type="submit" name="" value="Сохранить" />
		</li>
	</ul>

</form>
<!-- Основная форма (The End) -->