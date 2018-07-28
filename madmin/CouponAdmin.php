<?PHP

require_once('api/Simpla.php');

class CouponAdmin extends Simpla
{
	public function fetch()
	{
		if($this->request->method('post'))
		{
			$coupon->id = $this->request->post('id', 'integer');
			$coupon->code = $this->request->post('code', 'string');
			if($this->request->post('expires'))
				$coupon->expire = date('Y-m-d', strtotime($this->request->post('expire')));
			else
				$coupon->expire = null;
			$coupon->value = $this->request->post('value', 'float');			
			$coupon->type = $this->request->post('type', 'string');
			$coupon->min_order_price = $this->request->post('min_order_price', 'float');
			$coupon->single = $this->request->post('single', 'float');
            $coupon_categories = $this->request->post('coupon_categories');

 			// Не допустить одинаковые URL разделов.
			if(($a = $this->coupons->get_coupon((string)$coupon->code)) && $a->id!=$coupon->id)
			{			
				$this->design->assign('message_error', 'code_exists');
                $this->design->assign('message_error', 'code_group');
			}
			else
			{
				if(empty($coupon->id))
				{ 
	  				$coupon->id = $this->coupons->add_coupon($coupon);
	  				$coupon = $this->coupons->get_coupon($coupon->id);
					$this->design->assign('message_success', 'added');
	  			}
  	    		else
                {
                    $this->coupons->update_coupon($coupon->id, $coupon);
                    $coupon = $this->coupons->get_coupon($coupon->id);
                    $this->design->assign('message_success', 'updated');
                }
                $this->coupons->update_coupon_categories($coupon->id, $coupon_categories);


            }
		}
        else
        {
            $coupon->id = $this->request->get('id', 'integer');
            $coupon = $this->coupons->get_coupon($coupon->id);
        }
        $coupon_categories = array();
        if($coupon)
        {
            $coupon_categories = $this->coupons->get_coupon_categories($coupon->id);
        }

        $categories = $this->categories->get_categories_tree();
        $this->design->assign('categories', $categories);
        $this->design->assign('coupon', $coupon);
        $this->design->assign('coupon_categories', $coupon_categories);
        return $this->design->fetch('coupon.tpl');
	}
}