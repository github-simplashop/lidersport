<!DOCTYPE html>
{*
	Общий вид страницы
	Этот шаблон отвечает за общий вид страниц без центрального блока.
*}
<html>
<head>
	<title>{$meta_title|escape}</title>
        <meta name='yandex-verification' content='73e703aa7eb82fe0' />
	
	{* Метатеги *}
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="description" content="{$meta_description|escape}" />
	<meta name="keywords"    content="{$meta_keywords|escape}" />
	<meta name="viewport" content="width = 950">
	<link href="/favicon.ico" rel="icon" type="image/x-icon"/>
	
	{* JQuery *}
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"  type="text/javascript"></script>
	<script type="text/javascript" src="/js/carouFredSel-6.2.1/jquery.carouFredSel-6.2.1-packed.js"></script>
	
	{* Аяксовая корзина *}
	<script src="/design/{$settings->theme}/js/jquery-ui.min.js"></script>
	<script src="/design/{$settings->theme}/js/ajax_cart.js"></script>
	<script src="/design/{$settings->theme}/js/jquery.rater.js"></script>
	
	<script type="text/javascript" src="/design/{$settings->theme}/js/javascript.js"></script>
	<script type="text/javascript" src="/design/{$settings->theme}/js/my_skript.js"></script>
	<script type="text/javascript" src="/js/bootstap/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/design/{$settings->theme}/js/script.js"></script>
  <script type="text/javascript" src="/design/{$settings->theme}/slick/slick.min.js"></script>
	<link rel="stylesheet" href="/js/bootstap/css/modal.css" type="text/css" media="screen" />
	<link rel="stylesheet" href="/js/bootstap/css/but_icon.css" type="text/css" media="screen" />
	<link rel="stylesheet" href="/js/bootstap/css/form.css" type="text/css" media="screen" />
	
	{* CSS *}

  <link rel="stylesheet" type="text/css" href="/design/{$settings->theme}/slick/slick.css"/>
  <link rel="stylesheet" type="text/css" href="/design/{$settings->theme}/slick/slick-theme.css"/>
	<link rel="stylesheet" type="text/css" href="/design/{$settings->theme}/css/style.css" />
	<![if IE]><link rel="stylesheet" type="text/css" href="/design/{$settings->theme}/css/style-for-ie.css" /><![endif]>
	
	{* Увеличитель картинок *}
	<script type="text/javascript" src="/design/{$settings->theme}/js/fancybox2/jquery.fancybox.pack.js"></script>
	<link rel="stylesheet" href="/design/{$settings->theme}/js/fancybox2/jquery.fancybox.css" type="text/css" media="screen" />
	
        
       
        
        
        
	<script src="/design/{$settings->theme}/js/jquery.cookie.js" type="text/javascript"></script>	
	 <script type="text/javascript">
$(document).ready(function(){
  $(".buyButton").on("click",function(){
  	$(this).closest('form').submit();});
});
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
 $(document).on("click",".rasrochkaShow",function(e){
  e.preventDefault();
                $.ajax({
                        url: "/price/rasrochka.php",
                        type: "GET",
                        data:{},
                        success: function(data){
                            $('#rasrochkaInside').html(data);
                        }
                    });
$("#wrap, #rasrochka").show();
  return false;
});
 $( document ).on('click',"#wrap, .closeRasrochka", function() {
          $("#wrap").hide();
          $("#rasrochka").hide();
          $(".podobrat_razm").hide();
         });
