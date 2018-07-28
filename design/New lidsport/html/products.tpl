<div class="wrapper">
{include file='filter.tpl'}
  <div class="window">
    {include file='navigation.tpl'}
    <div class="catalog">
      {foreach $products as $product}
        <div class="catalog__item">
          <a href="/{$product->cat_url}/u_{$product->url}" class="catalog__image">
            {if $product->imagesc}
              <img src="/images1c/{$product->imagesc}" alt="{$product->name|escape}" class="catalog__picture">
              {else}{if $product->image}
                <img src="{$product->image->filename|resize:190:140}" alt="{$product->name|escape}" class="catalog__picture">
              {else}
                <img src="/design/{$settings->theme}/images/defaultPhoto.png" alt="{$product->name|escape}" class="catalog__picture">
              {/if}
            {/if}
          </a>
          <a href="/{$product->cat_url}/u_{$product->url}" class="catalog__caption">{$product->name|escape}</a>
          {if $product->variants|count < 2}
            <form class="variants tocart" action="/cart">
              {foreach $product->variants as $v}
                {if $v->pod_zakaz == 1}
                  <div class="catalog__price catalog__price--none">Этот товар вы можете приобрести под заказ. Цену уточняйте по тел.:22-15-77</div>
                {else}
                  <input id="variants_{$v->id}" name="variant" value="{$v->id}" type="radio" class="variant_radiobutton" {if $v@first}checked{/if} style="display: none;"/>
                  <div class="catalog__price">
                    {if $v->compare_price > 0}
                      <span class="catalog__old">{$v->compare_price|convert}</span>
                    {/if}
                    <span class="catalog__new">{$v->price|convert} <i class="fa fa-rub"></i></span>
                  </div>
                  <div class="catalog__number number">
                    <span class="number__caption">Количество</span>
                    <span class="number__reduce">-</span>
                    <span class="number__value">1</span>
                    <span class="number__add">+</span>
                  </div>
                  <div class="catalog__add">
                    <input type="submit" class="catalog__button" data-result-text="в корзине" value="купить">
                  </div>
                  <!-- <p class="catalog__prewie">Предпросмотр товара</p> -->
                {/if}
              {/foreach}
            </form>

          {elseif $product->variants|count > 1}
            {foreach $product->variants as $v}
              {if $v->pod_zakaz == 1}
                <div class="catalog__price catalog__price--none">Этот товар вы можете приобрести под заказ. Цену уточняйте по тел.:22-15-77</div>
              {else}
                {if $product->min_price}
                  <div class="catalog__price">
                    {if $v->compare_price > 0}
                      <span class="catalog__old">{$v->compare_price|convert}</span>
                    {/if}
                    <span class="catalog__new">от {$product->min_price|convert} <i class="fa fa-rub"></i></span>
                  </div>
                {/if}
                <div class="catalog__number number">
                  <span class="number__caption">Количество</span>
                  <span class="number__reduce">-</span>
                  <span class="number__value">1</span>
                  <span class="number__add">+</span>
                </div>
                <div class="catalog__add">
                  <input type="submit" class="catalog__button catalog--choose" data-result-text="в корзине" product="{$product->id}" value="купить">
                </div>
                <!-- <p class="catalog__prewie">Предпросмотр товара</p> -->
              {/if}
            {break}
            {/foreach} 
          {/if} 

        </div>
      {/foreach}
    </div>

    {include file='pagination.tpl'}
  </div>
  {if $category->description}
    <div class="annotation">
      <h2 class="annotation__title">{$category->content_title|escape}</h2>
      {$category->description}
    </div>
  {/if}
</div>