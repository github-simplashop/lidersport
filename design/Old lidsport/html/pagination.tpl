{* Постраничный вывод *}

{if $total_pages_num>1}
{* Скрипт для листания через ctrl → *}
{* Ссылки на соседние страницы должны иметь id PrevLink и NextLink *}
<script type="text/javascript" src="js/ctrlnavigate.js"></script>                 
<div class="pagination mt20 mb20 ml20 fl">
	<span class="fl">Страницы:</span>
    <ul>
	{* Количество выводимых ссылок на страницы *}
	{$visible_pages = 11}

	{* По умолчанию начинаем вывод со страницы 1 *}
	{$page_from = 1}
	
	{* Если выбранная пользователем страница дальше середины "окна" - начинаем вывод уже не с первой *}
	{if $current_page_num > floor($visible_pages/2)}
		{$page_from = max(1, $current_page_num-floor($visible_pages/2)-1)}
	{/if}	
	
	{* Если выбранная пользователем страница близка к концу навигации - начинаем с "конца-окно" *}
	{if $current_page_num > $total_pages_num-ceil($visible_pages/2)}
		{$page_from = max(1, $total_pages_num-$visible_pages-1)}
	{/if}
	
	{* До какой страницы выводить - выводим всё окно, но не более ощего количества страниц *}
	{$page_to = min($page_from+$visible_pages, $total_pages_num-1)}

	{* Ссылка на 1 страницу отображается всегда *}
	<li><a {if $current_page_num==1}class="selected"{/if} href="{url page=null}">1</a></li>
	
	{* Выводим страницы нашего "окна" *}	
	{section name=pages loop=$page_to start=$page_from}
		{* Номер текущей выводимой страницы *}	
		{$p = $smarty.section.pages.index+1}	
		{* Для крайних страниц "окна" выводим троеточие, если окно не возле границы навигации *}	
		{if ($p == $page_from+1 && $p!=2) || ($p == $page_to && $p != $total_pages_num-1)}	
		<li></<a {if $p==$current_page_num}class="selected"{/if} href="{url page=$p}">...</a></li>
		{else}
		<li><a {if $p==$current_page_num}class="selected"{/if} href="{url page=$p}">{$p}</a></li>
		{/if}
	{/section}

	{* Ссылка на последнююю страницу отображается всегда *}
	<li><a {if $current_page_num==$total_pages_num}class="selected"{/if}  href="{url page=$total_pages_num}">{$total_pages_num}</a></li>
	
	<li><a href="{url page=all}">∞</a></li>
	{if $current_page_num==2}<li><a class="prev" href="{url page=null}">&#8249;</a>{/if}</li>
	{if $current_page_num>2}<li><a class="prev" href="{url page=$current_page_num-1}">&#8249;</a>{/if}</li>
	{if $current_page_num<$total_pages_num}<li><a class="next" href="{url page=$current_page_num+1}">›</a>{/if}</li>
	</ul>
</div>
{/if}