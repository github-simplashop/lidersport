<?PHP

require_once('View.php');

class ProductsView extends View
{
    /* chpu_filter */
    private $meta_array = array();
    private $set_canonical = false;
    private $meta = array('h1'=>'','title'=>'','keywords'=>'','description'=>'');
    private $meta_delimiter = ', ';

    public function __construct()
    {
        parent::__construct();

        /**
         *
         * внешний вид параметров:
         * brand=brandUrl1_brandUrl2... - фильтр по брендам
         * paramUrl=paramValue1_paramValue2... - фильтр по мультисвойствам
         * page=pageNumber - постраничная навигация
         * sort=sortParam - параметры сортировки
         *
         */

        //определение текущего положения и выставленных параметров
        $uri = @parse_url($_SERVER["REQUEST_URI"]);
        //убираем модификатор каталога
        $uri = preg_replace("~/?catalog/~",'',$uri['path']);
        $uri_array = explode('/',$uri);
        array_shift($uri_array);
        foreach($uri_array as $k=>$v){
            if(empty($v)) continue;
            if(!$k && $brand=$this->brands->get_brand((string)$v)){
                $_GET['brand'] = $brand->url;
            }else{
                list($param_name, $param_values) = explode('=',$v);
                switch($param_name){
                    case 'brand':
                        foreach(explode('_',$param_values) as $bv)
                            if($brand = $this->brands->get_brand((string)$bv)){
                                $_GET['b'][] = $brand->id;
                                $this->meta_array['brand'][] = 'Бренд '. $brand->name;
                            }
                        break;
                    case 'price-min':
                        $_GET['p']['min'] = $this->chpu_deconvert($param_values);
                        break;
                    case 'price-max':
                        $_GET['p']['max'] = $this->chpu_deconvert($param_values);
                        break;
                    case 'page':
                        $_GET['page'] = $param_values;
                        break;
                    case 'sort':
                        $_GET['sort'] = strval($param_values);
                        break;
                    default:
                        if($feature = $this->features->get_feature($param_name)){
                            $_GET[$feature->id] = explode('_',$param_values);
                            foreach($this->features->get_options(array('feature_id'=>$feature->id,'features'=>$_GET[$feature->id])) as $fo){
                                if(in_array($fo->translit,$_GET[$feature->id])){
                                    $this->meta_array['options'][$feature->id][] = $feature->name . ' '. $fo->value;
                                }
                            }
                        }
                }
            }
        }

        if(!empty($this->meta_array)){
            foreach($this->meta_array as $type=>$_meta_array){
                switch($type){
                    case 'brand':
                        if(count($_meta_array) > 0)
                            $this->set_canonical = true;
                        $this->meta['h1'] = $this->meta['title'] = $this->meta['keywords'] = $this->meta['description'] = implode($this->meta_delimiter,$_meta_array);
                        break;
                    case 'options':
                        foreach($_meta_array as $f_id=>$f_array){
                            if(count($f_array) > 0)
                                $this->set_canonical = true;
                            $this->meta['h1']           .= (!empty($this->meta['h1'])           ? $this->meta_delimiter : '') . implode($this->meta_delimiter,$f_array);
                            $this->meta['title']        .= (!empty($this->meta['title'])        ? $this->meta_delimiter : '') . implode($this->meta_delimiter,$f_array);
                            $this->meta['keywords']     .= (!empty($this->meta['keywords'])     ? $this->meta_delimiter : '') . implode($this->meta_delimiter,$f_array);
                            $this->meta['description']  .= (!empty($this->meta['description'])  ? $this->meta_delimiter : '') . implode($this->meta_delimiter,$f_array);
                        }
                        break;
                }
            }
        }

        if(!empty($this->meta['h1']))
            $this->meta['h1']           = ' c характеристиками ' . $this->meta['h1']          . ' в магазине ' . $this->settings->site_name;
        if(!empty($this->meta['title']))
            $this->meta['title']        = ' c характеристиками ' . $this->meta['title']       . ' в магазине ' . $this->settings->site_name;
        if(!empty($this->meta['keywords']))
            $this->meta['keywords']     = ' c характеристиками ' . $this->meta['keywords']    . ' в магазине ' . $this->settings->site_name;
        if(!empty($this->meta['description']))
            $this->meta['description']  = ' c характеристиками ' . $this->meta['description'] . ' в магазине ' . $this->settings->site_name;

        //if($this->set_canonical)
        //$this->meta['h1'] = $this->meta['title'] = $this->meta['keywords'] = $this->meta['description'] = '';

        $this->design->assign('set_canonical',$this->set_canonical);
        $this->design->assign('filter_meta',(object)$this->meta);

        $this->design->smarty->registerPlugin('function', 'furl', array($this, 'filter_chpu_url'));
        $this->design->smarty->registerPlugin('modifier', 'fconvert', array($this, 'chpu_convert'));

    }
    public function filter_chpu_url($params)
    {
        if(is_array(reset($params)))
            $params = reset($params);

        $result_array = array('brand'=>array(),'features'=>array(),'sort'=>null,'page'=>null);
        //Определяем, что у нас уже есть в строке
        $uri = @parse_url($_SERVER["REQUEST_URI"]);
        $uri = preg_replace("~/?catalog/~",'',$uri['path']);
        $uri_array = explode('/',$uri);
        array_shift($uri_array);
        foreach($uri_array as $k=>$v){
            if($k>0 || !($brand=$this->brands->get_brand((string)$v))){
                list($param_name, $param_values) = explode('=',$v);
                switch($param_name){
                    case 'brand':
                        $result_array['brand'] = explode('_',$param_values);
                        break;
                    case 'price-min':
                        $result_array['price-min'] = $param_values;
                        break;
                    case 'price-max':
                        $result_array['price-max'] = $param_values;
                        break;
                    case 'sort':
                        $result_array['sort'] = strval($param_values);
                        break;
                    case 'page':
                        $result_array['page'] = $param_values;
                        break;
                    default:
                        $result_array['features'][$param_name] = explode('_',$param_values);
                }
            }
        }
        //Определяем переданные параметры для ссылки
        foreach($params as $k=>$v){
            switch($k){
                case 'brand':
                    if(is_null($v))
                        unset($result_array['brand']);
                    elseif(in_array($v,$result_array['brand']))
                        unset($result_array['brand'][array_search($v,$result_array['brand'])]);
                    else
                        $result_array['brand'][] = $v;
                    break;
                case 'price-min':
                    $result_array['price-min'] = $v;
                    break;
                case 'price-max':
                    $result_array['price-max'] = $v;
                    break;
                case 'sort':
                    $result_array['sort'] = strval($v);
                    break;
                case 'page':
                    $result_array['page'] = $v;
                    break;
                default:
                    if(is_null($v))
                        unset($result_array['features'][$k]);
                    elseif(!empty($result_array['features']) && in_array($k,array_keys($result_array['features'])) && in_array($v,$result_array['features'][$k]))
                        unset($result_array['features'][$k][array_search($v,$result_array['features'][$k])]);
                    else
                        $result_array['features'][$k][] = $v;
                    break;
            }
        }
        //формируем ссылку
        //$result_string = '/catalog';
        $result_string = '';
        if(!empty($_GET['category']))
            $result_string .= '/' . $_GET['category'];
        if(!empty($_GET['brand']))
            $result_string .= '/' . $_GET['brand'];

        if(!empty($result_array['brand']))
            $result_string .= '/brand=' . implode('_',$this->filter_chpu_sort_brands($result_array['brand'])); // - это с сортировкой по брендам
        //$result_string .= '/brand=' . implode('_',$result_array['brand']); // - это без сортировки по брендам
        foreach($result_array['features'] as $k=>$v){
            if(empty($result_array['features'][$k]))
                unset($result_array['features'][$k]);
        }
        if(!empty($result_array['features']))
            $result_string .= $this->filter_chpu_sort_features($result_array['features']);
        if(!empty($result_array['price-min']))
            $result_string .= '/price-min=' . $result_array['price-min'];
        if(!empty($result_array['price-max']))
            $result_string .= '/price-max=' . $result_array['price-max'];
        if(!empty($result_array['sort']))
            $result_string .= '/sort=' . $result_array['sort'];
        if($result_array['page'] > 1 || $result_array['page'] == 'all')
            $result_string .= '/page=' . $result_array['page'];
        //отдаем сформированную ссылку
        return $result_string;
    }
    private function filter_chpu_sort_brands($brands_urls = array()){
        if(empty($brands_urls))
            return false;
        $this->db->query("SELECT url FROM __brands WHERE url in(?@) ORDER BY name", (array)$brands_urls);
        return $this->db->results('url');
    }
    private function filter_chpu_sort_features($features = array()){
        if(empty($features))
            return false;
        $this->db->query("SELECT url FROM __features WHERE url in(?@) ORDER BY position", (array)array_keys($features));
        $result_string = '';
        foreach($this->db->results('url') as $v){
            if(in_array($v,array_keys($features))){
                $result_string .= '/' . $v . '=' . implode('_',$features[$v]);
            }
        }
        return $result_string;
    }
    // В случае с переключением валют нужно выполнять махинации с ценой
    public function chpu_convert($price){
        $currency = $this->currency;
        $result = $price;
        if(!empty($currency)){
            // Умножим на курс валюты
            $result = $result*$currency->rate_from/$currency->rate_to;
            // Точность отображения, знаков после запятой
            $precision = isset($currency->cents)?$currency->cents:2;
        }
        return round($result, $precision);
    }
    private function chpu_deconvert($price){
        $currency = $this->currency;
        $main_currency = current($this->money->get_currencies());
        $result = $price;
        if(!empty($currency)){
            // Умножим на курс валюты
            $result = $result*$currency->rate_to/$currency->rate_from;
            // Точность отображения, знаков после запятой
            $precision = isset($main_currency->cents)?$main_currency->cents:2;
        }
        return round($result, $precision);
    }
    /* chpu_filter /*/

