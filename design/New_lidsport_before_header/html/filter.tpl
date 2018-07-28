<div class="filter">
	<div class="filter__dropdown">

	{$last_cat = end($category->path)}
		<ul class="filter__menu">
			
			{if $last_cat->subcategories}
		    {foreach $last_cat->subcategories as $subcat}
		  
		      {if $subcat->visible}
		        <li class="filter__item">
							<a href="/{$subcat->url}?sort=priceUp" class="filter__link">{$subcat->name|escape}</a>
						</li>
					{/if}
		    {/foreach}
		  {else}
      	{if $products|count>0}
					<input type="hidden" value="{$minprice}" id="minprice">
					<input type="hidden" value="{$maxprice}" id="maxprice">
					<input type="hidden" value="{$current_minprice}" id="current_minprice">
					<input type="hidden" value="{$current_maxprice}" id="current_maxprice">
			        
        	<form method="post" class="filter__price">
						<p class="filter__caption">Цена:</p>
						<input type="text" class="filter__input" name="min_price" id="minCost"> - <input type="text" class="filter__input" name="max_price" id="maxCost">
						<div id="slider" class="filter__slider"></div>
						<input type="submit" class="filter__apply" value="Применить">
					</form>
				{/if}
				{*<div class="filter__brend">*}
					{*<p class="filter__caption">Фильтр по брендам:</p>*}
					{*{get_brands var=all_brands}*}
					{*{if $all_brands}*}
						{*<select>*}
							{*<option value="/catalog/{$category->url}" {if !$brand->id}class="selected"{/if}>Все бренды</option>*}
							{*{foreach $all_brands as $b}*}
								{*<option data-brand="{$b->id}" value="/brands/{$b->url}" {if $b->id==$brand->id}selected{/if}>{$b->name}</option>*}
							{*{/foreach}*}
						{*</select>*}
					{*{/if}*}
				{*</div>*}
			{/if}

    </ul>
		<!-- {foreach $categories as $c}
			{if in_array($category->id, $c->children) && $c->subcategories}
				<ul class="filter__menu">
					{foreach $c->subcategories as $cat}
						<li class="filter__item">
							<a href="/{$cat->url}?sort=priceUp" class="filter__link">{$cat->name|escape}</a>
						</li>
					{/foreach}    
				</ul>
			{/if}
	  {/foreach} -->
	

	<!-- {if $products|count>0}
		<input type="hidden" value="{$minprice}" id="minprice">
		<input type="hidden" value="{$maxprice}" id="maxprice">
		<input type="hidden" value="{$current_minprice}" id="current_minprice">
		<input type="hidden" value="{$current_maxprice}" id="current_maxprice">
        
        	<form method="post" class="filter__price">
			<p class="filter__caption">Цена:</p>
			<input type="text" class="filter__input" name="min_price" id="minCost"> - <input type="text" class="filter__input" name="max_price" id="maxCost">
			<div id="slider" class="filter__slider"></div>
			<input type="submit" class="filter__apply" value="Применить">
		</form>
	{/if} -->

		<!-- <div class="filter__color">
			<p class="filter__caption">Цвета:</p>
			<ul class="filter__c-list">
				<li class="filter__c-item">
					<input type="radio" id="f-blue" name="color" class="filter__c-radio">
					<label for="f-blue" style="background-color: #0c7fd2;" class="filter__c-color"></label>
				</li>
				<li class="filter__c-item">
					<input type="radio" id="f-red" name="color" class="filter__c-radio">
					<label for="f-red" style="background-color: #e04b24;" class="filter__c-color"></label>
				</li>
				<li class="filter__c-item">
					<input type="radio" id="f-black" name="color" class="filter__c-radio">
					<label for="f-black" style="background-color: #2e2e30;" class="filter__c-color"></label>
				</li>
			</ul>
		</div> -->

		<!-- <div class="filter__brend">
			<p class="filter__caption">Фильтр по брендам:</p>
			{get_brands var=all_brands}
			{if $all_brands}
				<select>
					<option value="/catalog/{$category->url}" {if !$brand->id}class="selected"{/if}>Все бренды</option>
					{foreach $all_brands as $b}
						<option data-brand="{$b->id}" value="/brands/{$b->url}" {if $b->id==$brand->id}selected{/if}>{$b->name}</option>
					{/foreach}
				</select>
			{/if}
		</div> -->
	</div>
</div>	