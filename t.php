<?
error_reporting(E_ALL ^ E_NOTICE);	
include('/api/Simpla.php');

echo "start";

############################################
# Class Import
############################################

		$simpla = new Simpla();
		/*$simpla->db->query("SELECT * FROM __images ");
		$id = $simpla->db->result('id');
		echo $id;*/

		
?><pre><?print_r($simpla);?></pre><?
/*public function add_image($product_id, $filename)
	{
		$name = '';
		$query = $simpla->db->placehold("SELECT id FROM __images WHERE product_id=? AND filename=?", $product_id, $filename);
		$simpla->db->query($query);
		$id = $simpla->db->result('id');
		if(empty($id))
		{
			$query = $simpla->db->placehold("INSERT INTO __images SET product_id=?, filename=?", $product_id, $filename);
			$simpla->db->query($query);
			$id = $simpla->db->insert_id();
			$query = $simpla->db->placehold("UPDATE __images SET position=id WHERE id=?", $id);
			$simpla->db->query($query);
		}
		return($id);
	}*/
$fname = "http://lidsport.ru/ico1.jpg";
echo $simpla->products->add_image("5154", $fname);

//$simpla->image->upload_image($images['tmp_name'][$i], $images['name'][$i]);
$files = "da,daaaa,dddd";
$file = "dq";
print_r(split(",", $files));
echo "<br><br>";
print_r(split(",", $file));
/*echo phpinfo();*/

?>
