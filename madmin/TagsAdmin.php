<?php

/**
 * Simpla CMS
 *
 * @copyright	2011 Denis Pikusov
 * @link		http://simplacms.ru
 * @author		Denis Pikusov
 *
 */
 
require_once('api/Simpla.php');

class TagsAdmin extends Simpla
{
	public function fetch()
	{
		// Обработка действий
		if($this->request->method('post'))
		{
			// Действия с выбранными
			$ids = $this->request->post('check');
			if(is_array($ids))
			switch($this->request->post('action'))
			{
			    case 'delete':
			    {
				    foreach($ids as $id)
						$this->tags->delete_tag($id);    
			        break;
			    }
			}				
		}

		$filter = array();
		$filter['page'] = max(1, $this->request->get('page', 'integer')); 		
		$filter['limit'] = 20;
  	
		// Поиск
		$keyword = $this->request->get('keyword', 'string');
		if(!empty($keyword))
		{
			$filter['keyword'] = $keyword;
			$this->design->assign('keyword', $keyword);
		}		
		
		$tags_count = $this->tags->count_tags($filter);
		// Показать все страницы сразу
		if($this->request->get('page') == 'all')
			$filter['limit'] = $tags_count;	
		
		$tags = $this->tags->get_tags($filter);
		$this->design->assign('tags_count', $tags_count);
		
		$this->design->assign('pages_count', ceil($tags_count/$filter['limit']));
		$this->design->assign('current_page', $filter['page']);
		
		$this->design->assign('tags', $tags);
		return $this->design->fetch('tags.tpl');
	}
}
