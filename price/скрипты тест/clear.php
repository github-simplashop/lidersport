<?PHP
error_reporting(E_ALL ^ E_NOTICE);

chdir('../');
include('api/Simpla.php');
include('price/comments.php');

    //process_get_commments();
    //process_clear_comments();
    clear();

	function clear()
	{
		$sim = new Simpla();

		/* Очистка всеx товаров */

        $sim->db->query('TRUNCATE s_variants');
        $sim->db->query('TRUNCATE s_products');
        $sim->db->query('TRUNCATE s_categories');
        $sim->db->query('TRUNCATE s_brands');
        $sim->db->query('TRUNCATE s_images');
        $sim->db->query('TRUNCATE s_related_products');
        $sim->db->query('TRUNCATE s_products_categories');
        $sim->db->query('TRUNCATE s_options');
        $sim->db->query('TRUNCATE s_categories_features');
        $sim->db->query('TRUNCATE s_features');
        $sim->db->query('TRUNCATE s_tags');

        /* ------------------- */

        /* Очистка изображений товаров */

        //clear_dir('/var/www/admin/data/www/admin3.lidsport.ru/files/originals/');
        //clear_dir('/var/www/admin/data/www/admin3.lidsport.ru/files/products/');
        
        echo "Очищено";

        /* --------------------------- */


	}