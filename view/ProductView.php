<?PHP

/**
 *
 * Этот класс использует шаблон product.tpl
 *
 */
//ini_set('display_errors', true);

require_once('View.php');


class ProductView extends View
{

	function fetch()
	{   
		$product_url = $this->request->get('product_url', 'string');
		$image_first = '';
		$imagesc = '';
		$counter = 0;
		if(empty($product_url))
			return false;

		// Выбираем товар из базы
		$product = $this->products->get_product((string)$product_url);
        $product->min_price = 0;
        $product->equally_price = 0;
        $product->min_compare_price = 0;
        $product->equally_compare_price = 0;

        $product->min_price = $this->products->get_min_price($product->id);
        $product->min_compare_price = $this->products->get_min_compare_price($product->id);
        $product->equally_price = $this->products->get_equally_price($product->id);
        $product->equally_compare_price = $this->products->get_equally_compare_price($product->id);

		if(empty($product) || (!$product->visible && empty($_SESSION['admin'])))
			return false;
		// Изображения из выгрузки
		if (!empty($product->images)){
			
			$imagesc = "";
			$images = explode(",", $product->images);
			$path = "./images1c/";
			if (count($images)!=0){
				foreach ($images as $key => $value) {
					if (!file_exists($path.trim($value))){
					
						
   				    }
					else
					{
						$counter++;
						$imagesc[] =trim($value); 
					}
				}
			}
			

			$image_first = $imagesc[0];
		}
		$this->design->assign('image_first', $image_first);
        $this->design->assign('imagesc', $imagesc);
		if($counter ==0)
			{
				$product->images = $this->products->get_images(array('product_id'=>$product->id));
		    	$product->image = &$product->images[0];
			}
		$variants = array();//, 'in_stock'=>true
		foreach($this->variants->get_variants(array('product_id'=>$product->id)) as $v)
			$variants[$v->id] = $v;
		
		$product->variants = $variants;
		
        //парсим имя варианта чтобы вытянуть цвет и размеры
        $parsevariants = $product->variants;
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
            $empty_color = array_values($color_u);
            
            if(!empty($empty_color[0])){ //если массив не пустой, Т.Е. есть хотя бы 1 значение
                $this->design->assign('empty_color', $empty_color);   
            } 
        }
        if($razmers){
            //убираем пустые элементы
            array_walk($razmers,'trim');
            $razmers_u = array_unique($razmers);
            $razmers_u = array_diff($razmers_u, array(''));
            
            $empty_razmer = array_values($razmers_u);//переменная для определения присутствия размера
            
            
            if(!empty($empty_razmer[0])){   //если массив не пустой, Т.Е. есть хотя бы 1 значение
                $this->design->assign('empty_razmer', $empty_razmer);
            }
        }



        $this->design->assign('color_u', $color_u);
        $this->design->assign('color', $color);
        $this->design->assign('razmers', $razmers);
        $this->design->assign('razmers_u', $razmers_u);
        
		// Вариант по умолчанию
		if(($v_id = $this->request->get('variant', 'integer'))>0 && isset($variants[$v_id]))
			$product->variant = $variants[$v_id];
		else
			$product->variant = reset($variants);
					
		$product->features = $this->features->get_product_options(array('product_id'=>$product->id));
	
		// Автозаполнение имени для формы комментария
		if(!empty($this->user))
			$this->design->assign('comment_name', $this->user->name);

		// Принимаем комментарий
		if ($this->request->method('post') && $this->request->post('comment'))
		{
			$comment->name = $this->request->post('name');
            $comment->email = $this->request->post('email');
			$comment->text = $this->request->post('text');
			$comment->rating = $this->request->post('score');
			$captcha_code =  $this->request->post('captcha_code_review', 'string');
			
			// Передадим комментарий обратно в шаблон - при ошибке нужно будет заполнить форму
			$this->design->assign('comment_text', $comment->text);
			$this->design->assign('comment_name', $comment->name);
			$this->design->assign('comment_email', $comment->email);
			$this->design->assign('comment_rating', $comment->rating);

			// Проверяем капчу и заполнение формы
			if ($_SESSION['captcha_code_review'] != $captcha_code || empty($captcha_code))
			{
				$this->design->assign('error', 'captcha');
			}
			elseif (empty($comment->name))
			{
				$this->design->assign('error', 'empty_name');
			}
            elseif (empty($comment->email))
            {
                $this->design->assign('error', 'empty_email');
            }
			elseif (empty($comment->text))
			{
				$this->design->assign('error', 'empty_comment');
			}
			else
			{
				// Создаем комментарий
				$comment->object_id = $product->id;
				$comment->type      = 'product';
				$comment->ip        = $_SERVER['REMOTE_ADDR'];
				$comment->object_sku = $product->external_id;

				// Если были одобренные комментарии от текущего ip, одобряем сразу
				//$this->db->query("SELECT 1 FROM __comments WHERE approved=1 AND ip=? LIMIT 1", $comment->ip);
				//if($this->db->num_rows()>0)
					$comment->approved = 0;
				
				// Добавляем комментарий в базу
				$comment_id = $this->comments->add_comment($comment);
				
				// Отправляем email
				$this->notify->email_comment_admin($comment_id);				
				
				// Приберем сохраненную капчу, иначе можно отключить загрузку рисунков и постить старую
				unset($_SESSION['captcha_code']);
				header('location: '.$_SERVER['REQUEST_URI'].'#comment_'.$comment_id);
			}			
		}
		
