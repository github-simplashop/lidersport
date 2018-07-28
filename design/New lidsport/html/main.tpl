<div class="slider">
  
  <div class="slider__item">
    <a href="/bassejny">
      <img src="/ban6.jpg" alt="Бассейны" class="slider__image">
    </a>
  </div>
  <div class="slider__item">
    <a href="/giroskutery?sort=priceUp">
      <img src="/ban1.jpg" alt="Гироскутеры" class="slider__image">
    </a>
  </div>
  <div class="slider__item">
    <a href="/velosipedy?sort=priceUp">
      <img src="/ban2.jpg" alt="Велосипеды" class="slider__image">
    </a>
  </div>
  <div class="slider__item">
    <a href="/detskie-2_h-i-4_h-kolesnye?sort=priceUp">
      <img src="/ban9.jpg" alt="Велосипеды" class="slider__image">
    </a>
  </div>
  <div class="slider__item">
    <a href="/samokaty?sort=priceUp">
      <img src="/ban3.jpg" alt="Самокаты" class="slider__image">
    </a>
  </div>
  <div class="slider__item">
    <a href="/roliki?sort=priceUp">
      <img src="/ban4.jpg" alt="Ролики" class="slider__image">
    </a>
  </div>
  <div class="slider__item">
    <a href="/aktivnye-igry?sort=priceUp">
      <img src="/ban1-1-1.jpg" alt="Спиннеры" class="slider__image">
    </a>
  </div>
</div>

<div class="advantages">
  <ul class="advantages__list">
    <li class="advantages__item">
      <img src="/design/{$settings->theme}/images/ico/number.png" alt="" class="advantages__ico">
      <p class="advantages__description">Более 2 000 000 наименований<br> товара.</p>
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
      <h2 class="sale__title">Распродажа дня</h2>
      <div class="catalog">
        {foreach $featured_products as $product}
          <div class="catalog__item">
            <a href="/{$product->cat_url}/u_{$product->url}" class="catalog__image">
              {if $product->imagesc}
                <img src="/images1c/{$product->imagesc}" alt="{$product->name|escape}" class="catalog__picture">
                {else} 
                {if $product->image}
                  <img src="{$product->image->filename|resize:190:140}" alt="{$product->name|escape}" class="catalog__picture">
                {else}
                  <img src="/design/lidsport/images/defaultPhoto.png" alt="{$product->name|escape}" class="catalog__picture">
                {/if}
              {/if}
            </a>
            <a href="/{$product->cat_url}/u_{$product->url}" class="catalog__caption">{$product->name|escape}</a>

            {if $product->variants|count < 2 && $product->variants|count != 0}
              <!-- Выбор варианта товара -->
              <form class="variants tocart" action="/cart">
                {foreach $product->variants as $v}
                  {if $v->pod_zakaz == 1}
                    <div class="catalog__price catalog__price--none">Этот товар вы можете приобрести под заказ. Цену уточняйте по тел.:511-777</div>
                  {else}
                    <input id="variants_{$v->id}" name="variant" value="{$v->id}" type="radio" class="variant_radiobutton" {if $v@first}checked{/if} style="display:none;"/>
                    {if $v->compare_price > 0}
                      <span class="catalog__old">{$v->compare_price|convert}</span>
                    {/if}
                    <span class="catalog__new">{$v->price|convert} <i class="fa fa-rub"></i></span>
                    <div class="catalog__number number">
                      <span class="number__caption">Количество</span>
                      <span class="number__reduce">-</span>
                      <span class="number__value">1</span>
                      <input type="hidden" name="amount" value="2">
                      <span class="number__add">+</span>
                    </div>
                    <div class="catalog__add">
                      <input type="submit" class="catalog__button" data-result-text="добавлено" value="В корзину">
                    </div>
                  {/if}
                {/foreach}
              </form>
              <!-- Выбор варианта товара (The End) -->
              {elseif $product->variants|count >1}
                {foreach $product->variants as $v}
                  {if $v->pod_zakaz == 1}
                    <div class="catalog__price catalog__price--none">Этот товар вы можете приобрести под заказ. Цену уточняйте по тел.:511-777</div>
                  {else}
                    <input id="variants_{$v->id}" name="variant" value="{$v->id}" type="radio" class="variant_radiobutton" {if $v@first}checked{/if} style="display:none;"/>
                    {if $v->compare_price > 0}
                      <span class="catalog__old">{$v->compare_price|convert}</span>
                    {/if}
                    <span class="catalog__new">{$v->price|convert} <i class="fa fa-rub"></i></span>
                    <div class="catalog__number number">
                      <span class="number__caption">Количество</span>
                      <span class="number__reduce">-</span>
                      <span class="number__value">1</span>
                      <input type="hidden" name="amount" value="2">
                      <span class="number__add">+</span>
                    </div>
                    <div class="catalog__add">
                      <input type="submit" class="catalog__button catalog--choose" product="{$product->id}" data-result-text="добавлено" value="В корзину">
                    </div>
                  {/if}
                {break}
                {/foreach}
              {else}
                <div class="out-of-stock" style="margin-top: -22px;">
                  <span style="font-size: 20px;">Под заказ</span>
                  <span style="display: block;font-size: 14px;">цены уточняйте у продавцов-консультантов</span>
                </div>
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