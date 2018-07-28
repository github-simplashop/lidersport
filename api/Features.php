<?php

/**
 * Simpla CMS
 *
 * @copyright	2011 Denis Pikusov
 * @link		http://simplacms.ru
 * @author		Denis Pikusov
 *
 */
 
require_once('Simpla.php');

class Features extends Simpla
{	
	
	function get_features($filter = array())
	{
		$category_id_filter = '';	
		if(isset($filter['category_id']))
			$category_id_filter = $this->db->placehold('AND id in(SELECT feature_id FROM __categories_features AS cf WHERE cf.category_id in(?@))', (array)$filter['category_id']);
		
		$in_filter_filter = '';	
		if(isset($filter['in_filter']))
			$in_filter_filter = $this->db->placehold('AND f.in_filter=?', intval($filter['in_filter']));
		
		$id_filter = '';	
		if(!empty($filter['id']))
			$id_filter = $this->db->placehold('AND f.id in(?@)', (array)$filter['id']);
		
		// Выбираем свойства
		$query = $this->db->placehold("SELECT id, name, position, in_filter/* chpu_filter */, url/* chpu_filter /*/ FROM __features AS f
									WHERE 1
									$category_id_filter $in_filter_filter $id_filter ORDER BY f.position");
		$this->db->query($query);
		return $this->db->results();
	}
		
	function get_feature($id)
	{
		// Выбираем свойство
        /* chpu_filter */
        /*$query = $this->db->placehold("SELECT id, name, position, in_filter FROM __features WHERE id=? LIMIT 1", $id);*/
        if(is_int($id))
            $where = $this->db->placehold('id = ?', $id);
        else
            $where = $this->db->placehold('url = ?', $id);
        $query = $this->db->placehold("SELECT id, name, position, in_filter, url FROM __features WHERE $where LIMIT 1");
        /* chpu_filter /*/
		$this->db->query($query);
		return $this->db->result();
	}
	
	function get_feature_categories($id)
	{
		$query = $this->db->placehold("SELECT cf.category_id as category_id FROM __categories_features cf
										WHERE cf.feature_id = ?", $id);
		$this->db->query($query);
		return $this->db->results('category_id');	
	}
	
	public function add_feature($feature)
	{
        /* chpu_filter */
        $feature = (array)$feature;
        if(empty($feature['url']))
            $feature['url'] = $this->translit($feature['name']);
        //не уверен в необходимости этого кода, т.к. при импорте свойство выбирается по названию и уже с выбранным свойством проводятся манипуляции спользуя его id
        //и возможности дублировать свойства, как товары нет, но лишняя проверка - не лишняя
        while($this->get_feature((string)$feature['url']))
        {
            if(preg_match('/(.+)([0-9]+)$/', $feature['url'], $parts))
                $feature['url'] = $parts[1].''.($parts[2]+1);
            else
                $feature['url'] = $feature['url'].'2';
        }
        /* chpu_filter /*/

	    $query = $this->db->placehold("INSERT INTO __features SET ?%", $feature);
		$this->db->query($query);
		$id = $this->db->insert_id();
		$query = $this->db->placehold("UPDATE __features SET position=id WHERE id=? LIMIT 1", $id);
		$this->db->query($query);
		return $id;
	}
		
	public function update_feature($id, $feature)
	{
		$query = $this->db->placehold("UPDATE __features SET ?% WHERE id in(?@) LIMIT ?", (array)$feature, (array)$id, count((array)$id));
		$this->db->query($query);
		return $id;
	}
	
	public function delete_feature($id = array())
	{
		if(!empty($id))
		{
			$query = $this->db->placehold("DELETE FROM __features WHERE id=? LIMIT 1", intval($id));
			$this->db->query($query);
			$query = $this->db->placehold("DELETE FROM __options WHERE feature_id=?", intval($id));
			$this->db->query($query);	
			$query = $this->db->placehold("DELETE FROM __categories_features WHERE feature_id=?", intval($id));
			$this->db->query($query);	
		}
	}
	

	public function delete_option($product_id, $feature_id)
	{
		$query = $this->db->placehold("DELETE FROM __options WHERE product_id=? AND feature_id=? LIMIT 1", intval($product_id), intval($feature_id));
		$this->db->query($query);
	}

	
	public function update_option($product_id, $feature_id, $value/* chpu_filter */,$translit = ''/* chpu_filter /*/)
	{	 
		if($value != '')
            /* chpu_filter */
            /*$query = $this->db->placehold("REPLACE INTO __options SET value=?, product_id=?, feature_id=?", $value, intval($product_id), intval($feature_id));*/
            $query = $this->db->placehold(
                "REPLACE INTO __options SET value=?, product_id=?, feature_id=?, translit=?",
                $value, intval($product_id), intval($feature_id),
                ($translit != '' ? $translit : $this->translit($value))
            );
            /* chpu_filter /*/
		else
			$query = $this->db->placehold("DELETE FROM __options WHERE feature_id=? AND product_id=?", intval($feature_id), intval($product_id));
		return $this->db->query($query);
	}


	public function add_feature_category($id, $category_id)
	{
		$query = $this->db->placehold("INSERT IGNORE INTO __categories_features SET feature_id=?, category_id=?", $id, $category_id);
		$this->db->query($query);
	}
			
	public function update_feature_categories($id, $categories)
	{
		$id = intval($id);
		$query = $this->db->placehold("DELETE FROM __categories_features WHERE feature_id=?", $id);
		$this->db->query($query);
		
		
		if(is_array($categories))
		{
			$values = array();
			foreach($categories as $category)
				$values[] = "($id , ".intval($category).")";
	
			$query = $this->db->placehold("INSERT INTO __categories_features (feature_id, category_id) VALUES ".implode(', ', $values));
			$this->db->query($query);

			// Удалим значения из options 
			$query = $this->db->placehold("DELETE o FROM __options o
			                               LEFT JOIN __products_categories pc ON pc.product_id=o.product_id
			                               WHERE o.feature_id=? AND pc.category_id not in(?@)", $id, $categories);
			$this->db->query($query);
		}
		else
		{
			// Удалим значения из options 
			$query = $this->db->placehold("DELETE o FROM __options o WHERE o.feature_id=?", $id);
			$this->db->query($query);
		}
	}
			

	public function get_options($filter = array())
	{
		$feature_id_filter = '';
		$product_id_filter = '';
		$category_id_filter = '';
		$visible_filter = '';
		$brand_id_filter = '';
		$features_filter = '';

		if(empty($filter['feature_id']) && empty($filter['product_id']))
			return array();
		
		$group_by = '';
		if(isset($filter['feature_id']))
			$group_by = 'GROUP BY feature_id, value';
			
		if(isset($filter['feature_id']))
			$feature_id_filter = $this->db->placehold('AND po.feature_id in(?@)', (array)$filter['feature_id']);

		if(isset($filter['product_id']))
			$product_id_filter = $this->db->placehold('AND po.product_id in(?@)', (array)$filter['product_id']);

		if(isset($filter['category_id']))
			$category_id_filter = $this->db->placehold('INNER JOIN __products_categories pc ON pc.product_id=po.product_id AND pc.category_id in(?@)', (array)$filter['category_id']);

		if(isset($filter['visible']))
			$visible_filter = $this->db->placehold('INNER JOIN __products p ON p.id=po.product_id AND visible=?', intval($filter['visible']));

		if(isset($filter['brand_id']))
			$brand_id_filter = $this->db->placehold('AND po.product_id in(SELECT id FROM __products WHERE brand_id in(?@))', (array)$filter['brand_id']);


        if (isset($filter['features'])) {
            foreach ($filter['features'] as $feature => $value) {
                $features_filter .= $this->db->placehold('AND (po.feature_id = ? OR po.product_id in (SELECT product_id
                                                          FROM __options
                                                          WHERE feature_id = ? AND translit in (?@)))',
                                                         $feature, $feature, is_array($value) ? $value : array($value));
            }
        }

		$query = $this->db->placehold("SELECT po.product_id, po.feature_id, po.value,/* chpu_filter */ po.translit,/* chpu_filter /*/ count(po.product_id) as count
		    FROM __options po
		    $visible_filter
			$category_id_filter
			WHERE 1 $feature_id_filter $product_id_filter $brand_id_filter $features_filter GROUP BY po.feature_id, po.value ORDER BY value=0, -value DESC, value");

		$this->db->query($query);
		$res = $this->db->results();

		return $res;
	}
	
	public function get_product_options($product_id)
	{
		$query = $this->db->placehold("SELECT f.id as feature_id, f.name, po.value, po.product_id/* chpu_filter */, f.url, po.translit/* chpu_filter /*/ FROM __options po LEFT JOIN __features f ON f.id=po.feature_id
										WHERE po.product_id in(?@) ORDER BY f.position", (array)$product_id);

		$this->db->query($query);
		$res = $this->db->results();

		return $res;
	}
    /* chpu_filter */
    public function translit($text){
        $ru = explode('-', "А-а-Б-б-В-в-Ґ-ґ-Г-г-Д-д-Е-е-Ё-ё-Є-є-Ж-ж-З-з-И-и-І-і-Ї-ї-Й-й-К-к-Л-л-М-м-Н-н-О-о-П-п-Р-р-С-с-Т-т-У-у-Ф-ф-Х-х-Ц-ц-Ч-ч-Ш-ш-Щ-щ-Ъ-ъ-Ы-ы-Ь-ь-Э-э-Ю-ю-Я-я");
        $en = explode('-', "A-a-B-b-V-v-G-g-G-g-D-d-E-e-E-e-E-e-ZH-zh-Z-z-I-i-I-i-I-i-J-j-K-k-L-l-M-m-N-n-O-o-P-p-R-r-S-s-T-t-U-u-F-f-H-h-TS-ts-CH-ch-SH-sh-SCH-sch---Y-y---E-e-YU-yu-YA-ya");

        $res = str_replace($ru, $en, $text);
        $res = preg_replace("/[\s-_]+/ui", '', $res);
        $res = preg_replace('/[^\p{L}\p{Nd}\d-]/ui', '', $res);
        $res = strtolower($res);
        return $res;
    }
    /* chpu_filter /*/
}
