<div class="filter">
	<div class="filter__wrapper">

		{$last_cat = end($category->path)}

		{if $last_cat->subcategories}
			<ul class="filter__menu">
				{foreach $last_cat->subcategories as $subcat}
					{if $subcat->visible}
						<li class="filter__menu-item">
							<a href="/{$subcat->url}/sort=priceUp" class="filter__menu-link">{$subcat->name|escape}</a>
						</li>
					{/if}
				{/foreach}
			</ul>

		{else}

			<div class="filter__section filter__section--reset">
				<a href="/{$category->url}" class="filter__reset-button">
					Очистить все фильтры
				</a>
			</div>
			{* Фильтр по цене *}
			{if $prices && ($prices->range->min|fconvert) != ($prices->range->max|fconvert)}
				<div class="filter__section filter__section--price">
					<div class="filter__section-title">Цена</div>
					<div class="filter__section-content">
						<input type="hidden" value="{furl params=[page=>null, sort=>null, 'price-min'=>null, 'price-max'=>null]}" id="priceurl">
						<input type="hidden" value="{$prices->range->min|fconvert}" id="minprice">
						<input type="hidden" value="{$prices->range->max|fconvert}" id="maxprice">
						<input type="hidden" value="{$prices->current->min|default:$prices->range->min|fconvert}" id="current_minprice">
						<input type="hidden" value="{$prices->current->max|default:$prices->range->max|fconvert}" id="current_maxprice">
						<div class="filter__price-row">
							<div class="filter__price-col">
								<input id="minCost" class="filter__price-input" type="text" name="min_price"/>
							</div>
							<div class="filter__price-col filter__price-col--separator"></div>
							<div class="filter__price-col">
								<input id="maxCost" class="filter__price-input" type="text" name="max_price"/>
							</div>
						</div>
						<div id="filter-slider" class="filter__price-slider"></div>
					</div>
				</div>
			{/if}
			{* /Фильтр по цене *}

			{* Фильтр по брендам
			{if $category->brands}
				<div class="filter__section filter__section--brand">
					<div class="filter__section-title">Фильтр по брендам:</div>
					<div class="filter__section-content">
						
						<a class="filter__section-link{if !$brand->id} filter__section-link{/if}"
							 href="/{$category->url}{get_url_params}">Все бренды
						</a>
						
						{foreach $category->brands as $b}
							<a class="filter__section-link{if $b->id == $brand->id} filter__section-link--selected{/if}"
                 href="/catalog/{$category->url}/{$b->url}{get_url_params}" >{$b->name|escape}</a>
						{/foreach}
					</div>
				</div>
			{/if}
			Фильтр по брендам *}

			{* Фильтр по свойствам *}
			{if $features}
				{foreach $features as $key=>$f}
          <div class="filter__section filter__section--features">
					<div class="filter__section-title">{$f->name}:</div>
					<div class="filter__section-content">
						
						<a class="filter__section-link{if !$smarty.get.{$f->url} && !$smarty.get.{$f@key}} filter__section-link--selected{/if}"
							 href="{furl params=[$f->url=>null, page=>null]}">Все</a>
						
						{foreach $f->options as $o}
							<a class="filter__section-link{if $smarty.get.{$f@key} && in_array($o->translit,$smarty.get.{$f@key})} filter__section-link--selected{/if}"
								 href="{furl params=[$f->url=>$o->translit, page=>null]}">{$o->value|escape}</a>
						{/foreach}
					</div>
				</div>
				{/foreach}
			{/if}
			{* /Фильтр по свойствам *}

		{/if}

	</div>	
</div>	