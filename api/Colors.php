<?php



/**

 * Работа с вариантами товаров

 *

 * @copyright 	2011 Denis Pikusov

 * @link 		http://simplacms.ru

 * @author 		Denis Pikusov

 *

 */



require_once('Simpla.php');



class Colors extends Simpla

 {

	public function toggle_color($word)

	{
	   $color = array();

		$query = $this->db->placehold("SELECT html1, textura FROM __word_color WHERE word=?", $word);

		$this->db->query($query);
        
        $color = $this->db->result();

	   return $color;
    }
    
    public function get_colors()

	{

		$query = $this->db->placehold("SELECT * FROM __word_color");

		$this->db->query($query);
        
	   return $this->db->results();;
    }
    
    public function get_color($id)

	{

		$query = $this->db->placehold("SELECT * FROM __word_color WHERE id=?", $id);

		$this->db->query($query);
        
	   return $this->db->result();
    }
    
   	public function add_color($color)

	{

		$query = $this->db->placehold("INSERT INTO __word_color SET ?%", $color);

		$this->db->query($query);

		return $this->db->insert_id();

	}
    
    
    public function delete_color($id)

	{

		if(!empty($id))

		{


			$query = $this->db->placehold("DELETE FROM __word_color WHERE id = ? LIMIT 1", intval($id));

			$this->db->query($query);

		}

	}
    
    public function update_color($id, $color)

	{

		$query = $this->db->placehold("UPDATE __word_color SET ?% WHERE id=? LIMIT 1", $color, intval($id));

		$this->db->query($query);

		return $id;

	}
    
        public function check_color($color)

	{

		$query = $this->db->placehold("SELECT word FROM __word_color WHERE word LIKE ? LIMIT 1", $color, ($color));
        
        $this->db->query($query);

        $otvet = $this->db->result();

		return $otvet->word;

	}
    
 }