<!DOCTYPE html>
{*
  Общий вид страницы
  Этот шаблон отвечает за общий вид страниц без центрального блока.
*}
<html>
<head>
  <title>{if $module=='MainView' or $module=='NewsView' or $module=='OrderView' or $module=='RegisterView' or $module=='StockView' or $module=='UserView' or $module=='CartView' or $module=='FeedbackView' or $module=='BlogView' or ($module=='PageView' and !$product and !$products)}{$meta_title|escape}{else} Купить {mb_strtolower($meta_title)|escape} с доставкой и недорого в интернет магазине Лидерспорт Ставрополь: цены, отзывы, акции, скидки{/if}</title>

  <meta name='yandex-verification' content='73e703aa7eb82fe0' />
  
  {* Метатеги *}
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="description" content="{if $module=='MainView' or $module=='NewsView' or $module=='OrderView' or $module=='RegisterView' or $module=='StockView' or $module=='UserView' or $module=='CartView' or $module=='FeedbackView' or $module=='BlogView' or ($module=='PageView' and !$product and !$products)}{$meta_description|escape}{else}Купить {mb_strtolower($meta_title)|escape} недорого можно в магазинах Лидерспорт в Ставрополе или заказать с доставкой по России в нашем интернет магазине. Переходите на сайт, чтобы узнать цены, посмотреть скидки, акции и распродажи на {mb_strtolower($meta_title)|escape}{/if}" />

  <meta name="keywords" content="{$meta_title|escape}, {$meta_keywords|escape}" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" >
  <meta name="google-site-verification" content="N7c33DNkhR0TwD7NnD4f9AW_crlAWVtaTWBYt7uGLNA" />

  <link href="/favicon.ico" rel="icon" type="image/x-icon"/>

 {* JQuery *}
  <script type="text/javascript" src="/design/{$settings->theme}/js/libs.min.js"></script>
  <script src="/design/{$settings->theme}/js/jquery.cookie.js" type="text/javascript"></script>

  {* CSS *}
  <link rel="stylesheet" type="text/css" href="/design/{$settings->theme}/css/libs.min.css">
  <link rel="stylesheet" type="text/css" href="/design/{$settings->theme}/css/main.css">

  <link rel="stylesheet" type="text/css" href="/slider/OwlCarousel2-2.2.1/dist/assets/owl.carousel.min.css" media="screen" />
  <link rel="stylesheet" type="text/css" href="/slider/OwlCarousel2-2.2.1/dist/assets/owl.theme.green.min.css" media="screen" />

