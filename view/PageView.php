<?PHP

/**
 *
 * Этот класс использует шаблон page.tpl
 *
 */
require_once('View.php');

class PageView extends View
{
	function fetch()
	{
		$url = $this->request->get('page_url', 'string');

		$page = $this->pages->get_page($url);
		
		// Отображать скрытые страницы только админу
		if (empty($page))
		{
			// возможно это категория
			$_GET['category'] = $this->request->get('page_url', 'string');
			
			if (!$this->request->get('product', 'string'))
			{
			    require_once('ProductsView.php');
				$category = new ProductsView();
				return $category->fetch();
			}
			//else if ($this->request->get('product', 'string'))
			else if ($product = $this->products->get_product($this->request->get('product', 'string')))
			{
				$_GET['product_url'] = $this->request->get('product', 'string');
				require_once('ProductView.php');
				$product = new ProductView();
				return $product->fetch();
			}
			
			if((!$page->visible && empty($_SESSION['admin'])))
				return false;
		}
		else if((!$page->visible && empty($_SESSION['admin'])))
		{return false;}
		else
		{
			$this->design->assign('url_p', $url);
			$this->design->assign('page', $page);
			$this->design->assign('meta_title', $page->meta_title);
			$this->design->assign('meta_keywords', $page->meta_keywords);
			$this->design->assign('meta_description', $page->meta_description);
			
			return $this->design->fetch('page.tpl');
		}
	}
}