{if $product->name}
  <div class="navigation">
    <div class="navigation__wrapper">
      {*<h1 class="navigation__title">{$product->content_title|escape}</h1>*}
      <nav class="navigation__list">
        <div class="navigation__breadcrumbs">
          <a href="/" class="navigation__item navigation__item__home">Главная</a>
          {foreach from=$category->path item=cat}
          - <a href="/{$cat->url}" class="navigation__item">{$cat->name|escape}</a>
          {/foreach}
          - <span class="navigation__item">{$product->name|escape}</span>
        </div>
      </nav>
    </div>
  </div>
{else}
  <div class="navigation">
    <div class="navigation__wrapper">
      <h1 class="navigation__title">{$category->content_title|escape}</h1>
      <nav class="navigation__list">
        <div class="navigation__breadcrumbs">
          <a href="/" class="navigation__item navigation__item__home">Главная</a>
          {foreach from=$category->path item=cat name=cats}
              {if $smarty.foreach.cats.last}
                - <span class="navigation__item">{$cat->name|escape}</span>
              {else}
                - <a href="/{$cat->url}" class="navigation__item">{$cat->name|escape}</a>
              {/if}
          {/foreach}
        </div>
      </nav>
    
  {$last_cat = end($category->path)}
    {if $last_cat->name == "Распродажа"}
        <div class="navigation__slide">
          
                <img src="/design/{$settings->theme}/images/sale-23-kategory.jpg" />
           
        </div>
    {/if}
    
    {if $last_cat->name == "Силовые тренажеры" || $last_cat->name == "Профессиональные"}
            <div class="navigation__slide">
                <a href="#accordion__delivery" id="scroll__delivery">
                    <img src="/design/{$settings->theme}/images/proffittrenajori_mini.jpg" />
                </a>
            </div>
        {/if}
        
         {if $last_cat->name == "Ролики"}
            <div class="navigation__slide">
                <a href="#accordion__delivery" id="scroll__delivery">
                    <img src="/design/{$settings->theme}/images/rolles.jpg" />
                </a>
            </div>
        {/if}
        
         {if $last_cat->name == "Гироскутеры" || $last_cat->name == "6.5 дюймов" || $last_cat->name == "8 дюймов" || $last_cat->name == "10 дюймов" || $last_cat->name == "10.5 дюймов"}
            <div class="navigation__slide">
                <a href="#accordion__delivery" id="scroll__delivery">
                    <img src="/design/{$settings->theme}/images/giroskyteri.jpg" />
                </a>
            </div>
        {/if}
        
        {if $last_cat->name == "Кардиотренажеры" || $last_cat->name == "Запчасти для тренажеров" || $last_cat->name == "Массажеры электрические" || $last_cat->name == "Домашние" || $last_cat->name == "Велотренажеры" || $last_cat->name == "Степперы" || $last_cat->name == "Эллиптические" || $last_cat->name == "Массажеры электрические" || $last_cat->name == "Беговые дорожки" || $last_cat->name == "Тренажеры"}
            <div class="navigation__slide">
                <a href="#accordion__delivery" id="scroll__delivery">
                    <img src="/design/{$settings->theme}/images/obshiibannerdlyatrenajorov1_mini.jpg" />
                </a>
            </div>
        {/if}
    {if !$last_cat->subcategories}
        {if $last_cat->name == "Ёлки искусственные"}
            <div class="navigation__slide">
              <a id="popup__eli" href="#">
                <img src="/design/{$settings->theme}/images/eli_icon.jpg" />
              </a>
            </div>
        {/if}
        
       {if $last_cat->name == "Уличные тренажеры" || $last_cat->name == "Для улицы"}
            <div class="navigation__slide">
                <a href="#accordion__delivery" id="scroll__delivery">
                    <img src="/design/{$settings->theme}/images/streettrenajori_mini.jpg" />
                </a>
            </div>
        {/if}
        

        {if $last_cat->name == "Снегокаты"}
            <div class="navigation__slide">
                <a id="popup__snegokaty" href="#">
                    <img src="/design/{$settings->theme}/images/snegokaty_icon.jpg" />
                </a>
            </div>
        {/if}

        {if $last_cat->name == "Санки и ледянки"}
            <div class="navigation__slide">
                <a id="popup__sanki" href="#">
                    <img src="/design/{$settings->theme}/images/sanki_icon.jpg" />
                </a>
            </div>
        {/if}

    	<div class="sorting__btn">
             <span>Сортировать по цене:</span>

    		<a href="/{$cat->url}?sort=priceDown" class="sorting__link__down"><i class="fa fa-sort-desc" aria-hidden="true"></i>
    </a>
                    <a href="/{$cat->url}?sort=priceUp" class="sorting__link__up"><i class="fa fa-sort-asc" aria-hidden="true"></i>
    </a>


    	</div>
    {/if}

    </div>
  </div>
{/if}

