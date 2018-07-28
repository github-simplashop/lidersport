<?PHP

require_once('api/Simpla.php');

class TagAdmin extends Simpla
{
	public function fetch()
	{
		$tag = new stdClass;
		if($this->request->method('post'))
		{
			$tag->id = $this->request->post('id', 'integer');
			$tag->name = $this->request->post('name');

			$tag->url = $this->request->post('url', 'string');
			$tag->meta_title = $this->request->post('meta_title');
			$tag->meta_keywords = $this->request->post('meta_keywords');
			$tag->meta_description = $this->request->post('meta_description');
                        $tag->meta_d = $this->request->post('meta_d');
			
			$tag->text = $this->request->post('body');

 			// Не допустить одинаковые URL разделов.
			if(($a = $this->tags->get_tag($tag->url)) && $a->id!=$tag->id)
			{			
				$this->design->assign('message_error', 'url_exists');
			}
			else
			{
				if(empty($tag->id))
				{
	  				$tag->id = $this->tags->add_tag($tag);
	  				$tag = $this->tags->get_tag($tag->id);
					$this->design->assign('message_success', 'added');
	  			}
  	    		else
  	    		{
  	    			$this->tags->update_tag($tag->id, $tag);
  	    			$tag = $this->tags->get_tag($tag->id);
					$this->design->assign('message_success', 'updated');
  	    		}	
			}
		}
		else
		{
			$tag->id = $this->request->get('id', 'integer');
			$tag = $this->tags->get_tag(intval($tag->id));
		}
 		
		$this->design->assign('tag', $tag);
		
		
 	  	return $this->design->fetch('tag.tpl');
	}
}