<?PHP
require_once('api/Simpla.php');

class FeatureAdmin extends Simpla
{

	function fetch()
	{
		$feature = new stdClass;
		if($this->request->method('post'))
		{
			$feature->id = $this->request->post('id', 'integer');
			$feature->name = $this->request->post('name');
			$feature->in_filter = intval($this->request->post('in_filter'));
			$feature_categories = $this->request->post('feature_categories');

            /* chpu_filter */
            $feature->url = $this->request->post('url');
            // Не допустить одинаковые URL свойств.
            if(($c = $this->features->get_feature($feature->url)) && $c->id!=$feature->id)
            {
                $this->design->assign('message_error', 'Свойство с таким url уже существует');
            }
            else
            {/* chpu_filter /*/
                if(empty($feature->id))
                {
                    $feature->id = $this->features->add_feature($feature);
                    $feature = $this->features->get_feature($feature->id);
                    $this->design->assign('message_success', 'added');
                }
                else
                {
                    $this->features->update_feature($feature->id, $feature);
                    $feature = $this->features->get_feature($feature->id);
                    $this->design->assign('message_success', 'updated');
                }
                $this->features->update_feature_categories($feature->id, $feature_categories);
			/* chpu_filter */}/* chpu_filter /*/
		}
		else
		{
			$feature->id = $this->request->get('id', 'integer');
			$feature = $this->features->get_feature($feature->id);
		}

		$feature_categories = array();	
		if($feature)
		{	
			$feature_categories = $this->features->get_feature_categories($feature->id);
		}
		
		$categories = $this->categories->get_categories_tree();
		$this->design->assign('categories', $categories);
		$this->design->assign('feature', $feature);
		$this->design->assign('feature_categories', $feature_categories);
		return $this->body = $this->design->fetch('feature.tpl');
	}
}




