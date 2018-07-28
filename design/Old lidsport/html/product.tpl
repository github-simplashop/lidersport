<!-- stranica tovara -->
{*Страница товара*}
{foreach from=$category->path item=cat}{assign var=foocat value=$cat->name}{/foreach}
    {*color-size-foto*}
    {if $product->variants|count > 0}
        <script>

        {if $empty_color}
            var colorValue = false;
            console.log("{$empty_color} +"+colorValue);
        {else}
            var colorValue = true;
            console.log("{$empty_color} +"+colorValue);
        {/if}

        {if $empty_razmer} 
            var razmerValue = false;
            console.log("{$empty_razmer} +"+razmerValue);
        {else}
            var razmerValue = true;
            console.log("{$empty_razmer} +"+razmerValue);
        {/if}
        var addColor = function(){
            if ($("#color").children("div").css('display') != 'none'){
                if ($("#colors").children("div").children("label").hasClass("active")){
                colorValue = true;
            }
            else
            {
                colorValue = false;
            } 
            }
             
        } 
        var addRazmer = function() {
            if ($("#variants").children("div").css('display') != 'none'){
            if($("#variants option:selected").val()=='0')
            {
                razmerValue = false;
                console.log("here1");
            }
            else if ($("#variants").children("div").children("label").hasClass("active") || $("#variants option:selected").val()=='0' && $("#variants option:selected").val() !==undefined) {
                console.log($("#variants option:selected").val());
            razmerValue = true;
            console.log("here2");
            }
            else
            {
                razmerValue = false;
                console.log("here3");
            }
        }

        }
            var variants = [
                {foreach $product->variants as $v} {literal}{{/literal}'id':'{$v->id}','color':'{$color[$v->id]}',  'razmer':'{$razmers[$v->id]}',  'price':'{$v->price|convert}', 'compare_price':'{$v->compare_price}', 'stock':'{$v->stock}'{literal}}{/literal},{/foreach}
            ];
            {literal}
                function changeColor(eventObject)
                {
                    if($(eventObject).parent().hasClass('not_select')) {return true};
                    if($(eventObject).parent().hasClass('active'))
                    {
                        $(eventObject).parent().removeClass('active');
                    }
                    else
                    {
                        $('#colors label').removeClass('active');
                        $(eventObject).parent().addClass('active');
                    }
                    
                    validateVariant();
                    
                    if($('#variants label.active').length > 0)
                    {
                        return true
                    }
                    else
                    {
                        $('#variants option').hide();
                        $('#variants option').eq(0).show();
                        $('#variants label').addClass('not_select');
                        $.each(variants, function(id, val){
                              
                            if(val.color==$(eventObject).val())
                            {
                                $('#variants label:contains("'+val.razmer +'")').removeClass('not_select').addClass('select');
                                $('#variants option:contains("'+val.razmer +'")').show();
                            }
                        });
                    }
                    
                    if($('#colors label.active').length <= 0)
                    {
                        $('#variants label').removeClass('not_select');
                        $('#variants option').show();
                    }
                }
                
                function changeVariant(eventObject)
                {
                    if($('#variants select').val() !== undefined)
                    {
                        $('#colors label').addClass('not_select');
                        $.each(variants, function(id, val)
                        {
                            if(val.razmer==$('#variants input').val())
                            {
                                $('#colors label[rel="' + val.color + '"]').removeClass('not_select').addClass('select');
                            }
                            
                            if(val.razmer==$(eventObject).val())
                            {
                                $('#colors label[rel="' + val.color + '"]').removeClass('not_select').addClass('select');
                            }
                            
                        });
                        
                        if($(eventObject).val() == 0)
                        {
                            $('#colors label').removeClass('not_select');
                        }
                    }
                    else
                    {
                        if($(eventObject).parent().hasClass('not_select')) return true;
                        if($(eventObject).parent().hasClass('active'))
                        {
                            $(eventObject).parent().removeClass('active');
                            $('#colors label').removeClass('not_select');
                        }
                        else
                        {
                            $('#variants label').removeClass('active');
                            $(eventObject).parent().addClass('active');
                            $('#colors label').addClass('not_select');
                            $.each(variants, function(id, val)
                            {
                                if(val.razmer==$(eventObject).val())
                                {
                                    $('#colors label[rel="' + val.color + '"]').removeClass('not_select').addClass('select');
                                }
                                
                                if(val.razmer==$('#variants select').val())
                                {
                                    $('#colors label[rel="' + val.color + '"]').removeClass('not_select').addClass('select');
                                }
                                
                            });
                        }
                    }
                    validateVariant();
                }
            {/literal}
            
            {if $empty_color || $empty_razmer}
            {literal}
                function validateVariant()
                {
                    // disabled
                    $.each(variants, function(id, val)
                    {
                        if({/literal}{if $empty_razmer}val.razmer==$('#variants label.active input').val(){/if} {if $empty_razmer && $empty_color}&&{/if}{if $empty_color}val.color==$('#colors label.active input').val(){/if}{literal})
                        {
                            var amount = $('input[name="amount"').val();
                            if(amount > val.stock)
                            {
                                $('input[name="amount"').val(val.stock);
                            }
                            $('[name=variant]').remove();
                            $('form.variants input[type="submit"]').before('<input type="radio" checked="checked" name="variant" style="display: none;" value="' + val.id + '" var_amount="'+ val.stock +'">');
                            $('form.variants input[type="submit"]').removeAttr('disabled');
                            $('.price,.product-price').text(val.price);// + " руб.");
                            return false;
                        }
                        else if({/literal}{if $empty_razmer}val.razmer==$('#variants option:selected').val(){/if} {if $empty_razmer && $empty_color}&&{/if}{if $empty_color}val.color==$('#colors label.active input').val(){/if}{literal})
                        {
                            var amount = $('input[name="amount"').val();
                            if(amount > val.stock)
                            {
                                $('input[name="amount"').val(val.stock);
                            }
                            $('[name=variant]').remove();
                            $('form.variants input[type="submit"]').before('<input type="radio" checked="checked" name="variant" style="display: none;" data="'+ amount +'" value="' + val.id + '" var_amount="'+ val.stock +'">');
                            $('form.variants input[type="submit"]').removeAttr('disabled');
                            $('.price,.product-price').text(val.price);// + " руб.");
                            return false;
                        }
                        else
                        {
                                $('form.variants input[type="submit"]').attr('disabled','disabled');
                        }
                    });
                }
            {/literal}
            {else}
            {literal}
                $(document).ready(function()
                {

                    // disabled
                    $.each(variants, function(id, val)
                    {
                        var amount = $('input[name="amount"').val();
                        if(amount > val.stock)
                        {
                            $('input[name="amount"').val(val.stock);
                        }
                        $('form.variants input[type="submit"]').before('<input type="radio" checked="checked" name="variant" style="display: none;" data="'+ amount +'" value="' + val.id + '"var_amount="'+ val.stock +'">');
                        $('form.variants input[type="submit"]').removeAttr('disabled');
                        $('.price,.product-price').text(val.price);// + " руб.");
                        return false;
                    });
                });
            