$(document).on("click",".data",function(e){
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
$( document ).on('click',"#wrap, .closeWindow", function() {
          $("#wrap").hide();
          $("#window").hide();
          $("#windowInside").html(" ");
         });
$(document).on("click",".dataInProduct",function(e){
  addColor();
  addRazmer();
  if (colorValue == false || razmerValue == false){
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
}
else
{
  $("#colors").closest('form').submit();
}

});
$( document ).on('click',"#wrap, .closeWindow", function() {
          $("#wrap").hide();
          $("#window").hide();
          $("#windowInside").html(" ");
         });
  </script> 
	

    
    {* Автозаполнитель поиска *}
	{literal}
	<script src="/js/autocomplete/jquery.autocomplete-min1.js" type="text/javascript"></script>
	<style>
		.autocomplete-suggestions{
		background-color: #ffffff; width: 100px; overflow: hidden;
		border: 1px solid #e0e0e0;
		padding: 5px;
		overflow-y: auto;
		}
		.autocomplete-suggestions {cursor: default;}
		.autocomplete-suggestion {cursor: pointer;}
		.autocomplete-suggestions .selected { background:#F0F0F0; }
		.autocomplete-suggestions div { padding:2px 5px; white-space:nowrap; }
		.autocomplete-suggestions strong { font-weight:normal; color:#3399FF; }
	</style>	
	<script>
	$(function() {
		//  Автозаполнитель поиска
		$(".input_search").autocomplete({
			serviceUrl:'/ajax/search_products.php',
			minChars:1,
			noCache: false, 
			deferRequestBy: 400,
			onSelect:
				function(suggestion){
					 $(".input_search").closest('form').submit();
				},
			formatResult:
				function(suggestion, currentValue){
					var reEscape = new RegExp('(\\' + ['/', '.', '*', '+', '?', '|', '(', ')', '[', ']', '{', '}', '\\'].join('|\\') + ')', 'g');
					var pattern = '(' + currentValue.replace(reEscape, '\\$1') + ')';
	  				return suggestion.value.replace(new RegExp(pattern, 'gi'), '<strong>$1<\/strong>');
				}	
		});
	});
	</script>
	{/literal}
    
</head>
<body>

{if $module == "MainView"}
        <div class="transition"></div>
        {/if}
    <header>
    	<div class="top_header">
        	<div class="center">
            	<span class="fl mr5">Cпортивные товары -</span>
                <a href="/contact" class="fl cityes">Наши магазины</a>
                <span class="topphone">8(8652)511-777</span>
                 <a href="/vydacha-zakaza" class="subscription fl"><u>Места выдачи заказа</u></a>
                
             <!-- Вход пользователя --> 
             {if $user}  
                <span class="log_out fl">
                    <a href="user" class="db w100 h30 name pa">{$user->name}</a>
                    <a href="user/logout" class="exit fl">Выйти</a>
                </span>
             {else}
                <span class="enter fl">   
                    <a href="#myModal1" class="fl" style="line-height:0px;" data-toggle="modal">Войти</a>
                    <span class="line db fl"></span>
                 <a href="/user/register" class="fl" style="line-height:0px; margin-left: 8px;" data-toggle="modal">Регистрация</a>      
                </span>
             {/if}
             
             <!-- Вход пользователя (The End)-->   
             <span class="enter fl" style="position: relative;">10%скидка<img class="enter fl" src="/design/lidsport/images/tenpercent.png" style="float: left;width: 63px;position: absolute;top: 0px;"></span>   
           	</div>
        </div>
        <div class="header_center">
                <a href="/" class="logo"></a>
                <form action="/products" class="mb0 sisea-search-form fl" id="search-form">
                	<input  id='search-text' class="trabl_babl input_search" type="text" name="keyword" placeholder="У нас более 3000 товаров" value="{$keyword|escape}">
                	<button id='search-button' class="search_btn button_search" value="" type="submit" ><i></i></button>
                </form>  
                <div class="basket" id="cart_informer">
                {include file='cart_informer.tpl'} 
                </div>       
                <div class="cl"></div>
            </div>
                <nav>
                	<ul class="ul_menu">
                    	{* Рекурсивная функция вывода дерева категорий *}
                        {assign var="foo" value=0}
                        
                        {function name=categories_tree}
                        {if $categories}
                        	
                            {assign var="foo" value=$foo+1}
                            {if $foo > 1}<ul class="dropdown_menu"><i></i>{/if}
                            {foreach $categories as $c}
                                {* Показываем только видимые категории *}
                                {if $c->visible}
                                    <li>
                                        <a href="/{$c->url}"><span class="ur{$foo}" id="cat_id_{$c->id}"></span>{$c->name}</a>
                                        
                                        {categories_tree categories=$c->subcategories}
                                    </li>
                                {/if}
                            {/foreach}
                        	{if $foo > 1}</ul>{/if}
                        {/if}
                        {/function}
                        {categories_tree categories=$categories}
                    </ul>
                    <div class="cl"></div>
                </nav>
             
    </header>
          <div class="content">
            {if $module == "MainView"}
          
          
          <div class="slider clearfix">
          <div class="slides"><a href="http://lidsport.ru/dsk-i-aksessuary"><img src="/design/{$settings->theme}/images/ban0.png" alt="" style="max-height: 100%;width: 100%;" class="slide1"></a></div>
          <div class="slides"><a href="http://lidsport.ru/obuv"><img src="/design/{$settings->theme}/images/ban1.png" alt="" style="max-height: 100%;width: 100%;" class="slide1"></a></div>
          <div class="slides"><a href="http://lidsport.ru/velosipedy"><img src="/design/{$settings->theme}/images/ban2.png" alt="" style="max-height: 100%;width: 100%;" class="slide1"></a></div>
          <div class="slides"><a href="http://lidsport.ru/kimono"><img src="/design/{$settings->theme}/images/ban3.png" alt="" style="max-height: 100%;width: 100%;" class="slide1"></a></div>     
      </div>
     <script type="text/javascript">
            $(document).ready(function(){
              $('.slider').slick({
                arrows:true,
                dots:false,
                autoplay:true,
                autoplaySpeed:5000,
              });
            });
          </script>
       <div style="width:940px;margin:0 auto;">
        <div class="slider_bottom" style="margin:0;">
          <span class="phone fl">8(8652)511-777</span>
          <span class="dlia db fl  f34 b"><span class="col_green ttu  f34">Для тех,</span> кто любит побеждать</span>
          <span class="subscribe">Подпишись:</span>
          <a class="facebook" href="http://www.facebook.com/lidsport" target="_blank"></a>
          <a class="twitter" href="http://instagram.com/lidsport" target="_blank"></a>
          <a class="vk" href="http://vk.com/lidersport26" target="_blank"></a>
        </div>
    <div style="margin-top:30px;">
          <a href="http://lidsport.ru/zimnij-inventar?page=2"><img src="/design/{$settings->theme}/images/sm1.png" alt=""></a>
          <a href="http://lidsport.ru/zimnij-inventar?page=2"><img src="/design/{$settings->theme}/images/sm2.png" alt="" style="margin-left:22px;"></a>
          <a href="http://lidsport.ru/zimnij-inventar"><img src="/design/{$settings->theme}/images/sm3.png" alt="" style="margin-left:22px;"></a>
        </div>
      </div>
     {/if} 
          
            <div class="base">     
                  {$content}   
                  <ul class="ul_bottom_menu mb20">
                  	<li><a href="/contact">Контакты</a></li>
                    <li><a href="/o-nas">О нас</a></li>
                    <li><a href="/dostavka-i-oplata">Доставка и оплата</a></li>
                    <li><a href="/stock">Акции</a></li>
                  </ul>
                  <div class="cl"></div>             
            </div>
          </div>  
          
          
          {literal}<script type="text/javascript">
		  $(function() {
		  $('.ul_brand').carouFredSel({
		  width: 850,
		  height: 100,
		  /*scroll: {fx:'fade'},*/
		  prev: {button:'#prev5',items: 1},
		  next: {button:'#next5',items: 1},
		  /*auto:{play: false},*/
		  
		  auto: {play: true, items: 1, pauseOnHover: true, pauseDuration:6000},
		  items: 6
		  });
		  });			
		  </script>{/literal} 
		  
            <div class="div_brand h100">  
                <div class="w940 pr">
                     <a href="javascript:void(0)" class="leaf mt30 prev" id="prev5"></a>
                        <div class="fl fghjk">	
                            <ul class="ul_brand">
                                {foreach $brands as $brand}
                                {if $brand->image != ''}
                                <li><a href="/brands/{$brand->url}"><img src="/files/brands/{$brand->image}" alt="{$brand->name}" /></a></li>
                                {/if}
                                {/foreach}
                            </ul>
                        </div>
                    <a href="javascript:void(0)" class="leaf2 mt30 next" id="next5"></a>
                    <div class="cl"></div>
                </div>         
            </div>      
            <div class="footer h140">
            	<div class="footer_row">
                	<div class="fl h140 w330">
                        <div class="niz_logo w150"><a href="/" class="logo_small"></a></div>
                        <address class="db">
                            <span>Тел.  8(8652)511-777, info@lidsport.ru<br />
                            Адрес магазина: г. Ставрополь, ул. Макарова, д.26.стр Б.</span>  
                        </address>
                        <span class="copy db">&copy; 2015, Copyright Lidersport. «Лидерспорт» — спортивные товары</span>
                   </div>
                   <div class="oplata fl pr">
                   	<a class="nalich db mb10" href="/dostavka-i-oplata">наличными<br />курьеру</a>
                    <a href="/dostavka-i-oplata" class="visa db fl"></a>
                    <a href="/dostavka-i-oplata" class="mastercard db fl ml10"></a>
                    <a href="/dostavka-i-oplata" class="yandex db fl ml10"></a>
                   </div>
                   <div class="fl shem">
                   	<a href="/contact" class="shema">Схема проезда <br /><span>показать на карте</span></a>
                   </div>
                </div>
            </div>  
            <!--<div class="consultant_unavailable">
            	<div class="divner"><img src="/design/{$settings->theme}/images/konsult_net.png" alt="kons_net" /></div>
                <div class="unav_boot"><i></i></div>
            </div>-->
            <div class="message_box">
            	<div class="top_boxm">
                	<span class="f18 tac db pt15">Оставьте нам сообщение!<i>__</i></span>  
                </div>
                <div class="p20 pt0">
                    	<input class="ozb_name" name="name" type="text" placeholder="*Как Вас зовут">
                        <input class="ozb_tel" name="mail" type="text" placeholder="*Телефон или e-mail адрес">
                        <textarea class="ozb_com" name="mess" cols="" rows="" placeholder="*Здесь текст Вашего сообщения!"></textarea>
                        <div id="erro_2" style="display:none" class="alert alert-error"></div>
                        <div id="success_2" style="display:none" class="alert alert-success"><strong>Спасибо!</strong> Ваша заявка отправлена.</div>
                        <button onClick="post_zvon()" class="more_btn db m w140 h38 br3 b f16 lh38 min_btn bn cp">Отправить</button>
                </div>
            </div>
            
            
			
            <div id="myModal1" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
             <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <div class="mod_cen2">
                	{if $error}
                    <div class="message_error">
                        {if $error == 'login_incorrect'}Неверный логин или пароль
                        {elseif $error == 'user_disabled'}Ваш аккаунт еще не активирован.
                        {else}{$error}{/if}
                    </div>
                    {/if}
                	<span class="tit_md">Войти на лидерспорт</span>
                    <form class="form login_form" method="post" action="/user/login">
                     	  <input type="text" name="email" data-format="email" data-notice="Введите email" value="{$email|escape}" maxlength="255" placeholder="E-mail адрес"/>
                       	  <input type="password" name="password" data-format=".+" data-notice="Введите пароль" value="" placeholder="Пароль" />
                          <div class="cl"></div>
                          <input name="" type="checkbox" value="" class="fl chec">
                          <span class="zapom fl">Запомнить меня</span>
                          <div class="fl babl">
                          	<a href="user/password_remind" class="dop_lin">Забыли пароль</a>
                            <!--<a href="#" class="dop_lin">Регистрация</a>-->
                          </div>
                          <div class="cl"></div>
                          <input type="submit" class="button sign_in more_btn read_more" name="login" value="Войти">
                    </form>
                </div>
            </div>
            
            <!-- BEGIN JIVOSITE CODE {literal} -->
<script type='text/javascript'>
(function(){ var widget_id = 'Dlk7kbxKzY';
var s = document.createElement('script'); s.type = 'text/javascript'; s.async = true; s.src = '//code.jivosite.com/script/widget/'+widget_id; var ss = document.getElementsByTagName('script')[0]; ss.parentNode.insertBefore(s, ss);})();</script>
<!-- {/literal} END JIVOSITE CODE -->
          {literal}   
            
    <!-- Yandex.Metrika counter --><script type="text/javascript">(function (d, w, c) { (w[c] = w[c] || []).push(function() { try { w.yaCounter36200345 = new Ya.Metrika({id:36200345, webvisor:true, clickmap:true, trackLinks:true, accurateTrackBounce:true}); } catch(e) { } }); var n = d.getElementsByTagName("script")[0], s = d.createElement("script"), f = function () { n.parentNode.insertBefore(s, n); }; s.type = "text/javascript"; s.async = true; s.src = (d.location.protocol == "https:" ? "https:" : "http:") + "//mc.yandex.ru/metrika/watch.js"; if (w.opera == "[object Opera]") { d.addEventListener("DOMContentLoaded", f, false); } else { f(); } })(document, window, "yandex_metrika_callbacks");</script><noscript><div><img src="//mc.yandex.ru/watch/36200345" style="position:absolute; left:-9999px;" alt="" /></div></noscript><!-- /Yandex.Metrika counter -->        
            
        {/literal}     
       <div id="wrap"></div>
       
<div id="window"><img src="/design/{$settings->theme}/images/close.png" class="closeWindow">
<div id="windowInside"></div></div> 

<img src="" class="podobrat_razm" style="display:none;position: absolute;top: 150px;z-index: 9999;margin: 0 auto; left:50%">
<div id="rasrochka"> <img src="/design/{$settings->theme}/images/close.png" class="closeRasrochka">
<div id="rasrochkaInside"></div></div>    



















 



















</body>
</html>