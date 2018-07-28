<?php

/**
 * Simpla CMS
 *
 * @copyright 	2015 iGenius
 *
 * Этот класс использует шаблон stock.tpl
 *
 */
 
require_once('View.php');

class StockView extends View
{
 	/**
	 *
	 * Отображение списка новостей
	 *
	 */	
	function fetch()
	{
		
		$filter = array();
		$filter['visible'] = 1;
        $filter['pr_as_news'] = 0;
        $filter['pr_as_slider'] = 0;
        $filter['like_stock'] = 1;
        
        $url = $this->request->get('url');

		if($url == ''){
        
            // Постраничная навигация
    		$items_per_page = 6;
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
    		$this->design->assign('total_products_num', $products_count);
    
    		$filter['page'] = $current_page;
    		$filter['limit'] = $items_per_page;
            $filter['sort'] = 'created';
    		
    		///////////////////////////////////////////////
    		// Постраничная навигация END
    		///////////////////////////////////////////////
    			
    		// Новости 
    		$products = array();
    		foreach($this->products->get_products($filter) as $p)
    			$products[$p->id] = $p;
    		
    		if(!empty($products))
    		{
    			$products_ids = array_keys($products);
    			foreach($products as &$product)
    			{
    				$product->images = array();
    			}
                
    			$images = $this->products->get_images(array('product_id'=>$products_ids));
    			foreach($images as $image)
    				$products[$image->product_id]->images[] = $image;
                    
    			foreach($products as &$product)
    			{
    				if(isset($product->images[0]))
    					$product->image = $product->images[0];
    			}
    
    			$this->design->assign('products', $products);
     		}
    		
    		// Устанавливаем мета-теги в зависимости от запроса
            
            $this->design->assign('meta_title', 'Акции компании');
    		
    		$this->body = $this->design->fetch('stock.tpl');
    		return $this->body;
            
        }else{
            
            $stock = $temp = array();
            
            $temp = $this->products->get_product($url);
            
            $stock['body'] = $temp->body;
            $stock['url'] = $temp->url;
            $stock['name'] = $temp->name;
            $stock['annotation'] = $temp->annotation;
            $stock['created'] = $temp->created;
            $stock['meta_title'] = $temp->meta_title;
            $stock['meta_keywords'] = $temp->meta_keywords;
            $stock['meta_description'] = $temp->meta_description;
            $stock['image'] = (array)$this->products->get_images(array('product_id'=>$temp->id));
            $stock['image'] = (object)$stock['image'][0];
            
            $this->design->assign('stock', $stock);
            
            $this->design->assign('meta_title', $temp->meta_title);
            $this->design->assign('meta_keywords', $temp->meta_keywords);
            $this->design->assign('meta_description', $temp->meta_description);
    		
    		$this->body = $this->design->fetch('stock_detail.tpl');
    		return $this->body;
            
    
            
            
            
        }
	}
}