{/literal}
{/if}
{literal}
            

            $(function() {
                $('#colors input').on('click', function(){   changeColor(this); addColor();});
                $('#variants input').on('click', function(eventObject){ changeVariant(this); addRazmer(); });
                $('#variants select').on('change', function(eventObject){ changeVariant(this); addRazmer(); });
                //   changeColor();
//                    changeVariant($('[name=variant]:eq(0)'));
            });
            
//{* кнопки + и - *}            
            $(document).ready(function(){
    
            $('body').on('click','.spinner-plus',function(e){
               var var_amount = $('input[name="variant"').attr('var_amount');
               if(parseInt($('.spinner-wrapper input').val()) < var_amount)
               {
                   var plus = parseInt($('.spinner-wrapper input').val())+1;
                   $('.spinner-wrapper input').val(plus);
               }else{
                    $('.spinner-wrapper input').val($('.spinner-wrapper input').val()); 
               }
                e.preventDefault();
        
            });
        
            
            $('body').on('click','.spinner-minus',function(e){
                var minus = parseInt($('.spinner-wrapper input').val())-1;
                if(parseInt($('.spinner-wrapper input').val()) > 1 )
                    $('.spinner-wrapper input').val(minus);
                else
                    $('.spinner-wrapper input').val('1');
                e.preventDefault();
        
            });
    
 });
            
            {/literal}
        </script>
    {/if}
    {* color-size-foto /*}
<ul class="ul_patch pb25">
	<li><a href="/">Главная</a></li>
    {foreach from=$category->path item=cat}
        <li><a href="/{$cat->url}">{$cat->name|escape}</a></li>
    {/foreach}
    <li><a class="active" href="#">{$product->name|escape}</a></li>
</ul> 
<div class="cl"></div>  
                <div class="div_tovar mb30">
                	<div class="tov_header h45"></div>
                    <div class="indent mt30 ml60 mr60 mb60">
                    	<div class="fl">
                        	<div class="div_img_tov">
                                {if $image_first}
                                <a href="/images1c/{$image_first}" class="fancybox" rel="gallery_1">
                                                <img src="/images1c/{$image_first}" alt="{$product->name|escape}" style="display:block; margin:0 auto; ">
                                </a> 
                                {else}
                                {if $product->image}
                            	<a href="{$product->image->filename|resize:1024:1024:w}" class="fancybox" rel="gallery_1">
                            		          
                                                <img src="{$product->image->filename|resize:1024:1024:w}" alt="{$product->name|escape}" style="display:block; margin:0 auto;">
                                                {else}
                                                <a href="/design/lidsport/images/defaultPhoto.png" class="fancybox" rel="gallery_1">
                                                <img src="/design/lidsport/images/defaultPhoto.png" alt="{$product->name|escape}" style="display:block; margin:0 auto;">
                                                {/if}
                               </a> 
                               {/if}
                            </div>
                               
                            {if $imagesc|count>1}
                            <ul class="ul_dop_img">
                            {* cut удаляет первую фотографию, если нужно начать 2-й - пишем cut:2 и тд *}
                                {foreach $imagesc|cut as $i=>$image}
                                <li>
                                    <a href="/images1c/{$image}" class="fancybox" rel="gallery_1" style="height:1024px;">
                                        <span class="dtc w108 h80 vam tac">
                                                <img src="/images1c/{$image}" alt="{$product->name|escape}" style="display:block; margin:0 auto;max-height:80px;">
                                        </span>
                                    </a>
                                </li>  
                                {/foreach}
                            </ul>
                            {elseif $product->images|count>1}
                            <ul class="ul_dop_img">
                            {* cut удаляет первую фотографию, если нужно начать 2-й - пишем cut:2 и тд *}
                                {foreach $product->images|cut as $i=>$image}
                            	<li>
                                	<a href="{$image->filename|resize:1024:1024:w}" class="fancybox" rel="gallery_1">
                                        <span class="dtc w108 h80 vam tac">
                                                 {if $product->image}
                                                <img src="{$image->filename|resize:108:80}" alt="{$product->name|escape}" style="display:block; margin:0 auto;">
                                                {else}
                                                <img src="/design/lidsport/images/defaultPhoto.png" alt="{$product->name|escape}" style="display:block; margin:0 auto;">
                                                {/if}
                                        </span>
                                    </a>
                                </li>  
                                {/foreach}
                            </ul>
                            {/if}
                            <div class="cl"></div>
                            <div class="coc2 mt30">
                                  <div class="share42init">
                                  		<script src="/design/{$settings->theme}/js/share42.js"></script>
                                  </div>
                            </div>
                        </div>
                        <div class="fl w430 mb30 ml40">
                        	<span class="name_tovar">{$product->name|escape}</span>
                                {if $brand}
                                <span>Брэнд - <a href="/brands/{$brand->url}">{$brand->name|escape}</a></span>
                                {/if}
                                <div class="rating" rel="{$product->id}">
                                <span class="rater-starsOff"><span style="width:{$product->rating*80/5|string_format:"%.0f"}px" class="rater-starsOn"></span></span> <span class="rater-rating">{$product->rating|string_format:"%.1f"}</span>&#160;(<span class="rater-rateCount">{$product->votes|string_format:"%.0f"}</span> {$product->votes|plural:'голос':'голосов':'голоса'})
                            </div>
                            {if $product->pod_zakaz}
                                <div class="out-of-stock">
                                                    <span class="aboutZakaz"> 
                                                        {if $product->variant->price!=0}Цена: {$product->variant->price|convert} руб.{/if}<br> Этот товар вы можете приобрести под заказ. Цену уточняйте по тел.:511-777<br>доставка 7 дней</span>
                                                </div>
                            {elseif $product->variants|count > 0}
                                <!-- Выбор варианта товара -->
                                <form class="variants mb30" action="/cart">          
                                    <table class="product-info">
                                        <tr>
                                            <td id="colors" >
                                                <div {if !$empty_color}style="display:none;"{/if}>
                                                <span  >Цвет:</span>
                                                {foreach $color_u as $k=>$v}
                                                    {if $v|strpos:"." !== false}
                                                        <label rel="{$v}" style="
                                                            background: url('../images/textures/{$v}') no-repeat; background-size: 100%;" {if $v@first}  class="first"{/if}>
                                                            <input type="radio" value="{$v}" {if $v@first} checked{/if} />
                                                        </label>    
                                                    {else}
                                                        <label rel="{$v}" style="background-color: {$v}; " {if $v@first}  class="first"{/if}><input type="radio" name="color" value="{$v}"{if $v@first} checked{/if} /></label>
                                                    {/if}
                                                {/foreach}
                                                </div>
                                            </td>
                                            <td class="price-cell">
                                            {if $product->variants|count > 0}
                            					{if $product->variant->compare_price}
                            						<!--<span class="product-price-discount" id="product-price">{$product->variant->compare_price|convert}<i>{$product->variant->price|convert} {$currency->sign|escape}.</i></span>-->
                                                    <span class="productPrice" id="product-price">{if $product->variant->compare_price > 0}<span class="discountPriceBProduct"><span class="tdlt c_f00">{$product->variant->compare_price|convert}</span><span class="rub onePx b mt-1 pr"><span class="onePx r_da pa">-</span>P</span>&nbsp;&nbsp;</span>{/if}<span class="price">{$product->variant->price|convert}</span> <span class="rub b mt-1 pr disp"><span class="r_das r_da pa">-</span>P</span></span><i></i></span>
                                                    <input type="hidden" value="{$product->variant->stock}" name="var_amount">
                            					{else}
                            						<span class="productPrice" id="product-price">{if $product->variant->compare_price > 0}<span class="discountPriceBProduct"><span class="tdlt c_f00">{$product->variant->compare_price|convert}</span><span class="rub onePx b mt-1 pr"><span class="onePx r_da pa">-</span>P</span>&nbsp;&nbsp;</span>{/if}<span class="price">{$product->variant->price|convert}</span> <span class="rub b mt-1 pr disp"><span class="r_das r_da pa">-</span>P</span></span><i></i></span>
                                                    <input type="hidden" value="{$product->variant->stock}" name="var_amount">
                            					{/if}
                            				{/if}
                                            {if $product->variants|count > 0}
                                                <div class="spinner-wrapper">
                                                   <input type="text" name="amount" value="1"/>
                                                   <a href="" class="spinner-plus">+</a>
                                                   <a href="" class="spinner-minus">-</a>
                                                </div>
                                                <strong>{$settings->units}.</strong>

                                            
                                            {/if}
                                            </td>
                                        </tr>               
                                        <tr>
                                            <td id="variants">
                                                <div {if !$empty_razmer}style="display:none;"{/if} >
                                                    <span>Размеры:</span>
                                                    {if $category->plitka}
                                                    <script type="text/javascript"></script>
                                                        {foreach $razmers_u as $k=>$v}
                                                            <label {if $v@first} class="first"{/if}>
                                                                <input type="radio" name="razmers" value="{$v}"{if $v@first} checked{/if} />
                                                           {$v}
                                                           </label>
                                                        {/foreach}
                                                    {else}
                                                        <select name="razmers">
                                                        <option value="0">Выберите размер</option>
                                                        {foreach $razmers_u as $k=>$v}   
                                                           <option value="{$v}">{$v}</option> 
                                                        {/foreach}
                                                        </select>   
                                                    {/if}
                                                </div>
                                            </td>
                                            <td class="delivery-cell ex-items">
                                                <a href="/dostavka-i-oplata">Доставка</a>
                                                <a href="/contact">Пункты самовывоза</a>
                                                <a href="" class="rasrochkaShow">Рассрочка</a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                {*<span class="compare_price">{$v->compare_price|convert}</span>*}
                                                {*<span class="price">{$v->price|convert}</span> <span class="currency">{$currency->sign|escape}</span></span>*}
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="choose-size">

                                                {foreach from=$category->path|@array_reverse item=cat}
                                                    {if $cat->podobrat!=''}
                                                    <a href="#" src="../files/categories/{$cat->podobrat}" h="{$cat->height}" w="{$cat->width}" class="podobrat_value">Как подобрать размер?</a>
                                                    {break}
                                                    {/if}
                                                {/foreach}
                                                
                                            </td>
                                        </tr>
                                        <!--<tr>
                                            <td>
                                                <span class="rasrochka">РАСРОЧКА</span>
                                            </td>
                                        </tr>-->
                                    </table>
                                    <input type="button" class="button" value="" style="display: none" />
                                    <div class="cl"></div>
                                    <a href="#" class="dataInProduct more_btn db b w30 h30 br3 db pa f16 lh38 min_btn w150 h40 mt10 trable1 button-cart-product" product="{$product->id}">В КОРЗИНУ</a>
                                    <input type="submit" class="more_btn db b w30 h30 br3 db pa f16 lh38 min_btn w150 h40 mt10 trable1 button-cart-product" style="display:none;"  data-result-text="добавлено" disabled="disabled" value="В корзину">
                                </form> 
                                <!-- Выбор варианта товара (The End) -->
                            
                            {/if}
                            <!--<div class="full-description">
                                {$product->annotation}
                            </div>-->
                            <div class="cl"></div>
                            <div class="cl"></div>
                                <!--{if $product->harakt}<a href="javascript:void(0)" class="link_harakt" rel="#harakt">Характеристики</a>{/if}-->
                        </div>                     
                        
                	
                                 
                                    
                                    
                           
                      <div class="cl"></div>
                    </div>
                    <div class="tabs-wrapper">
                         <ul>
                            {if $product->body}
                                <li class="{if $product->body}current-tab{/if}">Описание</li>
                            {/if}
                            {if $product->features || $product->harakt}
                                <li class="{if !$product->body}current-tab{/if}">Характеристики</li>
                            {/if}
                            <li class="{if !$product->body && !$product->features && !$product->harakt}current-tab{/if}">Отзывы</li>
                        </ul>
                        {if $product->body}
                            <div class="tab visible">
                                {$product->body}
                            </div>
                        {/if}
                        {if $product->features || $product->harakt}
                            <div class="tab{if !$product->body} visible{/if}">
                                <table class="features-table">
                                    {foreach $product->features as $f}
                                        <tr>
                                            <td>{$f->name}</td>
                                            <td>{$f->value}</td>
                                        </tr>
                                    {/foreach}
                                </table>
                                {if $product->harakt}
                                    <div>{$product->harakt}</div>
                                {/if}
                            </div>
                        {/if}
                        <div class="tab{if !$product->body && !$product->features && !$product->harakt} visible{/if}">
                            {foreach $comments as $comment}
                                <a name="comment_{$comment->id}"></a>
                                <div class="comment">
                                    <div class="comment-header">
                                        <span class="author-name">{$comment->name|escape} {if !$comment->approved}<b>(ожидает модерации)</b>{/if}</span>
                                        <span class="comment-date">{$comment->date|date}, {$comment->date|time}</span>
                                    </div>
                                    <div class="comment-text">
                                        {$comment->text|escape|nl2br}
                                    </div>
                                </div>
                            {/foreach}
                            <!--Форма отправления комментария-->
                            <div class="write-comment">
                                <form class="comment_form" method="post">
                                    <h2>Написать комментарий</h2>
                                    {if $error}
                                    <div class="message_error">
                                        {if $error=='captcha'}
                                        Неверно введена капча
                                        {elseif $error=='empty_comment'}
                                        Введите комментарий
                                        {elseif $error=='empty_name'}
                                        Неверно введена капча
                                        {/if}
                                    </div>
                                    {/if}
                                    <textarea class="comment_textarea" id="comment_text" name="text" data-format=".+" data-notice="Введите комментарий">{$comment_text}</textarea>
                                    <div class="user-info">
                                        <label for="comment_name">Имя</label>
                                        <input class="input_name" type="text" id="comment_name" name="name" value="{$comment_name}" data-format=".+" data-notice="Введите имя"/>
                                        <label for="comment_captcha">Капча</label>
                                        <div class="captcha">
                                            <img src="/captcha/image.php?{math equation='rand(10,10000)'}" alt='captcha'/>
                                            <input class="input_captcha" id="comment_captcha" type="text" name="captcha_code" value="" data-format="\d\d\d\d" data-notice="Введите капчу"/>
                                        </div> 
                                        <input class="button-send-comment" type="submit" name="comment" value="Отправить" />
                                    </div>
                                </form>
                            </div>
                            <!--Форма отправления комментария (The End)-->
                        </div>
                    </div>
                  <div class="tov_footer h45"></div>
                </div> 
                
                
               
               {if $related_products}
                <div class="div_leaders mb30"> 
                	<i class="nhjk">Также советуем:</i> 
                    	<a href="javascript:void(0)" class="leaf fl mt140 ml5 prev2 hidden" id="prev2" style="display: none;"></a>
                            <ul class="ul_leaders obs_cat" id="slider_1">
                                {assign var="stock" value=""}
                            {foreach $related_products as $related_product}
                            {foreach $related_product->variants as $v}
                            {$stock=$stock+$v}
                            {/foreach}
                           	 <li style="margin-right: 0px;{if $stock==0 && $related_product->pod_zakaz==0}display:none;{/if}"> 
                             	<a href="/{$related_product->cat_url}/u_{$related_product->url}"> 
                                	<span class="block_img"> 
                                        {if $related_product->imagesc}
                                                        <img src="/images1c/{$related_product->imagesc}" alt="{$product->name|escape}" style="display:block; margin:0 auto; max-height:140px;">
                                        {else}
                                    	       {if $related_product->image}
                                                <img src="{$related_product->image->filename|resize:190:140}" alt="{$product->name|escape}" style="display:block; margin:0 auto;">
                                                {else}
                                                <img src="/design/lidsport/images/defaultPhoto.png" alt="{$product->name|escape}" style="display:block; margin:0 auto;">
                                                {/if}
                                        {/if}
                                    </span> 
                                  </a> 
                                  <a href="/{$related_product->cat_url}/u_{$related_product->url}">
                                     <span class="product_name">{$related_product->name|escape}</span> 
                                  </a>
                                  <div class="rating" rel="{$related_product->product_id}">
                                    <span class="rater-starsOff"><span style="width:{$product->rating*80/5|string_format:"%.0f"}px" class="rater-starsOn"></span></span> <span class="rater-rating">{$product->rating|string_format:"%.1f"}</span>&#160;(<span class="rater-rateCount">{$product->votes|string_format:"%.0f"}</span> {$product->votes|plural:'голос':'голосов':'голоса'})
                                </div>
                                  <span class="db adgf"> 
                                  {if $related_product->variants|count < 2}
                          
                                    <!-- Выбор варианта товара -->
                                    <form class="variants" action="/cart">
                                         {foreach $related_product->variants as $v}
                                         {if $v->pod_zakaz==1}
                                         <div class="out-of-stock" style="margin-top: -22px;">
                                                    <span style="display: block;font-size: 17px;">Этот товар вы можете приобрести под заказ. Цену уточняйте по тел.:511-777</span>
                                                </div>
                                         {else}
                                         <input id="related_{$v->id}" name="variant" value="{$v->id}" type="radio" class="variant_radiobutton"  {if $v@first}checked{/if} {if $v|count<2} style="display:none;"{/if}/>
                                         <span class="relatedPrice fl " style=""><span class="relatedPrice fl mrgRight">{if $v->compare_price > 0}<span style="    margin-right: -30px;" class="discountPriceB"><span class="tdlt c_f00">{$v->compare_price|convert}</span><span class="rub b mt-1 pr"><span class="r_da pa">-</span>P</span>&nbsp;&nbsp;</span>{/if}{$v->price|convert} <span class="rub b mt-1 pr"><span class="r_da pa">-</span>P</span></span>
                                         <span style="position: relative;"> 
                                                <input type="submit" class="carts_b" data-result-text="добавлено"></input><span class="buyButton">КУПИТЬ</span></span>
                                       
                                        
                                        {/if}
                                        {/foreach}
                                        
                                    </form>
                                    <!-- Выбор варианта товара (The End) -->
                                    
                                    {elseif $related_product->variants|count >1}

                                    {foreach $related_product->variants as $v}
                                    {if $v@key==0}
                                    {if $v->pod_zakaz ==1}
                                         <div class="out-of-stock" style="margin-top: -22px;">
                                                    <span style="display: block;font-size: 17px;">Этот товар вы можете приобрести под заказ. Цену уточняйте по тел.:511-777</span>
                                                </div>
                                         {else}
                                         <input id="related_{$v->id}" name="variant" value="{$v->id}" type="radio" class="variant_radiobutton"  {if $v@first}checked{/if} {if $v|count<2} style="display:none;"{/if}/>
                                         <span class="relatedPrice fl" style=""><span class="relatedPrice fl mrgRight">{if $v->compare_price > 0}<span style="    margin-right: -30px;" class="discountPriceB"><span class="tdlt c_f00">{$v->compare_price|convert}</span><span class="rub b mt-1 pr"><span class="r_da pa">-</span>P</span>&nbsp;&nbsp;</span>{/if}{$v->price|convert} <span class="rub b mt-1 pr"><span class="r_da pa">-</span>P</span></span>
                                        <a href="/{$related_product->cat_url}/u_{$related_product->url}" style="position: relative;" class="data" product="{$related_product->id}">
                                    {/if}<input type="submit" class="carts_b" data-result-text="добавлено"></input><span class="aboutButton">КУПИТЬ</span></span>
                                     {/if}    
                                                
                                                {break}
                                                {/foreach}

                                    {/if}
                              	  </span> 
                              </li>
                              {/foreach}
                		  </ul>
                 	 </div>
  					<a href="javascript:void(0)" class="leaf2 mt140 mr5 next2 hidden" style="z-index: 1; display: none;" id="next2"></a>
                  <div class="hidden_line"></div>
                </div>
              {/if}
              <div class="cl"></div>



