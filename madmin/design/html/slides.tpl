<link href="design/css/slides.css" rel="stylesheet" type="text/css" />
{capture name=tabs}
	<li class="active"><a href="index.php?module=SlidesAdmin">Слайдер</a></li>
{/capture}

{* Title *}
{$meta_title='Слайдер' scope=parent}

{* Заголовок *}
<div id="header">
	<h1>Слайдер</h1> 
	<a class="add" href="{url module=SlideAdmin return=$smarty.server.REQUEST_URI}">Добавить слайд</a>
</div>	

{if $slides}
<div id="list" class="slides">
	
	<form id="list_form" method="post">
	<input type="hidden" name="session_id" value="{$smarty.session.id}">

		<div id="list">
            {foreach $slides as $slide}
			<div class="{if !$slide->visible}invisible{/if} row">
				<input type="hidden" name="positions[{$slide->id}]" value="{$slide->position}" />
				
				<div class="cell slide">
					<div class="slide_wrapper">
						
						<div class="title">
							<input type="checkbox" name="check[]" value="{$slide->id}" />	
							<a href="{url module=SlideAdmin id=$slide->id return=$smarty.server.REQUEST_URI}">
							{$slide->name|escape}
							</a>
							<a class="delete" title="Удалить" href='#' ></a>
							<a class="enable" title="Активна" href="#"></a>
						</div>
						
						<div class="slide">
							<a href="{url module=SlideAdmin id=$slide->id return=$smarty.server.REQUEST_URI}">
							{if $slide->image}
							<img src="../{$slide->image}">
							{else}
							изображение не загружено
							{/if}
							</a>
						</div>
						
						{if $slide->image}
						<div class="tip">
							{$img_url=$config->root_url|cat:'/'|cat:$slide->image}
							{$img_url}
							{assign var="info" value=$img_url|getimagesize}<br />
							{$info.0}px X {$info.1}px
						</div>
						{/if}
					</div>

				</div>

				<div class="clear"></div>
			</div>
			{/foreach}
		</div>
		
		<div id="action">
			<label id="check_all" class="dash_link">Выбрать все</label>
		
			<span id="select">
			<select name="action">
				<option value="enable">Сделать видимыми</option>
				<option value="disable">Сделать невидимыми</option>
				<option value="delete">Удалить</option>
			</select>
			</span>
		
			<input id="apply_action" class="button_green" type="submit" value="Применить">
		</div>

	</form>

</div>
{else}
	Нет слайдов
{/if}
 
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
	
	// Сортировка списка
	$("#list").sortable({
		items:             ".row",
		tolerance:         "pointer",
		handle:            ".slide_wrapper",
		axis: 'y',
		scrollSensitivity: 40,
		opacity:           0.7, 
		forcePlaceholderSize: true,
		
		helper: function(event, ui){		
			if($('input[type="checkbox"][name*="check"]:checked').size()<1) return ui;
			var helper = $('<div/>');
			$('input[type="checkbox"][name*="check"]:checked').each(function(){
				var item = $(this).closest('.row');
				helper.height(helper.height()+item.innerHeight());
				if(item[0]!=ui[0]) {
					helper.append(item.clone());
					$(this).closest('.row').remove();
				}
				else {
					helper.append(ui.clone());
					item.find('input[type="checkbox"][name*="check"]').attr('checked', false);
				}
			});
			return helper;			
		},	
 		start: function(event, ui) {
  			if(ui.helper.children('.row').size()>0)
				$('.ui-sortable-placeholder').height(ui.helper.height());
		},
		beforeStop:function(event, ui){
			if(ui.helper.children('.row').size()>0){
				ui.helper.children('.row').each(function(){
					$(this).insertBefore(ui.item);
				});
				ui.item.remove();
			}
		},
		update:function(event, ui)
		{
			$("#list_form input[name*='check']").attr('checked', false);
			$("#list_form").ajaxSubmit(function() {
				colorize();
			});
		}
	});
	
	// Выделить все
	$("#check_all").click(function() {
		$('#list input[type="checkbox"][name*="check"]').attr('checked', 1-$('#list input[type="checkbox"][name*="check"]').attr('checked'));
	});	

	// Удалить
	$("a.delete").click(function() {
		$('#list input[type="checkbox"][name*="check"]').attr('checked', false);
		$(this).closest("div.row").find('input[type="checkbox"][name*="check"]').attr('checked', true);
		$(this).closest("form").find('select[name="action"] option[value=delete]').attr('selected', true);
		$(this).closest("form").submit();
	});

    // Включение и выключение изображения
    $("a.enable").click(function() {
        var icon        = $(this);
        var line        = icon.closest(".row");
        var id          = line.find('input[type="checkbox"][name*="check"]').val();
        var state       = line.hasClass('invisible')?1:0;
        icon.addClass('loading_icon');
        $.ajax({
            type: 'POST',
            url: 'ajax/update_object.php',
            data: {'object': 'slide', 'id': id, 'values': {'visible': state}, 'session_id': '{/literal}{$smarty.session.id}{literal}'},
            success: function(data){
                icon.removeClass('loading_icon');
                if(state)
                    line.removeClass('invisible');
                else
                    line.addClass('invisible');
            },
            dataType: 'json'
        });
        return false;
    });
	
	// Подтверждение удаления
	$("form").submit(function() {
		if($('#list input[type="checkbox"][name*="check"]:checked').length>0)
			if($('select[name="action"]').val()=='delete' && !confirm('Подтвердите удаление'))
				return false;	
	});
	
});
</script>
{/literal}