{if $product->name}
  <div class="navigation">
    <div class="navigation__wrapper">
      <h1 class="navigation__title">{$product->name|escape}</h1>
      <nav class="navigation__list">
        <a href="/" class="navigation__item">Главная</a>
        {foreach from=$category->path item=cat}
        - <a href="/{$cat->url}" class="navigation__item">{$cat->name|escape}</a>
        {/foreach}
        - <span class="navigation__item">{$product->name|escape}</span>
      </nav>
    </div>
  </div>
{else}
  <div class="navigation">
    <div class="navigation__wrapper">
      <h1 class="navigation__title">{$category->name|escape}</h1>
      <nav class="navigation__list">
        <a href="/" class="navigation__item">Главная</a>
        {foreach from=$category->path item=cat name=cats}
            {if $smarty.foreach.cats.last}
              - <span class="navigation__item">{$cat->name|escape}</span>
            {else}
              - <a href="/{$cat->url}" class="navigation__item">{$cat->name|escape}</a>
            {/if}
        {/foreach}
      </nav>
      
	<div class="sorting__btn">
         <span>Сортировать по цене:</span>

		<a href="/{$cat->url}?sort=priceDown" class="sorting__link__down"><i class="fa fa-sort-desc" aria-hidden="true"></i>
</a>
                <a href="/{$cat->url}?sort=priceUp" class="sorting__link__up"><i class="fa fa-sort-asc" aria-hidden="true"></i>
</a>


	</div>	

    </div>
  </div>
{/if}

