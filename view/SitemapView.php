<?PHP

/**
 * Simpla CMS
 *
 * @copyright     2012 t Mitrofanov
 * @link         http://rlstudio.com
 * @author         Art Mitrofanov
 *
 * Этот класс использует шаблон sitemap.tpl
 *
 */
require_once('View.php');

class SitemapView extends View
{
    function fetch()
    {
        $page = $this->pages->get_page('sitemap');
        
        // Отображать скрытые страницы только админу
        if(empty($page) || (!$page->visible && empty($_SESSION['admin'])))
            return false;
        
        $this->design->assign('page', $page);
        $this->design->assign('meta_title', $page->meta_title);
        $this->design->assign('meta_keywords', $page->meta_keywords);
        $this->design->assign('meta_description', $page->meta_description);

        $this->design->assign('posts', $this->blog->get_posts(array('visible'=>1)));
        
        $categories = $this->categories->get_categories_tree();
        $this->design->assign('cats', $this->cat_tree($categories));
        
        return $this->design->fetch('sitemap.tpl');
    }
    
    private function cat_tree($categories) {

        foreach($categories AS $k=>$v) {
            if(isset($v->subcategories)) $this->cat_tree($v->subcategories);
            $categories[$k]->products = $this->products->get_products(array('category_id' => $v->id, 'visible'=>1));  
        } 
        
        return $categories;
    }
}