    /**
	 *
	 * Отображение списка товаров
	 *
	 */	
	function fetch()
	{
		// GET-Параметры
		$category_url = $this->request->get('category', 'string');
		$brand_url    = $this->request->get('brand', 'string');
		
		$filter = array();
		$filter['visible'] = 1;	
		$filter['in_stock'] = 1;

		// Если задан бренд, выберем его из базы
        /* chpu_filter */
        $prices = array();
        $prices['current'] = $this->request->get('p');
        if (!empty($prices['current']['min']) || !empty($prices['current']['max']))
            $filter['price'] = $prices['current'];
        else
            unset($prices['current']);

        if ($val = $this->request->get('b'))
            $filter['brand_id'] = $val;
        else/* chpu_filter /*/if (!empty($brand_url))
		{
			$brand = $this->brands->get_brand((string)$brand_url);
			if (empty($brand))
				return false;
			$this->design->assign('brand', $brand);
			$filter['brand_id'] = $brand->id;
		}
		
		// Выберем текущую категорию
		if (!empty($category_url))
		{
			$category = $this->categories->get_category((string)$category_url);
			if (empty($category) || (!$category->visible && empty($_SESSION['admin'])))
				return false;
			$this->design->assign('category', $category);
			$filter['category_id'] = $category->children;
		}

		// Если задано ключевое слово
		$keyword = $this->request->get('keyword');
		if (!empty($keyword))
		{
			$this->design->assign('keyword', $keyword);
			$filter['keyword'] = $keyword;
		}

		// Сортировка товаров
        if ($sort = $this->request->get('sort', 'string')) {
            if (!empty($sort)) {
                $filter['sort'] = $sort;
            } else {
                $filter['sort'] = 'name';
            }
        } else {
            $filter['sort'] = 'name';
        }

		$this->design->assign('sort', $filter['sort']);
		
		// Свойства товаров
		if(!empty($category))
		{
			$features = array();
            $filter['features'] = array();

			foreach($this->features->get_features(array('category_id'=>$category->id, 'in_filter'=>1)) as $feature)
			{
				$features[$feature->id] = $feature;
                if($val = $this->request->get($feature->id)) {
                    $filter['features'][$feature->id] = $val;
                }
			}
			
			$options_filter['visible'] = 1;
			
			$features_ids = array_keys($features);
			if(!empty($features_ids))
				$options_filter['feature_id'] = $features_ids;
			$options_filter['category_id'] = $category->children;
			if(isset($filter['features']))
				$options_filter['features'] = $filter['features'];
			if(!empty($brand))
				$options_filter['brand_id'] = $brand->id;
            /* chpu_filter_extended */
            elseif($filter['brand_id'])
                $options_filter['brand_id'] = $filter['brand_id'];
            /* chpu_filter_extended /*/

			$options = $this->features->get_options($options_filter);

			foreach($options as $option)
			{
				if(isset($features[$option->feature_id]))
					$features[$option->feature_id]->options[] = $option;
			}
			
			foreach($features as $i=>&$feature)
			{ 
				if(empty($feature->options))
					unset($features[$i]);
			}

                        $category->tags = $this->categories->get_tags(array('object_id'=>$category->id, 'type' => 'categori'));
                        
			$this->design->assign('features', $features);
            $this->design->assign('filter_features', $filter['features']);
            $this->design->smarty->registerPlugin('function', 'url_features', array($this, 'url_features'));
 		}

		// Постраничная навигация
		$items_per_page = $this->settings->products_num;		
		// Текущая страница в постраничном выводе
		$current_page = $this->request->get('page', 'int');	
		// Если не задана, то равна 1
		$current_page = max(1, $current_page);
		$this->design->assign('current_page_num', $current_page);
		// Вычисляем количество страниц
		$products_count = $this->products->count_products($filter);
		
		// Показать все страницы сразу
		if($this->request->get('page') == 'all')
			$items_per_page = $products_count;	
		
		$pages_num = ceil($products_count/$items_per_page);
		$this->design->assign('total_pages_num', $pages_num);

		$filter['page'] = $current_page;
		$filter['limit'] = $items_per_page;
		
		///////////////////////////////////////////////
		// Постраничная навигация END
		///////////////////////////////////////////////
		

		$discount = 0;
		if(isset($_SESSION['user_id']) && $user = $this->users->get_user(intval($_SESSION['user_id'])))
			$discount = $user->discount;
			
		// Товары 
		$products = array();
		foreach($this->products->get_products($filter) as $p)
		{
			$products[$p->id] = $p;
			$products[$p->id]->features = $this->features->get_product_options(array('product_id'=>$p->id));
		}
		// Если искали товар и найден ровно один - перенаправляем на него
		if(!empty($keyword) && $products_count == 1)
			header('Location: '.$this->config->root_url.'/products/'.$p->url);
		
		if(!empty($products))
		{
			$products_ids = array_keys($products);
			foreach($products as &$product)
			{
				$product->variants = array();
				$product->images = array();
				$product->properties = array();
				
				// Правим таблицу характеристики
				$docuent = $product->harakt;
				if ($docuent)
				{
					$docuent = preg_replace("/<table[^>]*>/", "<table>", $docuent);
					$docuent = preg_replace("/<tr[^>]*>/", "<li>", $docuent);
					$docuent = preg_replace("/<\/td>[^>]*<td[^>]*>/", ": ", $docuent);
					$docuent = str_ireplace("</tr>","",$docuent);
					$docuent = str_ireplace("</th>","",$docuent);
					
					$ex = explode("<table>",$docuent);
					$ex3 = explode("</table>",$ex[1]);
					
						$ex3[0] = strip_tags($ex3[0], '<br><br/><li>');
						if (strlen($ex3[0])>10)
						{
							$product->harakt = "<ul class='details'>$ex3[0]</ul>";
						}
				}
			}
	
			$variants = $this->variants->get_variants(array('product_id'=>$products_ids, 'in_stock'=>true));
			
			foreach($variants as &$variant)
			{
				//$variant->price *= (100-$discount)/100;
				$products[$variant->product_id]->variants[] = $variant;
				//парсим имя варианта чтобы вытянуть цвет и размеры
			       /* $parsevariants = $product->variants;
			        foreach($parsevariants as $pv){
			            $cvet[$pv->id] = explode(' / ', $pv->name);
			            $colors[$pv->id] = reset($cvet[$pv->id]);
			            $razmers[$pv->id] = end($cvet[$pv->id]);
			            //print_r($colors[$pv->id]);
			            //print_r($razmers[$pv->id]);
			            if($this->colors->check_color($razmers[$pv->id]))
			               $razmers[$pv->id] = '';     
			            
			            $colormix[$pv->id] = $this->colors->toggle_color($colors[$pv->id]);
			            if($colormix[$pv->id]->textura)
			                $color[$pv->id] = $colormix[$pv->id]->textura;
			            else 
			                $color[$pv->id] = $colormix[$pv->id]->html1;       
			        }
			        
			        
			        if($color){
			            array_walk($color,'trim');
			            $color_u = array_unique($color);
			            $color_u = array_diff($color_u, array(''));
			            $empty_color = array_values($color_u);
			            
			            if(!empty($empty_color[0])){ //если массив не пустой, Т.Е. есть хотя бы 1 значение
			                $product->emptyColor = $empty_color;   
			            } 
			            $product->color=$color_u;
			        }
			        if($razmers){
			            //убираем пустые элементы
			            array_walk($razmers,'trim');
			            $razmers_u = array_unique($razmers);
			            $razmers_u = array_diff($razmers_u, array(''));
			            
			            $empty_razmer = array_values($razmers_u);//переменная для определения присутствия размера
			            
			            
			            if(!empty($empty_razmer[0])){   //если массив не пустой, Т.Е. есть хотя бы 1 значение
			                $product->emptyRazmer = $empty_razmer; 
			            }
			            $product->razmers=$razmers_u;
			        }*/
			}
			
			$images = $this->products->get_images(array('product_id'=>$products_ids));
			foreach($images as $image)
				$products[$image->product_id]->images[] = $image;

			foreach($products as &$product)
			{



				if(isset($product->variants[0]))
					$product->variant = $product->variants[0];
				if(isset($product->images[0]))
					$product->image = $product->images[0];
				
				$product->min_price = 0;
                $product->equally_price = 0;
                $product->min_compare_price = 0;
                $product->equally_compare_price = 0;

				$product->min_price = $this->products->get_min_price($product->id);
				$product->min_compare_price = $this->products->get_min_compare_price($product->id);
				$product->equally_price = $this->products->get_equally_price($product->id);
                $product->equally_compare_price = $this->products->get_equally_compare_price($product->id);

                //Назначаем рейтинг если его нет
                $product->votes = ($product->votes > 0)? $product->votes : 7;
                $product->rating = ($product->rating > 0)? $product->rating : 4;
			}
				
				

			        /*$this->design->assign('color_u', $color_u);
			        $this->design->assign('color', $color);
			        $this->design->assign('razmers', $razmers);
			        $this->design->assign('razmers_u', $razmers_u);	*/
	
			/*
			$properties = $this->features->get_options(array('product_id'=>$products_ids));
			foreach($properties as $property)
				$products[$property->product_id]->options[] = $property;
			*/
            
			$this->design->assign('products', $products);
 		}

 		unset($filter['price']);
		unset($filter['limit']);

        foreach ($this->products->get_products($filter) as $p) {
            $products_prices[$p->id] = $p;
        }

		if(!empty($products_prices))
		{
			$prices_products_ids = array_keys($products_prices);
			$prices_variants = $this->variants->get_variants(array('product_id'=>$prices_products_ids));
			foreach($prices_variants as &$prices_variant)
				$prices[] = $prices_variant->price;
		}
		
		// Выбираем бренды, они нужны нам в шаблоне	
		if(!empty($category))
		{
			$brands = $this->brands->get_brands(array('category_id'=>$category->children));
			$category->brands = $brands;		
		}
        /* chpu_filter */
        if(isset($prices['current']))
            $prices['current'] = (object)$prices['current'];
        $prices = (object)$prices;
        $range_filter = $filter;
        $range_filter['get_price'] = 1;
        $prices->range = $this->products->count_products($range_filter);
        $this->design->assign('prices', $prices);

        /*if($this->request->get('ajax','boolean')){
            $this->design->assign('ajax', 1);
            $result = new StdClass;
            $result->products_content = $this->design->fetch('products_content.tpl');
            $result->products_pagination = $this->design->fetch('chpu_pagination.tpl');
            print json_encode($result);
            die;
        }*/
        /* chpu_filter /*/

		// Устанавливаем мета-теги в зависимости от запроса
		if($this->page)
		{
			$this->design->assign('meta_title', $this->page->meta_title);
			$this->design->assign('meta_keywords', $this->page->meta_keywords);
			$this->design->assign('meta_description', $this->page->meta_description);
		}
		elseif(isset($category))
		{
			$this->design->assign('meta_title', $category->meta_title);
			$this->design->assign('meta_keywords', $category->meta_keywords);
			$this->design->assign('meta_description', $category->meta_description);
		}
		elseif(isset($brand))
		{
			$this->design->assign('meta_title', $brand->meta_title);
			$this->design->assign('meta_keywords', $brand->meta_keywords);
			$this->design->assign('meta_description', $brand->meta_description);
		}
		elseif(isset($keyword))
		{
			$this->design->assign('meta_title', $keyword);
		}
		
			
		$this->body = $this->design->fetch('products.tpl');
		return $this->body;
	}

    public function url_features($params)

    {
        if(is_array(reset($params)))

            return $this->request->url(reset($params));

        else

            return $this->request->url($params);

    }

}
