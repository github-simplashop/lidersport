<?php

require_once('api/Simpla.php');


############################################
# Class Category - Edit the good gategory
############################################
class CategoryAdmin extends Simpla
{
  private	$allowed_image_extentions = array('png', 'gif', 'jpg', 'jpeg', 'ico');
  
  function fetch()
  {
		if($this->request->method('post'))
		{
			$category->id = $this->request->post('id', 'integer');
			$category->parent_id = $this->request->post('parent_id', 'integer');
			$category->name = $this->request->post('name');
			$category->visible = $this->request->post('visible', 'boolean');
            $category->plitka = $this->request->post('plitka', 'boolean');
			$category->url = $this->request->post('url', 'string');
			$category->meta_title = $this->request->post('meta_title');
			$category->meta_keywords = $this->request->post('meta_keywords');
			$category->meta_description = $this->request->post('meta_description');
			$category->content_title = $this->request->post('content_title');
			
			
			$category->description = $this->request->post('description');

			// Не допустить одинаковые URL разделов.
			if(($c = $this->categories->get_category($category->url)) && $c->id!=$category->id)
			{			
				$this->design->assign('message_error', 'url_exists');
			}
			else
			{
				if(empty($category->id))
				{
	  				$category->id = $this->categories->add_category($category);
					$this->design->assign('message_success', 'added');
	  			}
  	    		else
  	    		{
  	    			$this->categories->update_category($category->id, $category);
					$this->design->assign('message_success', 'updated');
  	    		}
  	    		// Удаление изображения
  	    		if($this->request->post('delete_image'))
  	    		{
  	    			$this->categories->delete_image($category->id);
  	    		}
  	    		// Загрузка изображения
  	    		$image = $this->request->files('image');
  	    		if(!empty($image['name']) && in_array(strtolower(pathinfo($image['name'], PATHINFO_EXTENSION)), $this->allowed_image_extentions))
  	    		{
  	    			$this->categories->delete_image($category->id);
  	    			move_uploaded_file($image['tmp_name'], $this->root_dir.$this->config->categories_images_dir.$image['name']);
  	    			$this->categories->update_category($category->id, array('image'=>$image['name']));
  	    		}
  	    		// Удаление изображения
  	    		if($this->request->post('delete_image_podobrat'))
  	    		{
  	    			$this->categories->delete_image_podobrat($category->id);
  	    		}
  	    		// Загрузка изображения
  	    		$image = $this->request->files('image_podobrat');

  	    		if(!empty($image['name']) && in_array(strtolower(pathinfo($image['name'], PATHINFO_EXTENSION)), $this->allowed_image_extentions))
  	    		{
  	    			$this->categories->delete_image($category->id);
  	    			move_uploaded_file($image['tmp_name'], $this->root_dir.$this->config->categories_images_dir.$image['name']);
  	    			$image_size = getimagesize($this->root_dir.$this->config->categories_images_dir.$image['name']);
  	    			$this->categories->update_category($category->id, array('podobrat'=>$image['name'],'width'=>$image_size[0],'height'=>$image_size[1]));
  	    		}
  	    		$category = $this->categories->get_category(intval($category->id));
			}
                        
                        
                         // Теги
                           $this->categories->delete_tags('categori', $category->id);
                           $this->categories->add_tags('categori', $category->id, $this->request->post('tags'));
                           
//                           ini_set('error_reporting', E_ALL);
//                            ini_set('display_errors', 1);
//                            ini_set('display_startup_errors', 1);
                           
                            $tags = explode(',', $this->request->post('tags'));
                            foreach ($tags as $value) {
                                
                                if(!$this->tags->get_tag((string)$value,'sdsd'))
                                {
                                    $tag = new stdClass;
                                    $tag->name = $value;

                                    $this->tags->add_tag($tag);
                                    
                                }
                                
                                
                            }
                           
                           
                          

                           $category->tags = $this->categories->get_tags(array('object_id'=>$category->id, 'type' => 'categori'));
                        
		}
		else
		{
			$category->id = $this->request->get('id', 'integer');
			$category = $this->categories->get_category($category->id);
                         // Теги
                        $category->tags = $this->categories->get_tags(array('object_id'=>$category->id, 'type' => 'categori'));    
		}
		

		$categories = $this->categories->get_categories_tree();

		$this->design->assign('category', $category);
		$this->design->assign('categories', $categories);
		return  $this->design->fetch('category.tpl');
	}
}