<?php
	if ($_GET['delete_products'] != 'sob2014mysql') {
		die('wedwd');
	}
	chdir('..');
	require_once('api/Simpla.php');
	$simpla = new Simpla();
	$simpla->db->query("SELECT id, url FROM __products WHERE visible=0 AND last_date_visible!='' AND ADDDATE(now(), INTERVAL -1 MONTH) > last_date_visible");
	$products = $simpla->db->results();
	foreach ($products as $product) {
		$product_url = 'products/'.$product->url;
		$res = $simpla->redirects->get_redirect($product_url);
		
		if (empty($res)) {
			$category_url = '/';

			$categories = $simpla->categories->get_categories(array('product_id'=>$product->id));
			$category = reset($categories);

			if (!empty($category)) {
				$category_url = 'catalog/' . $category->url;
				
			}

			$redirect['name'] = $product->url;
			$redirect['from_url'] = $product_url;
			$redirect['to_url'] = $category_url;
			
			$redirect['visible'] = 1;	
			$simpla->redirects->add_redirect($redirect);
		}
		$simpla->products->delete_product($product->id);
	}
