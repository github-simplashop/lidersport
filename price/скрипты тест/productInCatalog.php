<?error_reporting(E_ALL ^ E_NOTICE);

chdir('../');
include('api/Simpla.php');
include('api/Colors.php');
//echo "start";
$sim = new Simpla();
$col = new Colors();
$productId = $_GET['productId'];
$plitka = '';
$sim->db->query('SELECT * FROM __variants WHERE product_id=?', $productId);
$variants = $sim->db->results();
$sim->db->query('SELECT category_id FROM __products_categories WHERE product_id=?', $productId);
$categoryId = $sim->db->result('category_id');
$sim->db->query('SELECT plitka FROM __categories WHERE id=?', $categoryId);
$plitka = $sim->db->result('plitka');
//$product = get_product($productId);
//$product = $sim->products->get_product((string)$productId);
		/*$product_id = $sim->db->results();
		foreach ($product_id as $key => $value) {
			$ids[] = $value->id;
			$names[] = $value->name;
		}
		$res = str_replace($names, $ids, $array);
		for ($i = 0; $i<count($res);$i++) {
			$res[$i]  = explode('@', $res[$i]);
		}
		/*?><pre><?print_r($ids);?><pre>
		<pre><?print_r($names);?><pre><??>
		<pre><?print_r($variants);?><pre>
		<pre><?print_r($productId);?><pre>
<?/*public function get_product($id)
	{
		if(is_int($id))
			$filter = $sim->db->placehold('p.id = ?', $id);
		else
			$filter = $sim->db->placehold('p.url = ?', $id);
			
		$query = $sim->db->placehold("SELECT DISTINCT
					p.id,
					p.url,
					p.brand_id,
					p.name,
					p.annotation,
					p.body,
					p.video,
					p.harakt,
					p.position,
					p.created as created,
					p.visible, 
					p.featured,
                    p.rating,
                    p.votes,
					p.content_title, 
					p.meta_title, 
					p.meta_keywords, 
					p.meta_description,
					p.images
				FROM __products AS p
                LEFT JOIN __brands b ON p.brand_id = b.id
                WHERE $filter
                GROUP BY p.id
                LIMIT 1", intval($id));
		$sim->db->query($query);
		$product = $sim->db->result();
		if ($product) {
			$variants = array();
			foreach($sim->variants->get_variants(array('product_id'=>$product->id, 'in_stock'=>true)) as $v)
				{$variants[$v->id] = $v;}
			
			$product->variants2 = $variants;
			
			 
			
			// Вариант по умолчанию
			if(($v_id = $sim->request->get('variant', 'integer'))>0 && isset($variants[$v_id]))
				$product->variant2 = $variants[$v_id];
			else
				$product->variant2 = reset($variants);
		}
		
		
		return $product;
	}*///парсим имя варианта чтобы вытянуть цвет и размеры
        $parsevariants = $variants;
        $cvet = array();
        $colors = array();
        $razmers = array();
        $color_u = array();
        $empty_color = '';
        $razmers_u = array();
        $empty_razmer = '';
        foreach($parsevariants as $pv){
        	if ($pv->stock):
            $cvet[$pv->id] = explode(' / ', $pv->name);
            $colors[$pv->id] = reset($cvet[$pv->id]);
            $razmers[$pv->id] = end($cvet[$pv->id]);
            //print_r($colors[$pv->id]);
            //print_r($razmers[$pv->id]);
            if($col->colors->check_color($razmers[$pv->id]))
               $razmers[$pv->id] = '';    
            
            $colormix[$pv->id] = $col->colors->toggle_color($colors[$pv->id]);
            if($colormix[$pv->id]->textura)
                $color[$pv->id] = $colormix[$pv->id]->textura;
            else 
                $color[$pv->id] = $colormix[$pv->id]->html1;
                endif;      
        }
        
        
        if($color){
            array_walk($color,'trim');
            $color_u = array_unique($color);
            $empty_color = array_values($color_u);
            
            if(!empty($empty_color[0])){ //если массив не пустой, Т.Е. есть хотя бы 1 значение
               // $col->design->assign('empty_color', $empty_color);   
            } 
        }
        if($razmers){
            //убираем пустые элементы
            array_walk($razmers,'trim');
            $razmers_u = array_unique($razmers);
            $razmers_u = array_diff($razmers_u, array(''));
            
            $empty_razmer = array_values($razmers_u);//переменная для определения присутствия размера
            
            
            if(!empty($empty_razmer[0])){   //если массив не пустой, Т.Е. есть хотя бы 1 значение
                //$col->design->assign('empty_razmer', $empty_razmer);
            }
        }?>
		<script>

                $('.variantsProduct').on('submit', function(e) {
                    e.preventDefault();

                    $.arcticmodal('close');

                    var form = $(this).closest('form'),
                        amount1 = Number(form.find('.number__value').html());


                    button = $(this).find('input[type="submit"]');

                    if ($(this).find('input[name=variant]:checked').size() > 0) {
                            variant = $(this).find('input[name=variant]:checked').val();
                    }

                    if ($(this).find('select[name=variant]').size() > 0) {
                        variant = $(this).find('select').val();
                    }

                    $.ajax({
                        url: "/ajax/cart.php",
                        data: {variant: variant,amount:amount1},
                        dataType: 'json',
                        success: function(data) {
                            $('#cart_informer').html(data);
                            if (button.attr('data-result-text')) {
                                button.val(button.attr('data-result-text'));
                            }
                            $('.p-add').arcticmodal();
                        }
                    });

                    var o1 = $(this).offset();
                    var o2 = $('#cart_informer').offset();
                    var dx = o1.left - o2.left;
                    var dy = o1.top - o2.top;
                    var distance = Math.sqrt(dx * dx + dy * dy);

                    $(this).closest('.product').find('.img img').effect("transfer", { to: $(".icons_cart"), className: "transfer_class" }, distance);
                    $('.transfer_class').html($(this).closest('.product').find('.img').html());
                    $('.transfer_class').find('img').css('height', '100%');

                    return false;
                });

		var amount = 1;
			var variantsProduct = [
				<?foreach ($variants as $v){?>
				{'id':'<?=$v->id?>','color':'<?=$color[$v->id]?>',  'razmer':'<?=$razmers[$v->id]?>',  'price':'<?=$v->price?>', 'compare_price':'<?=$v->compare_price?>', 'stock':'<?=$v->stock?>'},	
				<?}?> 
			];
			/*
			{foreach $product->variants as $v}
			console.log("id:'{$v->id} color:'{$color[$v->id]} 'razmer':'{$razmers[$v->id]}");
			{/foreach}
			{literal}*/
				function changeColorProduct(eventObject)
				{
					if($(eventObject).parent().hasClass('not_select')) {return true};
					if($(eventObject).parent().hasClass('active'))
					{
						$(eventObject).parent().removeClass('active');
					}
					else
					{
						$('#colorsWhereEver label').removeClass('active');
						$(eventObject).parent().addClass('active');
					}
					
					validateVariantProduct();
					
					if($('#variantsWhereEver label.active').length > 0)
					{
						return true
					}
					else
					{
						$('#variantsWhereEver option').hide();
						$('#variantsWhereEver option').eq(0).show();
						$('#variantsWhereEver label').addClass('not_select');
						$.each(variantsProduct, function(id, val){
							if(val.color==$(eventObject).val())
							{
								$('#variantsWhereEver label:contains('+val.razmer +')').removeClass('not_select').addClass('select');
								$('#variantsWhereEver option:contains('+val.razmer +')').show();
							}
						});
					}
					
					if($('#colorsWhereEver label.active').length <= 0)
					{
						$('#variantsWhereEver label').removeClass('not_select');
						$('#variantsWhereEver option').show();
					}
				}
				
				function changeVariantProduct(eventObject)
				{
					if($('#variantsWhereEver select').val() !== undefined)
					{
						$('#colorsWhereEver label').addClass('not_select');
						$.each(variantsProduct, function(id, val)
						{
							if(val.razmer==$('#variantsWhereEver input').val())
							{
								$('#colorsWhereEver label[rel="' + val.color + '"]').removeClass('not_select').addClass('select');
							}
							
							if(val.razmer==$(eventObject).val())
							{
								$('#colorsWhereEver label[rel="' + val.color + '"]').removeClass('not_select').addClass('select');
							}
							
						});
						
						if($(eventObject).val() == 0)
						{
							$('#colorsWhereEver label').removeClass('not_select');
						}
					}
					else
					{
						if($(eventObject).parent().hasClass('not_select')) return true;
						if($(eventObject).parent().hasClass('active'))
						{
							$(eventObject).parent().removeClass('active');
							$('#colorsWhereEver label').removeClass('not_select');
						}
						else
						{
							$('#variantsWhereEver label').removeClass('active');
							$(eventObject).parent().addClass('active');
							$('#colorsWhereEver label').addClass('not_select');
							$.each(variantsProduct, function(id, val)
							{
								if(val.razmer==$(eventObject).val())
								{
									$('#colorsWhereEver label[rel="' + val.color + '"]').removeClass('not_select').addClass('select');
								}
								
								if(val.razmer==$('#variantsWhereEver select').val())
								{
									$('#colorsWhereEver label[rel="' + val.color + '"]').removeClass('not_select').addClass('select');
								}
								
							});
						}
					}
					validateVariantProduct();
				}
			
			<?if ($empty_color || $empty_razmer):?>
				function validateVariantProduct()
				{
					// disabled
					$.each(variantsProduct, function(id, val)
					{
						if(<?if ($empty_razmer):?>val.razmer==$('#variantsWhereEver label.active input').val()<?endif;?> <?if ($empty_razmer && $empty_color):?>&&<?endif;?><?if ($empty_color):?>val.color==$('#colorsWhereEver label.active input').val()<?endif;?>)
						{
							/*var amount = $('input[name="amount"').val();
							if(amount > val.stock)
							{
								$('input[name="amount"').val(val.stock);
							}*/
							$('.removableVariant').remove();
							$('.subInCatalog').before('<input type="radio" checked="checked" name="variant" class="removableVariant" style="display: none;" value="' + val.id + '" var_amount="'+ val.stock +'">');
							$('.subInCatalog').removeAttr('disabled');
							$('.subInCatalog').removeClass('disabled');
							console.log("here1?");
							//$('.price,.product-price').text(val.price);// + " руб.");
							return false;
						}
						else if(<?if ($empty_razmer):?>val.razmer==$('#variantsWhereEver option:selected').val()<?endif;?> <?if ($empty_razmer && $empty_color):?>&&<?endif;?><?if ($empty_color):?>val.color==$('#colorsWhereEver label.active input').val()<?endif;?>)
						{
							/*var amount = $('input[name="amount"').val();
							if(amount > val.stock)
							{
								$('input[name="amount"').val(val.stock);
							}*/
							console.log("here2?");
							$('.removableVariant').remove();
							$('.subInCatalog').before('<input type="radio" checked="checked" name="variant" class="removableVariant" style="display: none;" data="'+ amount +'" value="' + val.id + '" var_amount="'+ val.stock +'">');
							$('.subInCatalog').removeAttr('disabled');
							$('.subInCatalog').removeClass('disabled');
							//$('.price,.product-price').text(val.price);// + " руб.");
							return false;
						}
						else
						{
								$('.subInCatalog').attr('disabled','disabled');
								$('.subInCatalog').addClass('disabled');
						}
					});
				}
			<?else:?>
				$(document).ready(function()
				{

					// disabled
					$.each(variantsProduct, function(id, val)
					{
                        /*var amount = $('input[name="amount"').val();
                        if(amount > val.stock)
						{
								$('input[name="amount"').val(val.stock);
						}*/
						$('.subInCatalog').before('<input type="radio" checked="checked" name="variant" class="removableVariant" style="display: none;" data="'+ amount +'" value="' + val.id + '"var_amount="'+ val.stock +'">');
						$('.subInCatalog').removeAttr('disabled');
						//$('.price,.product-price').text(val.price);// + " руб.");
						return false;
					});
				});
            