</head>
<body>
  <div class="container">
    <header class="header">
      <div class="header__info">
        <div class="header__wrapper wrapper">
          <div class="header__city">Ваш город - <span class="header__town">Определение</span></div>
          <a href="/dostavka-i-oplata" class="header__delivery">Доставка и оплата</a>
          <a href="/contact" class="header__adress">Адреса магазинов</a>
          <a href="tel:+78652221577" class="header__phone">8-8652-22-15-77</a>
          <div class="header__time">ждем звонки с 9:00 до 20:00</div>
        </div>
      </div>

      <div class="header__middle">
        <div class="header__wrapper wrapper">
          <a href="/" class="header__logo">

            <img src="/design/{$settings->theme}/images/logo.png" alt="logo">
          </a>
          <form action="/products" id="search-form" class="header__search search">
            <input type="text" class="search__input" name="keyword" placeholder="Поиск среди 5 000 товаров" autocomplete="off">
            <input type="submit" id="search-button" class="search__button" value="Найти">
          </form>

          {if $user}
            <div class="header__enter enter">
              <a href=/user/logout class="enter__button">Выйти</a>
              <a href="/user" class="enter__description">{$user->name}</a>
            </div>
          {else}
            <div class="header__enter enter">
              <div class="enter__button" data-popup-button="enter">Войти</div>
              <div class="enter__description" data-popup-button="register">Зарегистрироваться</div>
            </div>
          {/if}

          {include file='cart_informer.tpl'}
        </div>
      </div>

      <!-- PC menu -->
      <div class="header__navigation">
        <div class="header__wrapper wrapper">
          <div class="header__button">



            <span class="header__button-name">Каталог товаров</span>
            <nav class="header__menu menu">
              <!-- Displaying menu items -->

              {foreach $categories as $cat}
                {if $cat->visible && $cat->name != "Распродажа"}
                  {if $cat->subcategories}
                    <div class="menu__item">
                      <a href="/{$cat->url}" class="menu__link">
                        <span class="menu__link__name">{$cat->name|escape}</span>
                        <span class="menu__link__style"></span>
                      </a>
                      <div class="menu__navigation">
                        <div class="menu__navigation__body">
                          {foreach $cat->subcategories as $subcat}
                            {if $subcat->visible}
                              <div class="menu__navigation__item">
                                <a href="/{$subcat->url}" class="menu__subcat">
                                  <span class="">{$subcat->name|escape}</span>
                                </a>
                                {foreach $subcat->subcategories as $subcat_subcat}
                                  {if $subcat_subcat->visible}
                                        <a href="/{$subcat_subcat->url}" class="menu__subcat__subcat">
                                          <span class="">{$subcat_subcat->name|escape}</span>
                                        </a>
                                  {/if}
                                {/foreach}
                              </div>
                            {/if}
                          {/foreach}
                        </div>
                      </div>
                    </div>

                  {else}
                    <div class="menu__item">
                      <p style="display: none">{$cat->name|escape}</p>
                      <a href="/{$cat->url}" class="menu__link">
                        <span class="menu__link__name">{$cat->name|escape}</span>
                      </a>
                    </div>
                  {/if}

                {/if}
              {/foreach}

            </nav>
          </div>
          <!-- End PC menu -->

          <div class="search-ico"></div>
        
          <a href="/aktivnyj-otdyh" class="header__item">Активный отдых</a>
          <a href="/edinoborstva" class="header__item">Единоборства</a>
          {*<a href="/zimnie-tovary" class="header__item">Зимние товары</a>*}
          {*<a href="/elki-iskusstvennye" class="header__item">Ёлки искусственные</a>*}
          <a href="/plavanie" class="header__item">Плавание</a>
          <a href="/sportivnye-kompleksy-i-batuty" class="header__item">Спорткомлексы</a>
          <a href="/sale?page=all" class="header__item header__item--icon header__item--23sale">Распродажа</a>
          <a href="/stock" class="header__item header__item--icon header__item--shares">Акции</a>

        </div>
      </div>

      <div class="header__overlay"></div>

      <!-- Desctop menu -->
       <nav class="m-menu"><!-- <h2 style="display:none">Каталог товаров</h2> -->
        <img src="/design/{$settings->theme}/images/ico/close_mobile_menu.svg" alt="close" class="m-menu__close">
        <!-- Displaying desctop menu items -->

        {foreach $categories as $cat}
          {if $cat->visible  && $cat->name != "Распродажа"}

            <div class="m-menu__item">

              <div class="m-menu__caption">
                <a href="/{$cat->url}" class="m-menu__link">{$cat->name|escape}</a>
                <img src="/design/{$settings->theme}/images/ico/arrow_menu.svg" alt="arrow" class="m-menu__arrow">
              </div>

              <ul class="m-menu__navigation">

                {foreach $cat->subcategories as $subcat}
                  {if $subcat->visible}

                    <li class="m-menu__item">
                      <a href="/{$subcat->url}" class="m-menu__link">{$subcat->name|escape}</a>

                      {foreach $subcat->subcategories as $subcat_subcat}
                        {if $subcat_subcat->visible}
                              <a href="/{$subcat_subcat->url}" class="m-menu__link">
                                - {$subcat_subcat->name|escape}
                              </a>
                        {/if}
                      {/foreach}

                    </li>

                  {/if}
                {/foreach}

              </ul>
            </div>
          {/if}
        {/foreach}

        <!-- End displaying desctop menu items -->
      </nav>
      <!-- End desctop menu -->
       <!-- <meta name="description" content="{$meta_title|escape}, {$meta_description|escape}" />  старый вариант-->
    </header>