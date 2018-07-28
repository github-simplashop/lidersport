<!-- spisok tovarov -->
{* Список товаров *}

      {* Заголовок страницы *}
      <div class="category_title mt20 mb20">
      {if $keyword}
        <span>Поиск {$keyword|escape}</span>
        {elseif $page}
        <span>{if $page->content_title}{$page->content_title|escape}{else}{$page->name|escape}{/if}</span>
        {else}
        <span>
        {if $category->content_title}
        {$category->content_title|escape}
        {else}
        {$category->name|escape} {$brand->name|escape} {$keyword|escape}
        {/if}
        </span>
        {/if}
      </div>
                  
                  
                  {foreach $categories as $c0}
                  {if $category->id == $c0->id}
                  <ul class="ul_type2 mb40">
                  {foreach $c0->subcategories as $c}
                  <li>
                  <a href="{$c->url}" data-category="{$c->id}">
                  <span class="dtc dfghj">
                  		 {if $c->image}<img src="{$config->categories_images_dir}{$c->image}" alt="{$c->name}">{/if}
                  </span>
                  <span class="category_type">{$c->name}</span>
                   </a>
                   </li>
                  {/foreach}
                  </ul>
                  {/if}
                  {/foreach}
                  <div class="cl"></div>
                  
                  {literal}
				  <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
                  
                  <script>
                  var variantsCatalog = [];
                  $(function() {
                    $( "#slider-range" ).slider({
                      range: true,
                      min: 0,
                      max: 50000,
                      values: [ 0, 5000 ],
                      slide: function( event, ui ) {
                        $( "#amount" ).val(ui.values[ 0 ]);
						$( "#amount2" ).val(ui.values[ 1 ]);
                      }
                    });
					$( "#amount" ).val($( "#slider-range" ).slider( "values", 0 ) );
					$( "#amount2" ).val($( "#slider-range" ).slider( "values", 1 ));
                  });
                  </script>
                  {/literal}
                  
                  <div class="div_tovar mb30 oh">
                  	<div class="tov_header h45">
                    	<!--<span class="ml30">Цена:</span>
                        <input id="amount" name="price" type="text">
                        <div id="slider-range"></div>
                        <input id="amount2" name="price" type="text">-->
                         
                        {* Сортировка *}
                            {if $products|count>0}
                            <span class="sort_title">Сортировать по:&nbsp;</span>
                                <ul class="sortirovca">
                                   <li class="first_sort "><span>Стоимости</span><span><a class="buttonsPrice {if $sort=='priceUp'}activeButtonsPrice{/if}"href="{url sort=priceUp page=null}">▲</a><a class="buttonsPrice {if $sort=='priceDown'}activeButtonsPrice{/if}" href="{url sort=priceDown page=null}">▼</a></span></li>
                                    <!--<li class="first_sort {if $sort=='price'}active{/if}" ><a { href="{url sort=price page=null}">Стоимости</a></li>-->
                                    <li class="{if $sort=='name'}active{/if}"><a href="{url sort=name page=null}">Алфавиту</a></li>
                                    <!--<li class="last_sort {if $sort=='position'}active{/if}"><a href="{url sort=position page=null}">Производителю</a></li>-->
                                </ul>
                          {/if}
                        
                        
                       {* Фильтр по брендам *}
                        {*{if $category->brands}
                        <div id="brands">
                          
                          {foreach name=brands item=b from=$category->brands}
                            
                            <a data-brand="brands/{$b->id}" href="brands/{$b->url}" {if $b->id == $brand->id}class="selected"{/if}>{$b->name|escape}</a>
                            
                          {/foreach}
                        </div>
                        {/if}*}
                    	<div class="cl"></div>
                    </div>
                    {include file='pagination.tpl'}
                    <div class="cl"></div> 
                         <div class="div_leaders2 mb25"> 	
                              <ul class="ul_leaders mb30 ml23 obs_cat">
                              {foreach $products as $product}
                                    <li>
                                    <a href="/{$product->cat_url}/u_{$product->url}">
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
                                    <a href="{$product->cat_url}/u_{$product->url}"><span class="product_name">{$product->name|escape}</span> </a>
									                   <div class="rating" rel="{$product->id}">
                                        <span class="rater-starsOff"><span style="width:{$product->rating*80/5|string_format:"%.0f"}px" class="rater-starsOn"></span></span> <span class="rater-rating">{$product->rating|string_format:"%.1f"}</span>&#160;(<span class="rater-rateCount">{$product->votes|string_format:"%.0f"}</span> {$product->votes|plural:'голос':'голосов':'голоса'})
                                    </div>
                                   <span class="db adgf"> 
                                  {if $product->variants|count < 2}

                                            <!-- Выбор варианта товара -->
                                            <form class="variants" action="/cart">
                                                 {foreach $product->variants as $v}
                                                 {if $v->pod_zakaz == 1}
                                                 <div class="out-of-stock" style="margin-top: -22px;">
                                                    <span style="display: block;font-size: 17px;">Этот товар вы можете приобрести под заказ. Цену уточняйте по тел.:511-777</span>
                                                </div>
                                                  {else}
                                                 <input id="variants_{$v->id}" name="variant" value="{$v->id}" type="radio" class="variant_radiobutton" {if $v@first}checked{/if} style="display:none;"/>
                                                 <span class="price fl">{if $v->compare_price > 0}<span class="discountPriceB"><span class="tdlt c_f00">{$v->compare_price|convert}</span><span class="rub b mt-1 pr"><span class="r_da pa">-</span>P</span>&nbsp;&nbsp;</span>{/if}{$v->price|convert} <span class="rub b mt-1 pr"><span class="r_da pa">-</span>P</span></span><span style="position: relative;"> 
                                                <input type="submit" class="carts_b" data-result-text="добавлено"></input><span class="buyButton">КУПИТЬ</span></span>
                                            </form>{/if}
                                                {/foreach}
                                            <!-- Выбор варианта товара (The End) -->
                                            {elseif $product->variants|count > 1}
												                    {*print_r(convert)*}
                                               {foreach $product->variants as $v}{if $v->pod_zakaz == 1}
                                                 <div class="out-of-stock" style="margin-top: -22px;">
                                                    <span style="display: block;font-size: 17px;">Этот товар вы можете приобрести под заказ. Цену уточняйте по тел.:511-777</span>
                                                </div>
                                                  {else}
                                                  {if $product->min_price} <span class="price fl">{if $v->compare_price > 0}<span class="discountPriceB"><span class="tdlt c_f00">{$v->compare_price|convert}</span><span class="rub b mt-1 pr"><span class="r_da pa">-</span>P</span>&nbsp;&nbsp;</span>{/if}от {$product->min_price|convert} <span class="rub b mt-1 pr"><span class="r_da pa">-</span>P</span></span>{/if}<a href="{$product->cat_url}/u_{$product->url}" style="position: relative;" class="data" product="{$product->id}"> 
                                                <input type="submit" class="carts_b" data-result-text="добавлено"></input><span class="aboutButton" >КУПИТЬ</span> {/if}{break}{/foreach} 
                                            {/if} 
                                  
                              
                             </li> 
                                    {/foreach}        
                              </ul> 
                              <div class="super_hiding"></div> 
                              <div class="cl"></div>           
                        </div> 
                        <!--<div class="pagination mt20 mb20 ml20 fl">
                            <span class="fl">Страницы:</span>
                            <ul>
                                <li><a href="#" class="active">1</a></li>
                                <li><a href="#">2</a></li>
                            </ul>
                            <div class="cl"></div>
                   	   </div> --> 
                       {include file='pagination.tpl'}
                       		<div class="cl"></div>
                       <div class="pagination mt20 mb20 ml780 fl pa" style="display:none;">
                            <span class="fl">Показано</span>
                            <ul class="mt-5">
                                <li><a href="#" class="active">1-8</a></li>
                                <li>из &nbsp;<a href="#">26</a></li>
                            </ul>
                            <div class="cl"></div>
                   	   </div> 
                       <div class="cl"></div>
                       <div class="anno pl80 pr80 mb25">
                       		<span class="title_anno mt25 mb25">
                           {if $keyword}
                            <span class="f18">Поиск {$keyword|escape}</span>
                            {elseif $page}
                            <span class="f18">{if $page->content_title}{$page->content_title|escape}{else}{$page->name|escape}{/if}</span>
                            {else}
                            <span class="f18">
                            {if $category->content_title}
                            {$category->content_title|escape}
                            {else}
                            {$category->name|escape} {$brand->name|escape} {$keyword|escape}
                            {/if}
                            </span class="f18">
                            {/if}
                            </span>
                            {$category->description}
                            </div>
                    <div class="cl"></div>
                    <div class="tov_footer h45"></div>
                  </div>
 <div class="cl"></div> 
 