<?endif?>
            

            $(function() {
                $('#colorsWhereEver input').on('click', function(){   changeColorProduct(this); });
                $('#variantsWhereEver input').on('click', function(eventObject){ changeVariantProduct(this); });
                $('#variantsWhereEver select').on('change', function(eventObject){ changeVariantProduct(this); });
                //   changeColor();
//                    changeVariant($('[name=variant]:eq(0)'));
            });
            
//{* кнопки + и - *}            
           
        </script>
        <p class="card__caption">Выберите размер/вес</p>
         <form class="variantsProduct mb30">
         <?foreach ($color_u as $k=>$v):?> 
         <?endforeach;?>         
	        <table class="product-info">
	            <tr>
	                <td id="colorsWhereEver" >
	                    <div <?if (!$empty_color):?>style="display:none;"<?endif;?>>
	                        <!--закоментирован выбор цвета в попапе и добавлен скрытый инпут с выбранным цветом-->
	                    <!--<span >Цвет:</span>-->
	                    <!--<?foreach ($color_u as $k=>$v):?>-->
	                    <!--<?if (strpos($v, '.') !== false):?>-->
	                    <!--        <label rel="<?=$v;?>" style="background: url('../images/textures/<?=$v;?>') no-repeat; background-size: 100%;" class="select active">-->
	                    <!--            <input type="radio" value="<?=$v;?>" <?if ($v==$empty_color):?>checked<?endif;?> />-->

	                    <!--        </label>    -->
	                    <!-- <?else:?>-->
	                    <!--        <label rel="<?=$v;?>" style="background-color: <?=$v;?>; " <?if ($v==$empty_color):?>  class="first"<?endif;?>><input type="radio" name="color" value="<?=$v;?>"<?if ($v==$empty_color):?> checked<?endif;?> /></label>-->
	                     <!--<?endif;?>   -->
	                    <!--<?endforeach;?>-->
	                    <label rel="" style="background-color: ; display:none;" class="select active"><input type="radio" name="color" value=""></label>
	                    </div>
	                </td>
	            </tr>
	            <tr>
	                <td id="variantsWhereEver">
	                    <div <?if (!$empty_razmer):?>style="display:none;"<?endif;?>>
	                        <?if ($plitka):?>
	                            <? foreach ($razmers_u as $k=>$v):?>
	                                <label <?if ($v==$empty_razmer):?> class="first"<?endif;?>>
	                                    <input type="radio" name="razmers" value="<?=$v?>"<?if ($v==$empty_razmer):?>checked<?endif;?> />
	                               <?=$v?>
	                               </label>
	                            <?endforeach;?>
	                        <?else:?>
	                            <select name="razmers">
	                            <option value="0">Выбрать</option>
	                            <?foreach ($razmers_u as $k=>$v):?>   
	                               <option value="<?=$v?>"><?=$v?></option> 
	                            <?endforeach;?>
	                            </select>
	                        <?endif;?>
	                    </div>
	                </td>
	            </tr>
	           
	        </table>
	        <input type="button" class="button" value="" style="display: none" />
	        <div class="cl"></div>
	        <input type="submit" style="margin-left: 140px;position: static;" class="disabled more_btn db b w30 h30 br3 db pa f16 lh38 min_btn w150 h40 mt10 trable1 subInCatalog" data-result-text="добавлено" disabled="disabled" value="В корзину">
	    </form> 
	    <!-- Выбор варианта товара (The End) -->