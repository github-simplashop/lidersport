<?php



require_once('api/Simpla.php');





############################################

# Class Category - Edit the good gategory

############################################

class ColorAdmin extends Simpla

{

  private $allowed_image_extentions = array('png', 'gif', 'jpg', 'jpeg', 'ico');



  function fetch()

  {

		if($this->request->method('post'))

		{

			$color->id = $this->request->post('id', 'integer');

			$color->word = $this->request->post('word');

			$color->html1 = $this->request->post('html1', 'string');
            
            $color->textura = $this->request->post('textura', 'string');
            
			// Не допустить одинаковые URL разделов.

			if(($c = $this->colors->get_color($color->id)) && $c->word!=$color->word)

			{			

				$this->design->assign('message_error', 'word_exists');

			}

			else

			{
			 
             

				if(empty($color->id))

				{

	  				$color->id = $this->colors->add_color($color);

					$this->design->assign('message_success', 'added');

	  			}

  	    		else

  	    		{
  	    		   
                   if(!empty($_FILES['variant_image']['tmp_name'][0]) && !empty($_FILES['variant_image']['name'][0]))
			 	{
				   
 					$image_tmp_name = $_FILES['variant_image']['tmp_name'][0];
 					$image_name = $_FILES['variant_image']['name'][0];
					move_uploaded_file($image_tmp_name, $this->config->root_dir.'/images/textures/'.$image_name);
					$color->textura = $image_name;
                    
				}

  	    			$this->colors->update_color($color->id, $color);

					$this->design->assign('message_success', 'updated');

  	    		}	

  	    		// Удаление изображения

  	    		if($this->request->post('delete_color'))

  	    		{

  	    			$this->colors->delete_color($color->id);

  	    		}


	  			$color = $this->colors->get_color($color->id);
			
			}
            
            	

		}

		else

		{

			$color->id = $this->request->get('id', 'integer');

			$color = $this->colors->get_color($color->id);

		}

		

 		$this->design->assign('color', $color);
       

		return  $this->design->fetch('color.tpl');

	}

}