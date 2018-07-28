
{include file='slider/slider.tpl'}

<div class="advantages">
  <ul class="advantages__list">
    <li class="advantages__item">
      <img src="/design/{$settings->theme}/images/ico/number.png" alt="" class="advantages__ico">
      <p class="advantages__description">Более 5 000 наименований<br> товара.</p>
    </li>
    <li class="advantages__item">
      <img src="/design/{$settings->theme}/images/ico/delivery.png" alt="" class="advantages__ico">
      <p class="advantages__description">Доставка товара в любую точку<br> России и стран СНГ.</p>
    </li>
    <li class="advantages__item">
      <img src="/design/{$settings->theme}/images/ico/pay.png" alt="" class="advantages__ico">
      <p class="advantages__description">Наличные и безналичные расчеты!<br> Удобные системы оплаты.</p>
    </li>
    <li class="advantages__item">
      <img src="/design/{$settings->theme}/images/ico/dispatch.png" alt="" class="advantages__ico">
      <p class="advantages__description">Отправка товара в день<br> оформления заказа!</p>
    </li>
  </ul>
</div>

{get_featured_products var=featured_products}
{if $featured_products}
  <div class="sale">
    <div class="sale__wrapper wrapper">
      <h2 class="sale__title">Хиты продаж</h2>
      <div class="catalog">
        {foreach $featured_products as $product}
            <div class="catalog__item sale__item">

                {if $product->attachment_files_one}
                    <img class="product_action_img_list" src="/files/documents/{$product->attachment_files_one}" alt="">
                {/if}

                {if $product->variant->compare_price}
                    {if $product->variant->compare_price > 0}
                        {if $product->equally_compare_price > 0 && $product->equally_price > 0}
                            <span class="action_red_list">- {(($product->equally_compare_price - $product->equally_price) * 100 / $product->equally_compare_price)|string_format:"%d"} %</span>
                        {else}
                            <span class="action_red_list">до - {(($product->min_compare_price - $product->min_price) * 100 / $product->min_compare_price)|string_format:"%d"} %</span>
                        {/if}
                    {else}

                    {/if}
                {/if}

                <a href="/{$product->cat_url}/u_{$product->url}" class="catalog__image">


                    {if $product->images}
                        <img src="{$product->image->filename|escape|resize:190:140}" alt="{$product->name|escape}" class="catalog__picture">
                    {else}
                        <img src="/design/{$settings->theme}/images/defaultPhoto.png" alt="{$product->name|escape}" class="catalog__picture">
                    {/if}

                </a>
                <a href="/{$product->cat_url}/u_{$product->url}" class="catalog__caption">{$product->name|escape}</a>

                {if $product->variants|count < 2}
                    <form class="variants tocart products__to-cart">
                        {foreach $product->variants as $v}
                            {if $v->pod_zakaz == 1}
                                <div class="catalog__price catalog__price--none">Этот товар вы можете приобрести под заказ. Цену уточняйте по тел.: <br/> 8 (8652) 99-00-59</div>
                            {else}
                                <input id="variants_{$v->id}" name="variant" value="{$v->id}" type="radio" class="variant_radiobutton" {if $v@first}checked{/if} style="display: none;"/>
                                <div class="catalog__price">
                                    <span class="catalog__new {if $product->max_sale < 0}catalog__max-sale{/if}">{$v->price|convert} <i class="fa fa-rub"></i></span>
                                    {if $v->compare_price > 0}
                                        <span class="catalog__old">{$v->compare_price|convert} <i class="fa fa-rub"></i></span>
                                    {/if}
                                </div>
                                <div class="catalog__number number">
                                    <span class="number__caption">Количество</span>
                                    <span class="number__reduce">-</span>
                                    <span class="number__value">1</span>
                                    <span class="number__add">+</span>
                                </div>
                                <div class="catalog__add">
                                    <input type="submit" onclick="yaCounter36200345.reachGoal('CART'); return true;" class="catalog__button" data-result-text="в корзине" value="купить">
                                    {*<input type="submit" class="catalog__button" data-result-text="в корзине" value="купить">*}
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
                                    {if $product->equally_price > 0}
                                        <span class="catalog__new {if $product->max_sale < 0}catalog__max-sale{/if}">{$product->equally_price|convert} <i class="fa fa-rub"></i></span>
                                    {else}
                                        <span class="catalog__new {if $product->max_sale < 0}catalog__max-sale{/if}">от {$product->min_price|convert} <i class="fa fa-rub"></i></span>
                                    {/if}
                                    {if $v->compare_price > 0}
                                        {if $product->equally_compare_price > 0}
                                            <span class="catalog__old">{$product->equally_compare_price|convert} <i class="fa fa-rub"></i></span>
                                        {else}
                                            <span class="catalog__old">от {$product->min_compare_price|convert} <i class="fa fa-rub"></i></span>
                                        {/if}
                                    {else}
                                        <span class="catalog__old"></span>
                                    {/if}
                                </div>
                            {/if}
                            <div class="catalog__number number">
                                <span class="number__caption">Количество</span>
                                <span class="number__reduce">-</span>
                                <span class="number__value">1</span>
                                <span class="number__add">+</span>
                            </div>
                            <div class="catalog__add">
                                <input type="submit" onclick="yaCounter36200345.reachGoal('CART'); return true;" class="catalog__button catalog--choose" data-result-text="в корзине" product="{$product->id}" value="купить">
                                {*<input type="submit" class="catalog__button catalog--choose" data-result-text="в корзине" product="{$product->id}" value="купить">*}
                            </div>
                            <!-- <p class="catalog__prewie">Предпросмотр товара</p> -->
                        {/if}
                        {break}
                    {/foreach}
                {/if}
            </div>
        {/foreach}
      </div>
    </div>
  </div>
{/if}

<div class="about">
  <img src="/design/{$settings->theme}/images/woman.png" alt="woman" class="about__bg">
  <div class="about__wrapper wrapper">
    <p class="about__text">Лидерспорт – это сеть спортивных магазинов для всей семьи! Все для спорта и активного отдыха вы найдете в наших магазинах, вне зависимости от того являетесь ли вы профессиональным спортсменом или только начинаете вести здоровый образ жизни. Наши консультанты помогут найти оптимальное решение каждому покупателю, исходя из его потребностей и уровня спортивной подготовки.</p>
    <p class="about__text">Лидерспорт - это молодая динамично развивающая компания. Мы хотим стать ближе к каждому из вас! На сегодняшний день наши магазины представлены во все крупных районах города.</p>
    <p class="about__text">Мы тщательно следим за нашим ассортиментом и ценовой политикой, отбирая только лучших поставщиков, предоставляя вам качественные товары. Являемся дилерами многих российских производителей.</p>
    <div class="about__advantages">
      <div class="about__price">
        <img src="/design/{$settings->theme}/images/ico/star-yellow.svg" alt="star-ico" class="about__ico">
        <span>Лучшие цены</span>
      </div>
      <div class="about__quality">
        <img src="/design/{$settings->theme}/images/ico/chek_circle.svg" alt="chek-ico" class="about__ico">
        <span>Качественные товары</span>
      </div>
    </div>
  </div>
</div>
