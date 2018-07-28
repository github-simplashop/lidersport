<!DOCTYPE html>
{*
  Общий вид страницы
  Этот шаблон отвечает за общий вид страниц без центрального блока.
*}
<html>
<head>
  <title>Лидерспорт — {$meta_title|escape}</title>
  <meta name='yandex-verification' content='73e703aa7eb82fe0' />
  
  {* Метатеги *}
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="description" content="{$meta_title|escape}, {$meta_description|escape}" />
  <meta name="keywords"    content="{$meta_title|escape}, {$meta_keywords|escape}" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" >
  <link href="/favicon.ico" rel="icon" type="image/x-icon"/>
  
  {* JQuery *}
  <script type="text/javascript" src="/design/{$settings->theme}/js/libs.min.js"></script>

  {* CSS *}
  <link rel="stylesheet" type="text/css" href="/design/{$settings->theme}/css/libs.min.css">
  <link rel="stylesheet" type="text/css" href="/design/{$settings->theme}/css/style.css">
  
  <script src="/design/{$settings->theme}/js/jquery.cookie.js" type="text/javascript"></script>
    
  {literal}
    <script type="text/javascript">
      $(document).on("click",".podobrat_value",function(e){
        e.preventDefault();
        $(".podobrat_razm").attr("src",$(".podobrat_value").attr("src"));
        var width = $(".podobrat_value").attr("w");
        var marginL = width/2;
        console.log(width+" "+marginL);
        $(".podobrat_razm").css("width",width+"px");
        $(".podobrat_razm").css("margin-left","-"+marginL+"px");
        $("#wrap, .podobrat_razm").show();
        return false;
      });


      $(document).on("click",".data",function(e) {
        e.preventDefault();
        var id = $(this).attr("product");
        $.ajax({
          url: "/price/productInCatalog.php",
          type: "GET",
          data: {
            "productId" : id,
          },
          success: function(data){
            $('#windowInside').html(data);
          }
        });
        $("#wrap, #window").show();
        return false;
      });
    </script>
  {/literal}
  
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
            <input type="text" class="search__input" name="keyword" placeholder="Поиск среди 2 000 000 товаров" autocomplete="off">
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
            <span>Каталог товаров</span>
            <nav class="header__menu menu">
              <!-- Displaying menu items -->
              <div class="menu__item">
                <a href="/bassejny-i-aksessuary?sort=priceUp" class="menu__link">Бассейны и аксессуары</a>
                <table class="menu__navigation">
                  <tbody>
                    <tr>
                      <td>
                        <a href="/akssesuary-dlya-plyazha?sort=priceUp" class="menu__link">
                          <p class="menu__link">Акссесуары для пляжа</p>
                          <img src="/files/categories/59586.1024x1024w.jpg" alt="Акссесуары для пляжа" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/akssesuary-dlya-plyazha?sort=priceUp" class="menu__link">
                          <p class="menu__link">Бассейны</p>
                          <img src="/files/categories/intex-28200-3.jpg" alt="Бассейны" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/akssesuary-dlya-plyazha?sort=priceUp" class="menu__link">
                          <p class="menu__link">Акссесуары для бассейнов</p>
                          <img src="/files/categories/тент 28020 д.круглых бассейнов 244 см.1024x1024w.jpg" alt="Акссесуары для бассейнов" class="menu__image">
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="/akssesuary-dlya-plyazha?sort=priceUp" class="menu__link">
                          <p class="menu__link">Химия для бассейнов</p>
                          <img src="/files/categories/химия.jpg" alt="Химия для бассейнов" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/akssesuary-dlya-plyazha?sort=priceUp" class="menu__link">
                          <p class="menu__link">Кровати, матрасы, кресла</p>
                          <img src="/files/categories/66950.1024x1024w.jpg" alt="Кровати, матрасы, кресла" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/akssesuary-dlya-plyazha?sort=priceUp" class="menu__link">
                          <p class="menu__link">Насосы INTEX, BestWay</p>
                          <img src="/files/categories/Насос 68605.jpg" alt="Насосы INTEX, BestWay" class="menu__image">
                        </a>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>

              <div class="menu__item">
                <a href="/roliki-skejty-samokaty-giroskutery?sort=priceUp" class="menu__link">Ролики, скейты, самокаты</a>
                <table class="menu__navigation">
                  <tbody>
                    <tr>
                      <td>
                        <a href="/giroskutery?sort=priceUp" class="menu__link">
                          <p class="menu__link">Гироскутеры</p>
                          <img src="/files/categories/гироскутер.jpg" alt="Гироскутеры" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/zaschita-i-aksessuary?sort=priceUp" class="menu__link">
                          <p class="menu__link">Защита и аксессуары</p>
                          <img src="/files/catalog/paa.jpg" alt="Защита и аксессуары" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/roliki?sort=priceUp" class="menu__link">
                          <p class="menu__link">Ролики</p>
                          <img src="/files/catalog/rollers.jpg" alt="Ролики" class="menu__image">
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="/samokaty?sort=priceUp" class="menu__link">
                          <p class="menu__link">Самокаты</p>
                          <img src="/files/catalog/scooter.jpg" alt="Самокаты" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/skejty?sort=priceUp" class="menu__link">
                          <p class="menu__link">Скейты</p>
                          <img src="/files/catalog/skateboard.jpg" alt="Скейты" class="menu__image">
                        </a>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>

              <div class="menu__item">
                <a href="/zimnie-tovary?sort=priceUp" class="menu__link">Зимние товары</a>
                <table class="menu__navigation">
                  <tbody>
                    <tr>
                      <td>
                        <a href="/hokkej?sort=priceUp" class="menu__link">
                          <p class="menu__link">Хоккей</p>
                          <img src="/files/categories/123123441.jpg" alt="Хоккей" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/elki-i-bengalskie-ogni?sort=priceUp" class="menu__link">
                          <p class="menu__link">Ёлки и бенгальские огни</p>
                          <img src="/files/categories/Ель-рождественская-Р12.jpg" alt="Ёлки и бенгальские огни" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/termobele?sort=priceUp" class="menu__link">
                          <p class="menu__link">Термобелье</p>
                          <img src="/files/categories/38576661.jpg" alt="Термобелье" class="menu__image">
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="/zimnij-inventar?sort=priceUp" class="menu__link">
                          <p class="menu__link">Зимний инвентарь</p>
                          <img src="/files/categories/Лыжи с палками AbsoluteChempion.JPG" alt="Зимний инвентарь" class="menu__image">
                        </a>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>

              <div class="menu__item">
                <a href="/basketbol-volejbol-futbol.?sort=priceUp" class="menu__link">Баскетбол, волейбол, футбол</a>
                <table class="menu__navigation">
                  <tbody>
                    <tr>
                      <td>
                        <a href="/atributika-bolelschika?sort=priceUp" class="menu__link">
                          <p class="menu__link">Атрибутика болельщика</p>
                          <img src="/files/categories/2472.jpg" alt="Атрибутика болельщика" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/setki-i-koltsa-konusy?sort=priceUp" class="menu__link">
                          <p class="menu__link">Сетки и кольца, конусы</p>
                          <img src="/files/categories/spaldingb.jpg" alt="Сетки и кольца, конусы" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/medboly?sort=priceUp" class="menu__link">
                          <p class="menu__link">Медболы</p>
                          <img src="/files/categories/2355.JPG" alt="Медболы" class="menu__image">
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="/myachi-basketbolnye?sort=priceUp" class="menu__link">
                          <p class="menu__link">Мячи баскетбольные</p>
                          <img src="/files/categories/234234234.gif" alt="Мячи баскетбольные" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/myachi-volejbolnye?sort=priceUp" class="menu__link">
                          <p class="menu__link">Мячи волейбольные</p>
                          <img src="/files/categories/mva200(3).jpg" alt="Мячи волейбольные" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/myachi-gandbolnye?sort=priceUp" class="menu__link">
                          <p class="menu__link">Мячи гандбольные</p>
                          <img src="/files/categories/Мяч ганд. SELECT Solera IHF арт.843408-242.jpg" alt="Мячи гандбольные" class="menu__image">
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="/myachi-futbolnye?sort=priceUp" class="menu__link">
                          <p class="menu__link">Мячи футбольные</p>
                          <img src="/files/categories/Adidas Brazuca.jpg" alt="Мячи футбольные" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/perchatki-vratarskie-i-schitki?sort=priceUp" class="menu__link">
                          <p class="menu__link">Перчатки вратарские и щитки</p>
                          <img src="/files/categories/9.jpg" alt="Перчатки вратарские и щитки" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/sudejskaya-atributika?sort=priceUp" class="menu__link">
                          <p class="menu__link">Судейская атрибутика</p>
                          <img src="/files/categories/svistok1.jpg" alt="Судейская атрибутика" class="menu__image">
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="/nasosy?sort=priceUp" class="menu__link">
                          <p class="menu__link">Насосы</p>
                          <img src="/files/categories/Насос Kepai 2.jpg" alt="Насосы" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/forma-getry-manishki-i-pr?sort=priceUp" class="menu__link">
                          <p class="menu__link">Форма, гетры, манишки и прочее</p>
                          <img src="/files/categories/Манишка тренировочная двухсторонняя.jpg" alt="Форма, гетры, манишки и прочее" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/butsy-i-kedy?sort=priceUp" class="menu__link">
                          <p class="menu__link">Бутсы и кеды</p>
                          <img src="/files/categories/5.jpg" alt="Бутсы и кеды" class="menu__image">
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="/zaschita-volejbol?sort=priceUp" class="menu__link">
                          <p class="menu__link">Защита волейбол</p>
                          <img src="/files/catalog/prv.jpg" alt="Защита волейбол" class="menu__image">
                        </a>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>

              <div class="menu__item">
                <a href="/turizm?sort=priceUp" class="menu__link">Туризм</a>
                <table class="menu__navigation">
                  <tbody>
                    <tr>
                      <td>
                        <a href="/fonari?sort=priceUp" class="menu__link">
                          <p class="menu__link">Фонари</p>
                          <img src="/files/categories/0000311.jpg" alt="Фонари" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/binokli?sort=priceUp" class="menu__link">
                          <p class="menu__link">Бинокли</p>
                          <img src="/files/categories/5555555.jpg" alt="Бинокли" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/palatki-i-spalnye-meshki?sort=priceUp" class="menu__link">
                          <p class="menu__link">Палатки и спальные мешки</p>
                          <img src="/files/categories/6155.3201.jpg" alt="" class="menu__image">
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="/inventar-dlya-turizma-i-otdyha-na-prirode?sort=priceUp" class="menu__link">
                          <p class="menu__link">Инвентарь для туризма и отдыха на природе</p>
                          <img src="/files/categories/Без-имени-1.jpg" alt="" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/kompasy?sort=priceUp" class="menu__link">
                          <p class="menu__link">Компасы</p>
                          <img src="/files/categories/17078-Компас-Т43-3В.jpg" alt="" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/gamaki-kovriki-i-turisticheskaya-mebel?sort=priceUp" class="menu__link">
                          <p class="menu__link">Гамаки, коврики и туристическая мебель</p>
                          <img src="/files/categories/Гамак сетка 2м1м 45мм Белый.jpeg" alt="" class="menu__image">
                        </a>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>

              <div class="menu__item">
                <a href="/edinoborstva?sort=priceUp" class="menu__link">Единоборства</a>
                <table class="menu__navigation">
                  <tbody>
                    <tr>
                      <td>
                        <a href="/meshki-i-maty-boxer?sort=priceUp" class="menu__link">
                          <p class="menu__link">Мешки и маты BOXER</p>
                          <img src="/files/categories/boxer.jpg" alt="Мешки и маты BOXER" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/perchatki-lapy-makivary?sort=priceUp" class="menu__link">
                          <p class="menu__link">Перчатки, лапы, макивары</p>
                          <img src="/files/categories/перчатки Green hill tiger.jpg" alt="Перчатки, лапы, макивары" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/zaschitnoe-snaryazhenie?sort=priceUp" class="menu__link">
                          <p class="menu__link">Защитное снаряжение</p>
                          <img src="/files/categories/Защита груди женская Nylex .jpg" alt="Защитное снаряжение" class="menu__image">
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="/meshki-grushi-germany?sort=priceUp" class="menu__link">
                          <p class="menu__link">Мешки, груши, германы</p>
                          <img src="/files/categories/bobbox.jpg" alt="Мешки, груши, германы" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/obuv-dlya-edinoborstv?sort=priceUp" class="menu__link">
                          <p class="menu__link">Обувь для единоборств</p>
                          <img src="/files/categories/16_4.jpg" alt="Обувь для единоборств" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/kimono?sort=priceUp" class="menu__link">
                          <p class="menu__link">Кимоно</p>
                          <img src="/files/categories/кимоно.jpg" alt="Кимоно" class="menu__image">
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="/odezhda-sambovki-shorty-poyasa?sort=priceUp" class="menu__link">
                          <p class="menu__link">Одежда: самбовки, шорты, пояса</p>
                          <img src="/files/categories/IMG_0068.jpg" alt="Одежда: самбовки, шорты, пояса" class="menu__image">
                        </a>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>

              <div class="menu__item">
                <a href="/dsk-batuty-vse-dlya-detej?sort=priceUp" class="menu__link">ДСК, батуты, всё для детей</a>
                <table class="menu__navigation">
                  <tbody>
                    <tr>
                      <td>
                        <a href="/gorki-i-ulichnye-dsk?sort=priceUp" class="menu__link">
                          <p class="menu__link">Горки и уличные ДСК</p>
                          <img src="" alt="Горки и уличные ДСК" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/myachi-dlya-pryganiya-igr?sort=priceUp" class="menu__link">
                          <p class="menu__link">Мячи для прыгания, игр</p>
                          <img src="/files/categories/717666b42c828.jpg" alt="Мячи для прыгания, игр" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/dsk-i-aksessuary?sort=priceUp" class="menu__link">
                          <p class="menu__link">ДСК и аксессуары</p>
                          <img src="/files/categories/main_product_136843676782363800 (1).png" alt="ДСК и аксессуары" class="menu__image">
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="/batuty?sort=priceUp" class="menu__link">
                          <p class="menu__link">Батуты</p>
                          <img src="/files/categories/Батут Absolute Champion.jpg" alt="Батуты" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/maty-kovriki?sort=priceUp" class="menu__link">
                          <p class="menu__link">Маты, коврики</p>
                          <img src="/files/categories/0000073.jpg" alt="Маты, коврики" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/detskie-trenazhery?sort=priceUp" class="menu__link">
                          <p class="menu__link">Детские тренажеры</p>
                          <img src="/files/categories/Детс. тренажер Велотренажер.jpg" alt="Детские тренажеры" class="menu__image">
                        </a>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>

              <div class="menu__item">
                <a href="/trenazhery?sort=priceUp" class="menu__link">Тренажёры</a>
                <table class="menu__navigation">
                  <tbody>
                    <tr>
                      <td>
                        <a href="/kardio.-steppery?sort=priceUp" class="menu__link">
                          <p class="menu__link">Кардио. Степперы</p>
                          <img src="/files/categories/кардиостеппер.jpg" alt="Кардио. Степперы" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/fitnes-trenazhery?sort=priceUp" class="menu__link">
                          <p class="menu__link">Фитнес тренажеры</p>
                          <img src="/files/categories/Тренажер LEG MASTER Absolute Chempion.jpg" alt="Фитнес тренажеры" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/kardio.-ellipticheskie?sort=priceUp" class="menu__link">
                          <p class="menu__link">Кардио. Эллиптические</p>
                          <img src="/files/categories/bgtovar1357.jpg" alt="Кардио. Эллиптические" class="menu__image">
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="/zapchasti-dlya-trenazherov?sort=priceUp" class="menu__link">
                          <p class="menu__link">Запчасти для тренажеров</p>
                          <img src="/files/categories/запчасти для тренажеров.jpg" alt="Запчасти для тренажеров" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/massazhery-elektricheskie?sort=priceUp" class="menu__link">
                          <p class="menu__link">Массажеры электрические</p>
                          <img src="/files/categories/Массажеры элекстрические.jpg" alt="Массажеры электрические" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/ulichnye-trenazhery?sort=priceUp" class="menu__link">
                          <p class="menu__link">Уличные тренажеры</p>
                          <img src="/files/categories/Уличный тренажер  Брусья .jpeg" alt="Уличные тренажеры" class="menu__image">
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="/silovye?sort=priceUp" class="menu__link">
                          <p class="menu__link">Силовые</p>
                          <img src="/files/categories/m_DH-8171 цена19 990.jpg" alt="Силовые" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/kardio.-velotrenazhery?sort=priceUp" class="menu__link">
                          <p class="menu__link">Кардио. Велотренажеры</p>
                          <img src="/files/categories/bgtovar963.jpg" alt="Кардио. Велотренажеры" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/kardio.-begovye?sort=priceUp" class="menu__link">
                          <p class="menu__link">Кардио. Беговые</p>
                          <img src="/files/categories/bgtovar1354.jpg" alt="Кардио. Беговые" class="menu__image">
                        </a>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>

              <div class="menu__item">
                <a href="/plavanie?sort=priceUp" class="menu__link">Плавание</a>
                <table class="menu__navigation">
                  <tbody>
                    <tr>
                      <td>
                        <a href="/obuv-dlya-bassejna?sort=priceUp" class="menu__link">
                          <p class="menu__link">Обувь для бассейна</p>
                          <img src="/files/categories/400.jpg" alt="Обувь для бассейна" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/shapochki-dlya-plavaniya?sort=priceUp" class="menu__link">
                          <p class="menu__link">Шапочки для плавания</p>
                          <img src="/files/categories/324234234.jpg" alt="Шапочки для плавания" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/atemi?sort=priceUp" class="menu__link">
                          <p class="menu__link">Атеми</p>
                          <img src="/files/categories/трубка.jpg" alt="Атеми" class="menu__image">
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="/odezhda-dlya-plavaniya?sort=priceUp" class="menu__link">
                          <p class="menu__link">Одежда для плавания</p>
                          <img src="/files/categories/8925-8888.jpg" alt="Одежда для плавания" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/ochki-dlya-plavaniya?sort=priceUp" class="menu__link">
                          <p class="menu__link">Очки для плавания</p>
                          <img src="/files/categories/0029-028-Ochki-dlja-plavanija.jpg" alt="Очки для плавания" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/aksessuary-dlya-plavaniya?sort=priceUp" class="menu__link">
                          <p class="menu__link">Аксессуары для плавания</p>
                          <img src="/files/categories/Маска-с-трубкой.jpg" alt="Аксессуары для плавания" class="menu__image">
                        </a>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>

              <div class="menu__item">
                <a href="/gimnastika-tantsy?sort=priceUp" class="menu__link">Гимнастика и танцы</a>
                <table class="menu__navigation">
                  <tbody>
                    <tr>
                      <td>
                        <a href="/odezhda?sort=priceUp" class="menu__link">
                          <p class="menu__link">Одежда</p>
                          <img src="/files/categories/одежда для гимнастики.jpg" alt="Одежда" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/obuv?sort=priceUp" class="menu__link">
                          <p class="menu__link">Инвентарь</p>
                          <img src="/files/categories/Ленты-худгимнастика.jpg" alt="Инвентарь" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/obuv?sort=priceUp" class="menu__link">
                          <p class="menu__link">Обувь</p>
                          <img src="/files/categories/Чешки кожзам черные.jpg" alt="Обувь" class="menu__image">
                        </a>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>

              <div class="menu__item">
                <a href="/polnyj-assortiment?sort=priceUp" class="menu__link">Полный ассортимент</a>
                <table class="menu__navigation">
                  <tbody>
                    <tr>
                      <td>
                        <a href="/kubki-i-medali?sort=priceUp" class="menu__link">
                          <p class="menu__link">Кубки и медали</p>
                          <img src="/files/categories/1821.jpg" alt="Кубки и медали" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/sumki?sort=priceUp" class="menu__link">
                          <p class="menu__link">Сумки</p>
                          <img src="/files/categories/GV5689.jpg" alt="Сумки" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/oborudovanie-dlya-sportzalov?sort=priceUp" class="menu__link">
                          <p class="menu__link">Оборудование для спортзалов</p>
                          <img src="/files/categories/гиря.png" alt="Оборудование для спортзалов" class="menu__image">
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="/suvenirnaya-produktsiya?sort=priceUp" class="menu__link">
                          <p class="menu__link">Сувенирная продукция</p>
                          <img src="/files/categories/Брелок перчатки Everlast.jpg" alt="Сувенирная продукция" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/sportivnaya-odezhda?sort=priceUp" class="menu__link">
                          <p class="menu__link">Спортивная одежда</p>
                          <img src="/files/categories/419891-008-A.jpg" alt="Спортивная одежда" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/prochee?sort=priceUp" class="menu__link">
                          <p class="menu__link">Прочее</p>
                          <img src="/files/categories/Большой балончик 10шт в коробке.jpg" alt="Прочее" class="menu__image">
                        </a>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>

              <div class="menu__item">
                <a href="/totem?sort=priceUp" class="menu__link">Велосипеды</a>
                <table class="menu__navigation">
                  <tbody>
                    <tr>
                      <td>
                        <a href="/cube?sort=priceUp" class="menu__link">
                          <p class="menu__link">Cube</p>
                          <img src="/files/categories/Горный велосипед Cube Aim SL 27.5 (2015).jpg" alt="Cube" class="menu__image">
                        </a>
                      </td>
                     
                    </tr>
                    <tr>
                      <td>
                        <a href="/detskie-3_h-kolesnye?sort=priceUp" class="menu__link">
                          <p class="menu__link">Детские 3-х колесные</p>
                          <img src="/files/categories/Велосипед 3 х колесный JW7OB оранжевый.png" alt="Детские 3-х колесные" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/detskie-2_h-i-4_h-kolesnye?sort=priceUp" class="menu__link">
                          <p class="menu__link">Детские 2-х и 4-х колесные</p>
                          <img src="/files/categories/велосв.jpg" alt="Детские 2-х и 4-х колесные" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/forwardvelo?sort=priceUp" class="menu__link">
                          <p class="menu__link">Forward</p>
                          <img src="/files/categories/2048x1152_2016_26_APACHE_2_green.jpg" alt="Forward" class="menu__image">
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="/maxxpro?sort=priceUp" class="menu__link">
                          <p class="menu__link">Maxxpro</p>
                          <img src="/files/categories/maxxpro.png" alt="Maxxpro" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/merida?sort=priceUp" class="menu__link">
                          <p class="menu__link">Merida</p>
                          <img src="/files/categories/Велосипед Merida BIG Seven 70 (2015).jpg" alt="Merida" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/totem?sort=priceUp" class="menu__link">
                          <p class="menu__link">Totem</p>
                          <img src="/files/catalog/totem.jpg" alt="Аксессуары для велосипедов" class="menu__image">
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="/krostek?sort=priceUp" class="menu__link">
                          <p class="menu__link">Krostek</p>
                          <img src="/files/catalog/krostek.png" alt="Maxxpro" class="menu__image">
                        </a>
                      </td>

                      <td>
                        <a href="/aksessuary-dlya-velosipedov?sort=priceUp" class="menu__link">
                          <p class="menu__link">Аксессуары для велосипедов</p>
                          <img src="/files/categories/Pokri.jpg" alt="Аксессуары для велосипедов" class="menu__image">
                        </a>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>

             <!-- <div class="menu__item menu__item--sportfood">
                <a href="/sportivnoe-pitanie?sort=priceUp" class="menu__link">Спортивное питание</a>
              </div>-->

              <div class="menu__item">
                <a href="/fitnes-i-atletika?sort=priceUp" class="menu__link">Фитнес и атлетика</a>
                <table class="menu__navigation">
                  <tbody>
                    <tr>
                      <td>
                        <a href="/predmety-dlya-pohudeniya-i-zdorovya?sort=priceUp" class="menu__link">
                          <p class="menu__link">Предметы для похудения и здоровья</p>
                          <img src="/files/categories/Предметы-для-похудения.jpg" alt="Предметы для похудения и здоровья" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/bandazhi-supporty-nakolenniki-povyazki?sort=priceUp" class="menu__link">
                          <p class="menu__link">Бандажи, суппорты, наколенники, повязки</p>
                          <img src="/files/categories/наколенники.jpg" alt="Бандажи, суппорты, наколенники, повязки" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/perchatki-tyazhelaya-atletika-velo-dlya-fitnesa?sort=priceUp" class="menu__link">
                          <p class="menu__link">Перчатки тяжелая атлетика, вело, для фитнеса</p>
                          <img src="/files/categories/велоперчатки.jpg" alt="Перчатки тяжелая атлетика, вело, для фитнеса" class="menu__image">
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="/bodibary_step_platformy?sort=priceUp" class="menu__link">
                          <p class="menu__link">Бодибары, степ-платформы</p>
                          <img src="/files/categories/Степ платформы.jpg" alt="Бодибары, степ-платформы" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/fitboly?sort=priceUp" class="menu__link">
                          <p class="menu__link">Фитболы</p>
                          <img src="/files/categories/55684715.jpg" alt="Фитболы" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/legkaya-atletika?sort=priceUp" class="menu__link">
                          <p class="menu__link">Лёгкая атлетика</p>
                          <img src="/files/categories/шиповки.jpg" alt="Лёгкая атлетика" class="menu__image">
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="/obruchi-i-skakalki?sort=priceUp" class="menu__link">
                          <p class="menu__link">Обручи и скакалки</p>
                          <img src="/files/categories/ПО-11-12-13.JPG" alt="Обручи и скакалки" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/turniki-i-upory-dlya-otzhimanij?sort=priceUp" class="menu__link">
                          <p class="menu__link">Турники и упоры для отжиманий</p>
                          <img src="/files/categories/Турник-настенный-с-широким-хватом-ТН-1.jpg" alt="Турники и упоры для отжиманий" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/espandery?sort=priceUp" class="menu__link">
                          <p class="menu__link">Эспандеры</p>
                          <img src="/files/categories/категория.jpg" alt="Эспандеры" class="menu__image">
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="/utyazheliteli?sort=priceUp" class="menu__link">
                          <p class="menu__link">Утяжелители</p>
                          <img src="/files/categories/утяжелители.jpg" alt="Утяжелители" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/kovriki_karimaty_maty?sort=priceUp" class="menu__link">
                          <p class="menu__link">Коврики, кариматы и маты для фитнеса</p>
                          <img src="/files/categories/15523.jpg" alt="Коврики, кариматы и маты для фитнеса" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/massazhery-mehanicheskie?sort=priceUp" class="menu__link">
                          <p class="menu__link">Массажёры механические</p>
                          <img src="/files/categories/878325-1.jpg" alt="Массажёры механические" class="menu__image">
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="/diski-tvistery-i-roliki-dlya-pressa?sort=priceUp" class="menu__link">
                          <p class="menu__link">Диски-твистеры и ролики для пресса</p>
                          <img src="/files/categories/Ролик для пресса двойн.Feco EG9639.jpg" alt="Диски-твистеры и ролики для пресса" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/atletika?sort=priceUp" class="menu__link">
                          <p class="menu__link">Атлетика</p>
                          <img src="/files/categories/Диск обрезин диам 26.jpg" alt="Атлетика" class="menu__image">
                        </a>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>

              <div class="menu__item">
                <a href="/igry?sort=priceUp" class="menu__link">Игры</a>
                <table class="menu__navigation">
                  <tbody>
                    <tr>
                      <td>
                        <a href="/aksessuary-dlya-nastolnogo-tennisa?sort=priceUp" class="menu__link">
                          <p class="menu__link">Аксессуары для настольного тенниса</p>
                          <img src="/files/categories/Ракетка н.т TORRES Control 9 для начинающих.jpg" alt="Аксессуары для настольного тенниса" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/stoly-tennisnye?sort=priceUp" class="menu__link">
                          <p class="menu__link">Столы теннисные</p>
                          <img src="/files/categories/Стол теннисный влагостойкий WIPS Outdoor Composite 61070.jpg" alt="Столы теннисные" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/aerohokkei-i-nastolnye-igry?sort=priceUp" class="menu__link">
                          <p class="menu__link">Аэрохоккеи и настольные игры</p>
                          <img src="/files/categories/Аэрохоккей электрический G ahe 100 51.jpg" alt="Аэрохоккеи и настольные игры" class="menu__image">
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="/nastolnyj-tennis?sort=priceUp" class="menu__link">
                          <p class="menu__link">Настольный теннис</p>
                          <img src="/files/categories/Ракетка н.т Stiga + чехол в наборе.jpg" alt="Настольный теннис" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/darts?sort=priceUp" class="menu__link">
                          <p class="menu__link">Дартс</p>
                          <img src="/files/categories/realistic-dartboard-vector-illustration_91-2147487362.jpg" alt="Дартс" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/bilyard?sort=priceUp" class="menu__link">
                          <p class="menu__link">Бильярд</p>
                          <img src="/files/categories/0_f9f93_8f1425d9_orig.jpg" alt="Бильярд" class="menu__image">
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="/badminton-bolshoj-tennis?sort=priceUp" class="menu__link">
                          <p class="menu__link">Бадминтон Большой теннис</p>
                          <img src="/files/categories/Набор бадминтона дерев.jpg" alt="Бадминтон Большой теннис" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/bejsbol?sort=priceUp" class="menu__link">
                          <p class="menu__link">Бейсбол</p>
                          <img src="/files/categories/ball.jpg" alt="Бейсбол" class="menu__image">
                        </a>
                      </td>
                      <td>
                        <a href="/klassicheskie-nastolnye?sort=priceUp" class="menu__link">
                          <p class="menu__link">Классические настольные</p>
                          <img src="/files/categories/Шахматы Император ZL05T528.jpg" alt="Классические настольные" class="menu__image">
                        </a>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <a href="/aktivnye-igry?sort=priceUp" class="menu__link">
                          <p class="menu__link">Активные игры</p>
                          <img src="/files/categories/97a455a2-326e-11e3-a0a0-001e8ca06dd0_bbaf2fe7-3286-11e3-a0a0-001e8ca06dd0-500x500.gif" alt="Активные игры" class="menu__image">
                        </a>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <!-- End displaying menu items -->
            </nav>
          </div>
          <!-- End PC menu -->
          
          <div class="search-ico"></div>
          
          <a href="/totem?sort=priceUp" class="header__item">Велосипеды</a>
          <a href="/roliki?sort=priceUp" class="header__item">Ролики</a>
          <a href="/samokaty?sort=priceUp" class="header__item">Самокаты</a>
          <a href="/skejty?sort=priceUp" class="header__item">Скейты</a>
          <a href="/giroskutery?sort=priceUp" class="header__item">Гироскутеры</a>
          <a href="/bassejny?sort=priceUp" class="header__item">Бассейны</a>
          <a href="/plavanie?sort=priceUp" class="header__item">Плавание</a>
          <a href="/igry?sort=priceUp" class="header__item">Игры</a>
          <a href="/stock?sort=priceUp" class="header__item header__item--shares">Акции</a>

        </div>
      </div>

      <div class="header__overlay"></div>

      <!-- Desctop menu -->
      <nav class="m-menu">
        <img src="/design/{$settings->theme}/images/ico/close_mobile_menu.svg" alt="close" class="m-menu__close">
        <!-- Displaying desctop menu items -->
        <div class="m-menu__item">
          <div class="m-menu__caption">
            <a href="/bassejny-i-aksessuary?sort=priceUp" class="m-menu__link">Бассейны и аксессуары</a> <img src="/design/{$settings->theme}/images/ico/arrow_menu.svg" alt="arrow" class="m-menu__arrow">
          </div>
          <ul class="m-menu__navigation">
            <li class="m-menu__item">
              <a href="/akssesuary-dlya-plyazha?sort=priceUp" class="m-menu__link">Акссесуары для пляжа</a>
            </li>
            <li class="m-menu__item">
              <a href="/bassejny?sort=priceUp" class="m-menu__link">Бассейны</a>
            </li>
            <li class="m-menu__item">
              <a href="/akssesuary-dlya-bassejnov?sort=priceUp" class="m-menu__link">Акссесуары для бассейнов</a>
            </li>
            <li class="m-menu__item">
              <a href="/himiya-dlya-bassejnov?sort=priceUp" class="m-menu__link">Химия для бассейнов</a>
            </li>
            <li class="m-menu__item">
              <a href="/krovati-matrasy-kresla?sort=priceUp" class="m-menu__link">Кровати, матрасы, кресла</a>
            </li>
            <li class="m-menu__item">
              <a href="/nasosy-intex-bestway?sort=priceUp" class="m-menu__link">Насосы INTEX, BestWay</a>
            </li>
          </ul>
        </div>

        <div class="m-menu__item">
          <div class="m-menu__caption">
            <a href="/roliki-skejty-samokaty-giroskutery?sort=priceUp" class="m-menu__link">Ролики, скейты, самокаты</a> <img src="/design/{$settings->theme}/images/ico/arrow_menu.svg" alt="arrow" class="m-menu__arrow">
          </div>
          <ul class="m-menu__navigation">
            <li class="m-menu__item">
              <a href="/giroskutery?sort=priceUp" class="m-menu__link">Гироскутеры</a>
            </li>
            <li class="m-menu__item">
              <a href="/zaschita-i-aksessuary?sort=priceUp" class="m-menu__link">Защита и аксессуары</a>
            </li>
            <li class="m-menu__item">
              <a href="/roliki?sort=priceUp" class="m-menu__link">Ролики</a>
            </li>
            <li class="m-menu__item">
              <a href="/samokaty?sort=priceUp" class="m-menu__link">Самокаты</a>
            </li>
            <li class="m-menu__item">
              <a href="/skejty?sort=priceUp" class="m-menu__link">Скейты</a>
            </li>
          </ul>
        </div>

        <div class="m-menu__item">
          <div class="m-menu__caption">
            <a href="/zimnie-tovary?sort=priceUp" class="m-menu__link">Зимние товары</a> <img src="/design/{$settings->theme}/images/ico/arrow_menu.svg" alt="arrow" class="m-menu__arrow">
          </div>
          <ul class="m-menu__navigation">
            <li class="m-menu__item">
              <a href="/hokkej?sort=priceUp" class="m-menu__link">Хоккей</a>
            </li>
            <li class="m-menu__item">
              <a href="/elki-i-bengalskie-ogni?sort=priceUp" class="m-menu__link">Ёлки и бенгальские огни</a>
            </li>
            <li class="m-menu__item">
              <a href="/termobele?sort=priceUp" class="m-menu__link">Термобелье</a>
            </li>
            <li class="m-menu__item">
              <a href="/zimnij-inventar?sort=priceUp" class="m-menu__link">Зимний инвентарь</a>
            </li>
          </ul>
        </div>

        <div class="m-menu__item">
          <div class="m-menu__caption">
            <a href="/basketbol-volejbol-futbol.?sort=priceUp" class="m-menu__link">Баскетбол, волейбол, футбол</a> <img src="/design/{$settings->theme}/images/ico/arrow_menu.svg" alt="arrow" class="m-menu__arrow">
          </div>
          <ul class="m-menu__navigation">
            <li class="m-menu__item">
              <a href="/atributika-bolelschika?sort=priceUp" class="m-menu__link">Атрибутика болельщика</a>
            </li>
            <li class="m-menu__item">
              <a href="/setki-i-koltsa-konusy?sort=priceUp" class="m-menu__link">Сетки и кольца, конусы</a>
            </li>
            <li class="m-menu__item">
              <a href="/medboly?sort=priceUp" class="m-menu__link">Медболы</a>
            </li>
            <li class="m-menu__item">
              <a href="/myachi-basketbolnye?sort=priceUp" class="m-menu__link">Мячи баскетбольные</a>
            </li>
            <li class="m-menu__item">
              <a href="/myachi-volejbolnye?sort=priceUp" class="m-menu__link">Мячи волейбольные</a>
            </li>
            <li class="m-menu__item">
              <a href="/myachi-gandbolnye?sort=priceUp" class="m-menu__link">Мячи гандбольные</a>
            </li>
            <li class="m-menu__item">
              <a href="/myachi-futbolnye?sort=priceUp" class="m-menu__link">Мячи футбольные</a>
            </li>
            <li class="m-menu__item">
              <a href="/perchatki-vratarskie-i-schitki?sort=priceUp" class="m-menu__link">Перчатки вратарские и щитки</a>
            </li>
            <li class="m-menu__item">
              <a href="/sudejskaya-atributika?sort=priceUp" class="m-menu__link">Судейская атрибутика</a>
            </li>
            <li class="m-menu__item">
              <a href="/nasosy?sort=priceUp" class="m-menu__link">Насосы</a>
            </li>
            <li class="m-menu__item">
              <a href="/forma-getry-manishki-i-pr?sort=priceUp" class="m-menu__link">Форма, гетры, манишки и прочее</a>
            </li>
            <li class="m-menu__item">
              <a href="/butsy-i-kedy?sort=priceUp" class="m-menu__link">Бутсы и кеды</a>
            </li>
            <li class="m-menu__item">
              <a href="/zaschita-volejbol?sort=priceUp" class="m-menu__link">Защита волейбол</a>
            </li>
          </ul>
        </div>

        <div class="m-menu__item">
          <div class="m-menu__caption">
            <a href="/turizm?sort=priceUp" class="m-menu__link">Туризм</a> <img src="/design/{$settings->theme}/images/ico/arrow_menu.svg" alt="arrow" class="m-menu__arrow">
          </div>
          <ul class="m-menu__navigation">
            <li class="m-menu__item">
              <a href="/fonari?sort=priceUp" class="m-menu__link">Фонари</a>
            </li>
            <li class="m-menu__item">
              <a href="/binokli?sort=priceUp" class="m-menu__link">Бинокли</a>
            </li>
            <li class="m-menu__item">
              <a href="/palatki-i-spalnye-meshki?sort=priceUp" class="m-menu__link">Палатки и спальные мешки</a>
            </li>
            <li class="m-menu__item">
              <a href="/inventar-dlya-turizma-i-oliyha-na-prirode?sort=priceUp" class="m-menu__link">Инвентарь для туризма и отдыха на природе</a>
            </li>
            <li class="m-menu__item">
              <a href="/kompasy?sort=priceUp" class="m-menu__link">Компасы</a>
            </li>
            <li class="m-menu__item">
              <a href="/gamaki-kovriki-i-turisticheskaya-mebel?sort=priceUp" class="m-menu__link">Гамаки, коврики и туристическая мебель</a>
            </li>
          </ul>
        </div>

        <div class="m-menu__item">
          <div class="m-menu__caption">
            <a href="/edinoborstva?sort=priceUp" class="m-menu__link">Единоборства</a> <img src="/design/{$settings->theme}/images/ico/arrow_menu.svg" alt="arrow" class="m-menu__arrow">
          </div>
          <ul class="m-menu__navigation">
            <li class="m-menu__item">
              <a href="/meshki-i-maty-boxer?sort=priceUp" class="m-menu__link">Мешки и маты BOXER</a>
            </li>
            <li class="m-menu__item">
              <a href="/perchatki-lapy-makivary?sort=priceUp" class="m-menu__link">Перчатки, лапы, макивары</a>
            </li>
            <li class="m-menu__item">
              <a href="/zaschitnoe-snaryazhenie?sort=priceUp" class="m-menu__link">Защитное снаряжение</a>
            </li>
            <li class="m-menu__item">
              <a href="/meshki-grushi-germany?sort=priceUp" class="m-menu__link">Мешки, груши, германы</a>
            </li>
            <li class="m-menu__item">
              <a href="/obuv-dlya-edinoborstv?sort=priceUp" class="m-menu__link">Обувь для единоборств</a>
            </li>
            <li class="m-menu__item">
              <a href="/kimono?sort=priceUp" class="m-menu__link">Кимоно</a>
            </li>
            <li class="m-menu__item">
              <a href="/odezhda-sambovki-shorty-poyasa?sort=priceUp" class="m-menu__link">Одежда: самбовки, шорты, пояса</a>
            </li>
          </ul>
        </div>

        <div class="m-menu__item">
          <div class="m-menu__caption">
            <a href="/dsk-batuty-vse-dlya-detej?sort=priceUp" class="m-menu__link">ДСК, батуты, всё для детей</a> <img src="/design/{$settings->theme}/images/ico/arrow_menu.svg" alt="arrow" class="m-menu__arrow">
          </div>
          <ul class="m-menu__navigation">
            <li class="m-menu__item">
              <a href="/gorki-i-ulichnye-dsk?sort=priceUp" class="m-menu__link">Горки и уличные ДСК</a>
            </li>
            <li class="m-menu__item">
              <a href="/myachi-dlya-pryganiya-igr?sort=priceUp" class="m-menu__link">Мячи для прыгания, игр</a>
            </li>
            <li class="m-menu__item">
              <a href="/dsk-i-aksessuary?sort=priceUp" class="m-menu__link">ДСК и аксессуары</a>
            </li>
            <li class="m-menu__item">
              <a href="/batuty?sort=priceUp" class="m-menu__link">Батуты</a>
            </li>
            <li class="m-menu__item">
              <a href="/maty-kovriki?sort=priceUp" class="m-menu__link">Маты, коврики</a>
            </li>
            <li class="m-menu__item">
              <a href="/detskie-trenazhery?sort=priceUp" class="m-menu__link">Детские тренажеры</a>
            </li>
          </ul>
        </div>

        <div class="m-menu__item">
          <div class="m-menu__caption">
            <a href="/trenazhery?sort=priceUp" class="m-menu__link">Тренажёры</a> <img src="/design/{$settings->theme}/images/ico/arrow_menu.svg" alt="arrow" class="m-menu__arrow">
          </div>
          <ul class="m-menu__navigation">
            <li class="m-menu__item">
              <a href="/kardio.-steppery?sort=priceUp" class="m-menu__link">Кардио. Степперы</a>
            </li>
            <li class="m-menu__item">
              <a href="/fitnes-trenazhery?sort=priceUp" class="m-menu__link">Фитнес тренажеры</a>
            </li>
            <li class="m-menu__item">
              <a href="/kardio.-ellipticheskie?sort=priceUp" class="m-menu__link">Кардио. Эллиптические</a>
            </li>
            <li class="m-menu__item">
              <a href="/zapchasti-dlya-trenazherov?sort=priceUp" class="m-menu__link">Запчасти для тренажеров</a>
            </li>
            <li class="m-menu__item">
              <a href="/massazhery-elektricheskie?sort=priceUp" class="m-menu__link">Массажеры электрические</a>
            </li>
            <li class="m-menu__item">
              <a href="/ulichnye-trenazhery?sort=priceUp" class="m-menu__link">Уличные тренажеры</a>
            </li>
            <li class="m-menu__item">
              <a href="/silovye?sort=priceUp" class="m-menu__link">Силовые</a>
            </li>
            <li class="m-menu__item">
              <a href="/kardio.-velotrenazhery?sort=priceUp" class="m-menu__link">Кардио. Велотренажеры</a>
            </li>
            <li class="m-menu__item">
              <a href="/kardio.-begovye?sort=priceUp" class="m-menu__link">Кардио. Беговые</a>
            </li>
          </ul>
        </div>

        <div class="m-menu__item">
          <div class="m-menu__caption">
            <a href="/plavanie?sort=priceUp" class="m-menu__link">Плавание</a> <img src="/design/{$settings->theme}/images/ico/arrow_menu.svg" alt="arrow" class="m-menu__arrow">
          </div>
          <ul class="m-menu__navigation">
            <li class="m-menu__item">
              <a href="/obuv-dlya-bassejna?sort=priceUp" class="m-menu__link">Обувь для бассейна</a>
            </li>
            <li class="m-menu__item">
              <a href="/shapochki-dlya-plavaniya?sort=priceUp" class="m-menu__link">Шапочки для плавания</a>
            </li>
            <li class="m-menu__item">
              <a href="/atemi?sort=priceUp" class="m-menu__link">Атеми</a>
            </li>
            <li class="m-menu__item">
              <a href="/odezhda-dlya-plavaniya?sort=priceUp" class="m-menu__link">Одежда для плавания</a>
            </li>
            <li class="m-menu__item">
              <a href="/ochki-dlya-plavaniya?sort=priceUp" class="m-menu__link">Очки для плавания</a>
            </li>
            <li class="m-menu__item">
              <a href="/aksessuary-dlya-plavaniya?sort=priceUp" class="m-menu__link">Аксессуары для плавания</a>
            </li>
          </ul>
        </div>

        <div class="m-menu__item">
          <div class="m-menu__caption">
            <a href="/gimnastika-tantsy?sort=priceUp" class="m-menu__link">Гимнастика и танцы</a> <img src="/design/{$settings->theme}/images/ico/arrow_menu.svg" alt="arrow" class="m-menu__arrow">
          </div>
          <ul class="m-menu__navigation">
            <li class="m-menu__item">
              <a href="/odezhda?sort=priceUp" class="m-menu__link">Одежда</a>
            </li>
            <li class="m-menu__item">
              <a href="/obuv?sort=priceUp" class="m-menu__link">Инвентарь</a>
            </li>
            <li class="m-menu__item">
              <a href="/obuv?sort=priceUp" class="m-menu__link">Обувь</a>
            </li>
          </ul>
        </div>

        <div class="m-menu__item">
          <div class="m-menu__caption">
            <a href="/polnyj-assortiment?sort=priceUp" class="m-menu__link">Полный ассортимент</a> <img src="/design/{$settings->theme}/images/ico/arrow_menu.svg" alt="arrow" class="m-menu__arrow">
          </div>
          <ul class="m-menu__navigation">
            <li class="m-menu__item">
              <a href="/kubki-i-medali?sort=priceUp" class="m-menu__link">Кубки и медали</a>
            </li>
            <li class="m-menu__item">
              <a href="/sumki?sort=priceUp" class="m-menu__link">Сумки</a>
            </li>
            <li class="m-menu__item">
              <a href="/oborudovanie-dlya-sportzalov?sort=priceUp" class="m-menu__link">Оборудование для спортзалов</a>
            </li>
            <li class="m-menu__item">
              <a href="/suvenirnaya-produktsiya?sort=priceUp" class="m-menu__link">Сувенирная продукция</a>
            </li>
            <li class="m-menu__item">
              <a href="/sportivnaya-odezhda?sort=priceUp" class="m-menu__link">Спортивная одежда</a>
            </li>
            <li class="m-menu__item">
              <a href="/prochee?sort=priceUp" class="m-menu__link">Прочее</a>
            </li>
          </ul>
        </div>

        <div class="m-menu__item">
          <div class="m-menu__caption">
            <a href="/totem?sort=priceUp" class="m-menu__link">Велосипеды</a> <img src="/design/{$settings->theme}/images/ico/arrow_menu.svg" alt="arrow" class="m-menu__arrow">
          </div>
          <ul class="m-menu__navigation">
            <li class="m-menu__item">
              <a href="/cube?sort=priceUp" class="m-menu__link">Cube</a>
            </li>
            
            <li class="m-menu__item">
              <a href="/detskie-3_h-kolesnye?sort=priceUp" class="m-menu__link">Детские 3-х колесные</a>
            </li>
            <li class="m-menu__item">
              <a href="/detskie-2_h-i-4_h-kolesnye?sort=priceUp" class="m-menu__link">Детские 2-х и 4-х колесные</a>
            </li>
            <li class="m-menu__item">
              <a href="/forwardvelo?sort=priceUp" class="m-menu__link">Forward</a>
            </li>
            <li class="m-menu__item">
              <a href="/maxxpro?sort=priceUp" class="m-menu__link">Maxxpro</a>
            </li>
            <li class="m-menu__item">
              <a href="/merida?sort=priceUp" class="m-menu__link">Merida</a>
            </li>
            <li class="m-menu__item">
              <a href="/totem?sort=priceUp" class="m-menu__link">Totem</a>
            </li>
            <li class="m-menu__item">
              <a href="/krostek?sort=priceUp" class="m-menu__link">Krostek</a>
            </li>
            <li class="m-menu__item">
              <a href="/aksessuary-dlya-velosipedov?sort=priceUp" class="m-menu__link">Аксессуары для велосипедов</a>
            </li>
          </ul>
        </div>

       <!-- <div class="m-menu__item m-menu__item--sportfood">
          <a href="/sportivnoe-pitanie?sort=priceUp" class="m-menu__link">Спортивное питание</a>
        </div>-->

        <div class="m-menu__item">
          <div class="m-menu__caption">
            <a href="/fitnes-i-atletika?sort=priceUp" class="m-menu__link">Фитнес и атлетика</a> <img src="/design/{$settings->theme}/images/ico/arrow_menu.svg" alt="arrow" class="m-menu__arrow">
          </div>
          <ul class="m-menu__navigation">
            <li class="m-menu__item">
              <a href="/predmety-dlya-pohudeniya-i-zdorovya?sort=priceUp" class="m-menu__link">Предметы для похудения и здоровья</a>
            </li>
            <li class="m-menu__item">
              <a href="/bandazhi-supporty-nakolenniki-povyazki?sort=priceUp" class="m-menu__link">Бандажи, суппорты, наколенники, повязки</a>
            </li>
            <li class="m-menu__item">
              <a href="/perchatki-tyazhelaya-atletika-velo-dlya-fitnesa?sort=priceUp" class="m-menu__link">Перчатки тяжелая атлетика, вело, для фитнеса</a>
            </li>
            <li class="m-menu__item">
              <a href="/bodibary_step_platformy?sort=priceUp" class="m-menu__link">Бодибары, степ-платформы</a>
            </li>
            <li class="m-menu__item">
              <a href="/fitboly?sort=priceUp" class="m-menu__link">Фитболы</a>
            </li>
            <li class="m-menu__item">
              <a href="/legkaya-atletika?sort=priceUp" class="m-menu__link">Лёгкая атлетика</a>
            </li>
            <li class="m-menu__item">
              <a href="/obruchi-i-skakalki?sort=priceUp" class="m-menu__link">Обручи и скакалки</a>
            </li>
            <li class="m-menu__item">
              <a href="/turniki-i-upory-dlya-otzhimanij?sort=priceUp" class="m-menu__link">Турники и упоры для отжиманий</a>
            </li>
            <li class="m-menu__item">
              <a href="/espandery?sort=priceUp" class="m-menu__link">Эспандеры</a>
            </li>
            <li class="m-menu__item">
              <a href="/utyazheliteli?sort=priceUp" class="m-menu__link">Утяжелители</a>
            </li>
            <li class="m-menu__item">
              <a href="/kovriki_karimaty_maty?sort=priceUp" class="m-menu__link">Коврики, кариматы и маты для фитнеса</a>
            </li>
            <li class="m-menu__item">
              <a href="/massazhery-mehanicheskie?sort=priceUp" class="m-menu__link">Массажёры механические</a>
            </li>
            <li class="m-menu__item">
              <a href="/diski-tvistery-i-roliki-dlya-pressa?sort=priceUp" class="m-menu__link">Диски-твистеры и ролики для пресса</a>
            </li>
            <li class="m-menu__item">
              <a href="/atletika?sort=priceUp" class="m-menu__link">Атлетика</a>
            </li>
          </ul>
        </div>

        <div class="m-menu__item">
          <div class="m-menu__caption">
            <a href="/igry?sort=priceUp" class="m-menu__link">Игры</a> <img src="/design/{$settings->theme}/images/ico/arrow_menu.svg" alt="arrow" class="m-menu__arrow">
          </div>
          <ul class="m-menu__navigation">
            <li class="m-menu__item">
              <a href="/aksessuary-dlya-nastolnogo-tennisa?sort=priceUp" class="m-menu__link">Аксессуары для настольного тенниса</a>
            </li>
            <li class="m-menu__item">
              <a href="/stoly-tennisnye?sort=priceUp" class="m-menu__link">Столы теннисные</a>
            </li>
            <li class="m-menu__item">
              <a href="/aerohokkei-i-nastolnye-igry?sort=priceUp" class="m-menu__link">Аэрохоккеи и настольные игры</a>
            </li>
            <li class="m-menu__item">
              <a href="/nastolnyj-tennis?sort=priceUp" class="m-menu__link">Настольный теннис</a>
            </li>
            <li class="m-menu__item">
              <a href="/darts?sort=priceUp" class="m-menu__link">Дартс</a>
            </li>
            <li class="m-menu__item">
              <a href="/bilyard?sort=priceUp" class="m-menu__link">Бильярд</a>
            </li>
            <li class="m-menu__item">
              <a href="/badminton-bolshoj-tennis?sort=priceUp" class="m-menu__link">Бадминтон, Большой теннис</a>
            </li>
            <li class="m-menu__item">
              <a href="/bejsbol?sort=priceUp" class="m-menu__link">Бейсбол</a>
            </li>
            <li class="m-menu__item">
              <a href="/klassicheskie-nastolnye?sort=priceUp" class="m-menu__link">Классические настольные</a>
            </li>
            <li class="m-menu__item">
              <a href="/aktivnye-igry?sort=priceUp" class="m-menu__link">Активные игры</a>
            </li>
          </ul>
        </div>
        <!-- End displaying desctop menu items -->    
      </nav>
      <!-- End desctop menu -->
    </header>