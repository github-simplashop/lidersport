{* Постраничный вывод *}

{if $total_pages_num>1}        

<!-- Листалка страниц -->
<div class="pagination">

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
	
	{if $current_page_num==2}
		<div class="pagination__item">
			<a class="pagination__link pagination__link--control pagination__link--control_prev" href="{url page=null}"></a>
		</div>
  {/if}
  {if $current_page_num>2}
  	<div class="pagination__item">
  		<a class="pagination__link pagination__link--control pagination__link--control_prev" href="{url page=$current_page_num-1}"></a>
  	</div>
  {/if}

	{* Ссылка на 1 страницу отображается всегда *}
  <div class="pagination__item">
		<a class="pagination__link{if $current_page_num==1} pagination__link--selected{/if}" href="{url page=null}">1</a>
	</div>
	
	{* Выводим страницы нашего "окна" *}	
	{section name=pages loop=$page_to start=$page_from}
	
		{$p = $smarty.section.pages.index+1}	
		<div class="pagination__item">
			{* Для крайних страниц "окна" выводим троеточие, если окно не возле границы навигации *}
			{if ($p == $page_from+1 && $p!=2) || ($p == $page_to && $p != $total_pages_num-1)}            
				<a class="pagination__link{if $p==$current_page_num} pagination__link--selected{/if}" href="{url page=$p}">...</a>
			{* Номер текущей выводимой страницы *}	
			{else}
				<a class="pagination__link{if $p==$current_page_num} pagination__link--selected{/if}" href="{url page=$p}">{$p}</a>
			{/if}
		</div>
		
	{/section}
	
	{* Ссылка на последнююю страницу отображается всегда *}
	<div class="pagination__item">
		<a class="pagination__link{if $current_page_num==$total_pages_num} pagination__link--selected{/if}" href="{url page=$total_pages_num}">{$total_pages_num}</a>
	</div>
	
  {if $total_pages_num > $current_page_num}
		<div class="pagination__item">
			<a class="pagination__link pagination__link--control pagination__link--control_next" href="{url page=$current_page_num+1}"></a>
		</div>
  {/if}
	
  <div class="pagination__item pagination__item--all">
    <a href="{url page=all}">Показать все</a>
  </div>
	

</div>
<!-- Листалка страниц (The End) -->
{/if}
