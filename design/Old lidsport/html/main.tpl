{* Главная страница магазина *}

{* Для того чтобы обернуть центральный блок в шаблон, отличный от index.tpl *}
{* Укажите нужный шаблон строкой ниже. Это работает и для других модулей *}
{$wrapper = 'index.tpl' scope=parent}
<!--<div class="div_slider mb30">
                    <div class="h360 oh fghj pr">
                  {literal}<script type="text/javascript">
			$(function() {
				$('.home_slide_in').carouFredSel({
									width: 940,
									height: 360,
									scroll: {fx:'fade'},
									prev: {button:'.prev',items: 1},
									next: {button:'.next',items: 1},
									/*auto:{play: false},*/
									pagination  : ".switch",
									auto: {play: true, items: 1, pauseOnHover: true, pauseDuration:6000},
									items: 1
						});
			});			
</script>{/literal} 

						<ul class="home_slide_in">
                                	<li>
                            			<a href="http://lidsport.ru/detskie-3--kolesnye/u_velosiped-trajk-va-tokyo-2"><img src="design/{$settings->theme}/images/slider_img1.jpg" alt=""></a>
                             	   </li>
                                	<li>
                            			<a href="http://lidsport.ru/roliki/u_roliki-0813_6033-v-ryukzake"><img src="design/{$settings->theme}/images/slider_img2.jpg" alt=""></a>
                             	   </li>
                                	<li>
                            			<a href="http://lidsport.ru/contact"><img src="design/{$settings->theme}/images/slider_img3.jpg" alt=""></a>
                             	   </li>
                        </ul>  
                        <div class="cl"></div>                    
                    </div>
                    <div class="basis">
                        <div class="switch w60 h10">
                            <a href="javascript:void(0)"></a>                       
                            <a href="javascript:void(0)"></a> 
                            <a href="javascript:void(0)" class="active"></a>
                        </div>
                    </div>
                    <div class="slider_bottom">
                        <span class="phone fl">8(8652)511-777</span>
                        <span class="dlia db fl  f34 b"><span class="col_green ttu  f34">Для тех,</span> кто любит побеждать</span>
                        <span class="subscribe">Подпишись:</span>
                        <a class="facebook" href="http://www.facebook.com/lidsport" target="_blank"></a>
                        <a class="twitter" href="http://instagram.com/lidsport" target="_blank"></a>
                        <a class="vk" href="http://vk.com/lidersport26" target="_blank"></a>
                    </div>
                    <div class="cl"></div> 
                  </div>  
                -->  
  
                  {* Лидеры продаж *}
                    {get_featured_products var=featured_products}
                    {if $featured_products}
                    {literal}
					<script type="text/javascript">
                    $(function() {
							$('#slider_1').carouFredSel({
							width: 896,
							height: 322,
							/*scroll: {fx:'fade'},*/
							prev: {button:'#prev2',items: 1},
							next: {button:'#next2',items: 1},
							/*auto:{play: false},*/
							
							auto: {play: true, items: 1, pauseOnHover: true, pauseDuration:6000},
							items: 4
							});
						});			
                    </script>
                    {/literal} 
                  <div class="div_leaders mb30">
                  <i class="nhjk">Лидеры продаж</i>
                  	<a href="javascript:void(0)" class="leaf fl mt140 ml5 prev2" id="prev2"></a>
                      <ul class="ul_leaders" id="slider_1">
                        {foreach $featured_products as $product}
                          <li> 
                          	<a href="{$product->cat_url}/u_{$product->url}">
                                    <span class="block_img">
                                    {if $product->imagesc}
                                                        <img src="/images1c/{$product->imagesc}" alt="{$product->name|escape}" style="display:block; margin:0 auto; max-height:140px;">
                                       
                                         {else} 
                                         {if $product->image}
                                                <img src="{$product->image->filename|resize:190:140}" alt="{$product->name|escape}" style="display:block; margin:0 auto;">
                                                {else}
                                                <img src="/design/lidsport/images/defaultPhoto.png" alt="{$product->name|escape}" style="display:block; margin:0 auto;">
                                                {/if}
                                          {/if}
                                    </span> 
                            </a>        
                            <script>
                            console.log("{$product->cat_url} aaaaa");
                            </script>
                                    <a href="{$product->cat_url}/u_{$product->url}"><span class="product_name">{$product->name|escape}</span> </a>
                                    <div class="rating" rel="{$product->id}">
                                        <span class="rater-starsOff"><span style="width:{$product->rating*80/5|string_format:"%.0f"}px" class="rater-starsOn"></span></span> <span class="rater-rating">{$product->rating|string_format:"%.1f"}</span>&#160;(<span class="rater-rateCount">{$product->votes|string_format:"%.0f"}</span> {$product->votes|plural:'голос':'голосов':'голоса'})
                                    </div>
                                                                       <span class="db adgf"> 
                                  {if $product->variants|count < 2 && $product->variants|count != 0}
                                            <!-- Выбор варианта товара -->
                                            <form class="variants" action="/cart">
                                                 {foreach $product->variants as $v}
                                                 {if $v->pod_zakaz == 1}
                                                 <div class="out-of-stock" style="margin-top: -22px;">
                                                    <span style="display: block;font-size: 17px;">Этот товар вы можете приобрести под заказ. Цену уточняйте по тел.:511-777</span>
                                                </div>
                                                  {else}<input id="variants_{$v->id}" name="variant" value="{$v->id}" type="radio" class="variant_radiobutton" {if $v@first}checked{/if} style="display:none;"/>
                                                 <span class="price fl">{if $v->compare_price > 0}<span class="discountPriceB"><span class="tdlt c_f00">{$v->compare_price|convert}</span><span class="rub b mt-1 pr"><span class="r_da pa">-</span>P</span>&nbsp;&nbsp;</span>{/if}{$v->price|convert} <span class="rub b mt-1 pr"><span class="r_da pa">-</span>P</span></span><span style="position: relative;"> 
                                                <input type="submit" class="carts_b" data-result-text="добавлено"></input><span class="buyButton">КУПИТЬ</span></span>
                                            </form>
                                                {/if}{/foreach}
                                            <!-- Выбор варианта товара (The End) -->
                                            {elseif $product->variants|count >1}{foreach $product->variants as $v}{if $v->pod_zakaz == 1}
                                                 <div class="out-of-stock" style="margin-top: -22px;">
                                                    <span style="display: block;font-size: 17px;">Этот товар вы можете приобрести под заказ. Цену уточняйте по тел.:511-777</span>
                                                </div>
                                                  {else}<input id="variants_{$v->id}" name="variant" value="{$v->id}" type="radio" class="variant_radiobutton" {if $v@first}checked{/if} style="display:none;"/>
                                                 <span class="price fl">{if $v->compare_price > 0}<span class="discountPriceB"><span class="tdlt c_f00">{$v->compare_price|convert}</span><span class="rub b mt-1 pr"><span class="r_da pa">-</span>P</span>&nbsp;&nbsp;</span>{/if}{$v->price|convert} <span class="rub b mt-1 pr"><span class="r_da pa">-</span>P</span></span>
                                                <a href="{$product->cat_url}/u_{$product->url}" style="position: relative;" class="data" product="{$product->id}">
                                                <input type="submit" class="carts_b" data-result-text="добавлено"></input><span class="aboutButton"product="{$product->id}">КУПИТЬ</span></span>{/if}{break}{/foreach}<!--<a href="{$product->cat_url}/u_{$product->url}" class="more_btn h30 br3 min_btn trable1 m0a w100 db lh29">Подробнее</a>-->
                                                 {else}
                                            <div class="out-of-stock" style="margin-top: -22px;">
                                                    <span style="font-size: 20px;">Под заказ</span>
                                                    <span style="display: block;font-size: 14px;">цены уточняйте у продавцов-консультантов</span>
                                                </div>
                                            {/if}
                                  </span> 
                              
                             </li> 
                            {/foreach}
                      </ul>         
                      <a href="javascript:void(0)" class="leaf2 mt140 mr5 next2" style="z-index:1;" id="next2"></a>  
                      <div class="hidden_line"></div> 
                  </div>
                  {/if}
                  
              
                  
                  <!--{* Скидки *}
                   {get_discounted_products var=discounted_products}
                  {if $discounted_products}
                  {literal}
					<script type="text/javascript">
                    $(function() {
							$('#slider_3').carouFredSel({
							width: 896,
							height: 322,
							/*scroll: {fx:'fade'},*/
							prev: {button:'#prev4',items: 1},
							next: {button:'#next4',items: 1},
							/*auto:{play: false},*/
							
							auto: {play: true, items: 1, pauseOnHover: true, pauseDuration:6000},
							items: 4
							});
						});			
                    </script>
                    {/literal}
                  <!--<div class="div_leaders mb30">
                  <i class="nhjk">Скидки</i>
                  	<a href="javascript:void(0)" class="leaf fl mt140 ml5 prev2" id="prev4"></a>
                      <ul class="ul_leaders" id="slider_4">
                        {foreach $discounted_products as $product}
                          <li> 
                          	<a href="{$product->cat_url}/u_{$product->url}">
                                    <span class="block_img"> 
                                         {if $product->image}
                                                <img src="{$product->image->filename|resize:190:140}" alt="{$product->name|escape}" style="display:block; margin:0 auto;">
                                                {else}
                                                <img src="/design/lidsport/images/defaultPhoto.png" alt="{$product->name|escape}" style="display:block; margin:0 auto;">
                                                {/if}
                                    </span> 
                            </a>        
                                    <a href="{$product->cat_url}/u_{$product->url}"><span class="product_name">{$product->name|escape}</span> </a>
                                    <div class="rating" rel="{$product->id}">
                                        <span class="rater-starsOff"><span style="width:{$product->rating*80/5|string_format:"%.0f"}px" class="rater-starsOn"></span></span> <span class="rater-rating">{$product->rating|string_format:"%.1f"}</span>&#160;(<span class="rater-rateCount">{$product->votes|string_format:"%.0f"}</span> {$product->votes|plural:'голос':'голосов':'голоса'})
                                    </div>
                                   <span class="db adgf"> 
                                  {if $product->variants|count < 2}
                                            <!-- Выбор варианта товара -->
                                            <!--<form class="variants" action="/cart">
                                           
                                                 {foreach $product->variants as $v}
                                                  <input id="variants_{$v->id}" name="variant" value="{$v->id}" type="radio" class="variant_radiobutton" {if $v@first}checked{/if} style="display:none;"/>
                                                 <span class="price fl">{if $v->compare_price > 0}<span class="tdlt c_f00">{$v->compare_price|convert}</span>&nbsp;&nbsp;{/if}{$v->price|convert} <span class="rub b mt-1 pr"><span class="r_da pa">-</span>P</span></span>
                                                {/foreach}<span style="position: relative;"> 
                                                <input type="submit" class="carts_b" data-result-text="добавлено"></input><span class="buyButton">КУПИТЬ</span></span>
                                            </form>
                                            <!-- Выбор варианта товара (The End) -->
                                            <!--{else}<input id="variants_{$v->id}" name="variant" value="{$v->id}" type="radio" class="variant_radiobutton" {if $v@first}checked{/if} style="display:none;"/>
                                                 <span class="price fl">{if $v->compare_price > 0}<span class="tdlt c_f00">{$v->compare_price|convert}</span>&nbsp;&nbsp;{/if}{$v->price|convert} <span class="rub b mt-1 pr"><span class="r_da pa">-</span>P</span></span>
                                                <a href="{$product->cat_url}/u_{$product->url}" style="position: relative;" product="{$product->id}" class="data"> 
                                                <input type="submit" class="carts_b" data-result-text="добавлено" ></input><span class="aboutButton"product="{$product->id}">КУПИТЬ</span></span><!--<a href="{$product->cat_url}/u_{$product->url}" class="more_btn h30 br3 min_btn trable1 m0a w100 db lh29">Подробнее</a>-->
                                            <!--{/if}
                                  </span> 
                              
                             </li> 
                            {/foreach}
                      </ul>         
                      <a href="javascript:void(0)" class="leaf2 mt140 mr5 next2" style="z-index:1;" id="next4"></a> 
                      <div class="hidden_line"></div> 
                  </div>
                  {/if}-->
                    
                  <div class="cl"></div>       
                  <div class="equipment pr" style="display:none;">
                  <i class="special_offer">Спецпредложение</i>
                      <span class="db equipment_title ttu tac mt25 mb20 b f34">Выбери свою экипировку</span>
                      <span class="type ttu db mb45 f18 b">Единоборства</span>
                      
                      <div class="pa social">
                          <div class="share42init">
                          <script src="/design/{$settings->theme}/js/share42.js"></script>
                          </div>
                      </div>
                       
                      <ul class="ul_type">
                     	 <li><a href="#">Бокс</a><i></i></li>
                         <li class="active"><a href="#">Рукопашный бой</a><i></i></li>
                         <li><a href="#">Тхэквондо</a><i></i></li>
                         <li><a href="#">Дзюдо</a><i></i></li>
                         <li><a href="#">Кикбоксинг</a><i></i></li>
                         <li><a href="#">Борьба</a><i></i></li>
                         <li><a href="#">Самбо</a><i></i></li>
                      </ul>
                      <div class="cl"></div>
                      <div class="fl kadabra">
                          <div class="model">
                            <img src="/design/{$settings->theme}/images/model.png" alt="model" /> 
                          </div>
                       </div>   
                      <ul class="ul_equipment">
                      	<li>
                        	<a href="#">
                            	<span class="fl">
                                    <span class="mini_img_block">
                                        <img src="/design/{$settings->theme}/images/mini_img_t1.jpg" alt="mini_img" />
                                    </span>
                                </span> 
                                <span class="name_t fl ml10 mt5">Шлем Everlast Leather AIBA Competition синий</span>
                                <del class="ml10 mr10 mt10 rub fl b db">P</del>
                                <span class="price5 fl">13 500</span>
                                <span class="color blue active" style="position: absolute; margin: 61px 0 0 160px;"></span>
                                <span class="color red" style="position: absolute; margin: 61px 0 0 180px;"></span>
                                <a class="more_btn db w30 h30 br3 fl pa min_btn mt50 ml280 eklmn" href="#"><i></i></a>
                            </a>
                        </li>
                        <li>
                        	<a href="#">
                            	<span class="fl">
                                    <span class="mini_img_block">
                                        <img src="/design/{$settings->theme}/images/mini_img_t2.jpg" alt="mini_img" />
                                    </span>
                                </span> 
                                <span class="name_t fl ml10 mt5">Кимоно Atemi AX1</span>
                                <del class="ml10 mr10 mt10 rub fl b db">P</del>
                                <span class="price5 fl">1100</span>
                                <span class="color blue" style="position: absolute; margin: 61px 0 0 160px;"></span>
                                <span class="color red" style="position: absolute; margin: 61px 0 0 180px;"></span>
                                <span class="color black" style="position: absolute; margin: 61px 0 0 200px;"></span>
                                <span class="color white active" style="position: absolute; margin: 61px 0 0 220px;"></span>
                                <a class="more_btn db w30 h30 br3 fl pa min_btn mt50 ml280 eklmn" href="#"><i></i></a>
                            </a>
                        </li>
						<li>
                        	<a href="#">
                            	<span class="fl">
                                    <span class="mini_img_block">
                                        <img src="/design/{$settings->theme}/images/mini_img_t3.jpg" alt="mini_img" />
                                    </span>
                                </span> 
                                <span class="name_t fl ml10 mt5">Перчатки Everlast PU Pro Style Anti-MB синие</span>
                                <del class="ml10 mr10 mt10 rub fl b db">P</del>
                                <span class="price5 fl">1300</span>
                                <span class="color blue active" style="position: absolute; margin: 61px 0 0 160px;"></span>
                                <span class="color red" style="position: absolute; margin: 61px 0 0 180px;"></span>
                                <a class="more_btn db w30 h30 br3 fl pa min_btn mt50 ml280 eklmn" href="#"><i></i></a>
                            </a>
                        </li>
                        <li>
                        	<a href="#">
                            	<span class="fl">
                                    <span class="mini_img_block">
                                        <img src="/design/{$settings->theme}/images/mini_img_t4.jpg" alt="mini_img" />
                                    </span>
                                </span> 
                                <span class="name_t fl ml10 mt5">Защита зубов Atemi PMGS-546</span>
                                <del class="ml10 mr10 mt10 rub fl b db">P</del>
                                <span class="price5 fl">90</span>
                                <a class="more_btn db w30 h30 br3 fl pa min_btn mt50 ml280 eklmn" href="#"><i></i></a>
                            </a>
                        </li>
                        <li>
                        	<a href="#">
                            	<span class="fl">
                                    <span class="mini_img_block">
                                        <img src="/design/{$settings->theme}/images/mini_img_t5.jpg" alt="mini_img" />
                                    </span>
                                </span> 
                                <span class="name_t fl ml10 mt5">Боксерки низкие Рэй Спорт БП2 черные</span>
                                <del class="ml10 mr10 rub fl mt10 b db">P</del>
                                <span class="price5 fl">1300</span>
                                <span class="color black active" style="position: absolute; margin: 61px 0 0 160px;"></span>
                                <span class="color white" style="position: absolute; margin: 61px 0 0 180px;"></span>
                                <a class="more_btn db w30 h30 br3 fl pa min_btn mt50 ml280 eklmn" href="#"><i></i></a>
                            </a>
                        </li>
                      </ul>
                      <div class="cl"></div>
                      <a class="more_btn db w30 h30 br3 fl pa min_btn w150 h40 lh40 f16 b ghjk" href="#">купить всё</a>
                      		<div class="lkjh">
                            	<span class="fl jhfg mr5 b">Сумма товаров:</span>
                                <span class=".price6 b fl f16 mr5">90</span>
                                <del class="mr10 fl f16 rub b db asdf">P</del>
                            </div>
                            <div class="cl"></div>
                          <div class="choice_info">
                          	<div class="push">
                            	<span class="vibor mb10">ПРИ ВЫБОРЕ СПОРТИВНОЙ ОДЕЖДЫ И ЭКИПИРОВКИ, ОБРАТИТЕ ВНИМАНИЕ НА ТАКИЕ ПОКАЗАТЕЛИ:</span>
                                <ul class="ul_vibor">
                                	<li>для каких целей (для тренировок и для соревнований нужно купить разные виды товаров);</li>
                                    <li>материалы, из которого сшиты вещи (практичные хлопок, кожа, синтетические ткани);</li>
                                    <li>плотность материалов и степень защиты от травм (в зависимости от техник ведения боя: ударные или бросковые). </li>
                                </ul>
                            </div>
                          </div>  
                  </div>