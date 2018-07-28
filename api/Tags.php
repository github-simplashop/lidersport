<?php

require_once('Simpla.php');

class Tags extends Simpla{
	
	public function get_tags($filter = array()){	
		$limit = 1000;
		$page = 1;
		$post_id_filter = '';
		$keyword_filter = '';
        $object_filter = '';
        
        if(isset($filter['limit']))
			$limit = max(1, intval($filter['limit']));

		if(isset($filter['page']))
			$page = max(1, intval($filter['page']));

		if(!empty($filter['id']))
			$post_id_filter = $this->db->placehold('AND id in(?@)', (array)$filter['id']);		
		else
            if(!empty($filter['object_id']) && !empty($filter['type']))
                $post_id_filter = $this->db->placehold(' AND id in (SELECT DISTINCT tag_id FROM __tags WHERE type=? AND object_id=?)',$filter['type'],intval($filter['object_id']));
        
		if(isset($filter['keyword'])){
			$keywords = explode(' ', $filter['keyword']);
			foreach($keywords as $keyword)
				$keyword_filter .= $this->db->placehold('AND (name LIKE "%'.$this->db->escape(trim($keyword)).'%" OR meta_keywords LIKE "%'.$this->db->escape(trim($keyword)).'%") ');
		}

		$sql_limit = $this->db->placehold(' LIMIT ?, ? ', ($page-1)*$limit, $limit);
        
        $query = $this->db->placehold("SELECT * FROM __tags_details WHERE 1 $post_id_filter $keyword_filter
		                                      ORDER BY name $sql_limit");
		$this->db->query($query);

		return $this->db->results();
	}
    
    public function count_tags($filter = array()){	
		$post_id_filter = '';
		$keyword_filter = '';
		
		if(!empty($filter['id']))
			$post_id_filter = $this->db->placehold('AND id in(?@)', (array)$filter['id']);
			
		if(isset($filter['keyword'])){
			$keywords = explode(' ', $filter['keyword']);
			foreach($keywords as $keyword)
				$keyword_filter .= $this->db->placehold('AND (name LIKE "%'.$this->db->escape(trim($keyword)).'%" OR meta_keywords LIKE "%'.$this->db->escape(trim($keyword)).'%") ');
		}
		
		$query = "SELECT COUNT(distinct id) as count
		          FROM __tags_details WHERE 1 $post_id_filter $keyword_filter";

		if($this->db->query($query))
			return $this->db->result('count');
		else
			return false;
	}

	public function get_tag($id, $name = false){
		if(is_int($id))			
			$filter = $this->db->placehold('id = ?', $id);
		else
            if($name)
                $filter = $this->db->placehold('name = ?', $id);
            else
                $filter = $this->db->placehold('url = ?', $id);
		$query = "SELECT * FROM __tags_details b WHERE $filter LIMIT 1";
		$this->db->query($query);
                
		return $this->db->result();
	}

	public function add_tag($tag){
		$tag = (array)$tag;
		if(empty($tag['url'])){
			$tag['url'] = $this->translit($tag['name']);
		}
        
        while($this->get_tag((string)$tag['url'])){
			if(preg_match('/(.+)_([0-9]+)$/', $tag['url'], $parts))
				$tag['url'] = $parts[1].'_'.($parts[2]+1);
			else
				$tag['url'] = $tag['url'].'_2';
		}
		$this->db->query("INSERT IGNORE INTO __tags_details SET ?%", $tag);
		return $this->db->insert_id();
	}

	public function update_tag($id, $tag){
		$query = $this->db->placehold("UPDATE __tags_details SET ?% WHERE id=? LIMIT 1", $tag, intval($id));
		$this->db->query($query);
		return $id;
	}
	
	public function delete_tag($id){
		if(!empty($id)){
                    
                        $tags = $this->get_tag((int)$id);
                        
                        
                    
                        $query = $this->db->placehold("DELETE FROM __tags WHERE value=?", $tags->name);
			$this->db->query($query);
                        
                    
			$query = $this->db->placehold("DELETE FROM __tags_details WHERE id=? LIMIT 1", $id);
			$this->db->query($query);		
				
		}
	}
    
    public function add_object_tags($type, $object_id, $values){   
        $tags = explode(',', $values);
        foreach($tags as $value){
            if($tag = $this->get_tag($value,true)){
                $this->db->query("INSERT IGNORE INTO __tags SET type=?, object_id=?, tag_id=?", $type, intval($object_id), intval($tag->id));
            }elseif($tag_id = $this->add_tag(array('name'=>$value))){
                 $this->db->query("INSERT IGNORE INTO __tags SET type=?, object_id=?, tag_id=?", $type, intval($object_id), intval($tag_id));
            }
        }
        return count($tags);
    }
    public function add_object_tag($type, $object_id, $tag_id){   
        $this->db->query("INSERT IGNORE INTO __tags SET type=?, object_id=?, tag_id=?", $type, intval($object_id), intval($tag_id));
        return count($tags);
    }
    
    public function delete_object_tags($type,$object_id){ 
        $query = $this->db->placehold("DELETE FROM __tags WHERE type=? AND object_id=?", $type, $object_id);
        $this->db->query($query);  
    }
    
    public function get_tag_objects_ids($type,$tag_id){
        if(empty($tag_id) || empty($type))
            return false;
        $query = $this->db->placehold("SELECT object_id FROM __tags WHERE type=? AND tag_id=?", $type, intval($tag_id));
        $this->db->query($query);
        return $this->db->results('object_id');
    }
    
    private function translit($text)
	{
		$ru = explode('-', "А-а-Б-б-В-в-Ґ-ґ-Г-г-Д-д-Е-е-Ё-ё-Є-є-Ж-ж-З-з-И-и-І-і-Ї-ї-Й-й-К-к-Л-л-М-м-Н-н-О-о-П-п-Р-р-С-с-Т-т-У-у-Ф-ф-Х-х-Ц-ц-Ч-ч-Ш-ш-Щ-щ-Ъ-ъ-Ы-ы-Ь-ь-Э-э-Ю-ю-Я-я"); 
		$en = explode('-', "A-a-B-b-V-v-G-g-G-g-D-d-E-e-E-e-E-e-ZH-zh-Z-z-I-i-I-i-I-i-J-j-K-k-L-l-M-m-N-n-O-o-P-p-R-r-S-s-T-t-U-u-F-f-H-h-TS-ts-CH-ch-SH-sh-SCH-sch---Y-y---E-e-YU-yu-YA-ya");

	 	$res = str_replace($ru, $en, $text);
		$res = preg_replace("/[\s]+/ui", '-', $res);
		$res = preg_replace('/[^\p{L}\p{Nd}\d-]/ui', '', $res);
	 	$res = strtolower($res);
	    return $res;  
	}

}