		// Комментарии к товару
		$comments = $this->comments->get_comments(array('type'=>'product', 'object_id'=>$product->id, 'approved'=>1, 'ip'=>$_SERVER['REMOTE_ADDR']));
		$this->design->assign('comments', $comments);
		
		
		// Связанные товары
		$related_ids = array();
		$related_products = array();
		$related_images = array();
		foreach($this->products->get_related_products($product->id) as $p)
		{
			$related_ids[] = $p->related_id;
			$related_products[$p->related_id] = null;
		}
		if(!empty($related_ids))//,'in_stock'=>true
		{
			foreach($this->products->get_products(array('id'=>$related_ids, 'visible'=>1, 'in_stock'=>true)) as $p)
			{
				$related_products[$p->id] = $p;
				if (!empty($p->imagesc)){
				$imagesRelated = explode(",", $p->imagesc);
				$p->imagesc = $imagesRelated[0];
				}
			}
			$related_products_images = $this->products->get_images(array('product_id'=>array_keys($related_products)));
			foreach($related_products_images as $related_product_image)
				if(isset($related_products[$related_product_image->product_id]))//, 'in_stock'=>true
					$related_products[$related_product_image->product_id]->images[] = $related_product_image;
			$related_products_variants = $this->variants->get_variants(array('product_id'=>array_keys($related_products), 'in_stock'=>true));
			foreach($related_products_variants as $related_product_variant)
			{
					if(isset($related_products[$related_product_variant->product_id]))
					{	
						$related_products[$related_product_variant->product_id]->variants[] = $related_product_variant;
					}
			}
			  
			foreach($related_products as $id=>$r)
			{
				if(is_object($r))
				{
					$r->image = &$r->images[0];
					$r->variant = &$r->variants[0];
				}
				else
				{
					unset($related_products[$id]);
				}
			}
			
			$this->design->assign('related_products', $related_products);
		}

		// Отзывы о товаре
		$comments = $this->comments->get_comments(array('type'=>'product', 'object_id'=>$product->id, 'approved'=>1, 'ip'=>$_SERVER['REMOTE_ADDR']));
		
		// Соседние товары
		// если соседних нет, то нужно найти что то другое
		$next_product = $this->products->get_next_product($product->id);
		if ($next_product) {}
		else $next_product = $this->products->get_next_product($product->id+1);
		$this->design->assign('next_product', $next_product);
		$this->design->assign('next_product2', $this->products->get_next_product($next_product->id));
		
		
		
		
			
			
		$prev_product = $this->products->get_prev_product($product->id);
		if ($prev_product) {}
		else $prev_product = $this->products->get_prev_product($product->id-1);
		$this->design->assign('prev_product', $prev_product);
		$this->design->assign('prev_product2', $this->products->get_prev_product($prev_product->id));
		
                
                // Теги
                $product->tags = $this->products->get_tags(array('object_id'=>$product->id, 'type' => 'product'));

		// Правим таблицу характеристики
		
		if ($product->harakt)
		{
			$docuent = $product->harakt;
			
			$docuent = str_ireplace('class="left"',"",$docuent);
			$docuent = str_ireplace('class="center"',"",$docuent);
			$docuent = str_ireplace('align="left"',"",$docuent);
			
			// echo "<textarea>$docuent</textarea>";
			$docuent = strip_tags($docuent, '<table><tr><th><td><br><br/>');
			$docuent = preg_replace("/<table[^>]*>/", "<table>", $docuent);
			$docuent = preg_replace("/<tr[^>]*>/", "<tr>", $docuent);
			// $docuent = preg_replace("/<td[^>]*>/", "<td>", $docuent);
			
			$ex = explode("<table>",$docuent);
			$ex3 = explode("</table>",$ex[0]);
			// $ex3[0] = strip_tags($ex3[0], '<table><tr><th><td><br><br/><tbody>');
			$product->harakt = "<table class='table table-hover'>$ex3[0]</table>";
		}
	
        $product->votes = ($product->votes > 0)? $product->votes : 7;
        $product->rating = ($product->rating > 0)? $product->rating : 4;
		// И передаем его в шаблон
		$this->design->assign('product', $product);
		
		$this->design->assign('comments', $comments);
		
		// Категория и бренд товара
		$product->categories = $this->categories->get_categories(array('product_id'=>$product->id));
		$this->design->assign('brand', $this->brands->get_brand(intval($product->brand_id)));		
		$this->design->assign('category', reset($product->categories));		
		

		// Добавление в историю просмотров товаров
		$max_visited_products = 100; // Максимальное число хранимых товаров в истории
		$expire = time()+60*60*24*30; // Время жизни - 30 дней
		if(!empty($_COOKIE['browsed_products']))
		{
			$browsed_products = explode(',', $_COOKIE['browsed_products']);
			// Удалим текущий товар, если он был
			if(($exists = array_search($product->id, $browsed_products)) !== false)
				unset($browsed_products[$exists]);
		}
		// Добавим текущий товар
		$browsed_products[] = $product->id;
		$cookie_val = implode(',', array_slice($browsed_products, -$max_visited_products, $max_visited_products));
		setcookie("browsed_products", $cookie_val, $expire, "/");
		
		$this->design->assign('ocenk', rand(4,5));
// 		$this->design->assign('meta_title', $product->meta_title);    эта строка берет значение из столбца meta_title в базе данных, изменил на name для правильных титлов и дискрипшн ибо meta_title в базе с лишними категориями
		$this->design->assign('meta_title', $product->name);
		$this->design->assign('meta_keywords', $product->meta_keywords);
		$this->design->assign('meta_description', $product->meta_description);
		
		return $this->design->fetch('product.tpl');
	}
	


}
