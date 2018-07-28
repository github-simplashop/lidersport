<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 v1.1
 */

/**
 * Description of CashRegisterRequest
 *
 * @author igor
 */
class CashRegisterRequest
{
    private $phonePrefixesToDelete = array('+7', '8', '7');
    
    const TAXING_SYSTEM_OSN = 'osn';
    const TAXING_SYSTEM_USN_INCOME = 'usn_income';
    const TAXING_SYSTEM_USN_INCOME_OUTCOME = 'usn_income_outcome';    
    const TAXING_SYSTEM_ENVD = 'envd';
    const TAXING_SYSTEM_ESN = 'esn';
    const TAXING_SYSTEM_PATENT = 'patent';
    
    const AMOUNT_PRECISION = 2;
    
    private $inn;
    private $callbackUrl = '';
    private $paymentAddress = '';
    
    private $products;
    private $payments;
    
    private $amount;    
    private $purchaserEmail;
    private $purchaserPhone;
    
    private $taxingSystem;
    
    public function setInn($newInn)
    {
        $this->inn = $newInn;
    }
    
    public function setCallbackUrl($newCallbackUrl)
    {
        $this->callbackUrl = $newCallbackUrl;
    }
    
    public function setPaymentAddress($newPaymentAddress)
    {
        $this->paymentAddress = $newPaymentAddress;
    }
        
    public function setAmount($newAmount)
    {
        $this->amount = $newAmount;
    }

    public function setPurchaserEmail($newPurchaserEmail)
    {
        $this->purchaserEmail = $newPurchaserEmail;
    }
    
    public function setPurchaserPhone($newPurchaserPhone)
    {
        $this->purchaserPhone = $newPurchaserPhone;
    }    

    public function setTaxingSystem($newTaxingSystem)
    {
        $this->taxingSystem = $newTaxingSystem;
    }
    
    public function addProduct(CashRegisterRequestProduct $newProduct)
    {
        $this->products[] = $newProduct;
    }
        
    public function addPayment($amount, $paymentType = null)
    {
        if ($paymentType)
            $this->payments[] = new CashRegisterRequestPayment($amount, $paymentType);
        else
            $this->payments[] = new CashRegisterRequestPayment($amount);
    }

    private function beginsWith($str, $prefix)
    {
        return substr($str, 0, strlen($prefix)) === $prefix;
    }
    
    private function deleteFirstFromStart($str, $prefixes)
    {
        foreach ($prefixes as $v)
        {
            if ($this->beginsWith($str, $v))
            {
                $str = $this->deleteFromStart($str, $v);
                break;
            }
        }
        return $str;
    }

    private function deleteFromStart($str, $prefix)
    {
        return substr($str, strlen($prefix));
    }
    
    private function normalizePhoneNumber($phone)
    {
        /*$phone = $this->deleteFirstFromStart(
                    filter_var($phone, FILTER_SANITIZE_NUMBER_INT),
                    $this->phonePrefixesToDelete()
        );
        return filter_var($phone, FILTER_SANITIZE_NUMBER_INT, array('options' => array('min_range' => 0)));*/
        return preg_replace('/\D+/', '', $this->deleteFirstFromStart($phone, $this->phonePrefixesToDelete));
    }
    
    public function toArray()
    {
    	function prod_to_arr(CashRegisterRequestProduct $v) {
        	return $v->toArray();
        }

        function pay_to_arr(CashRegisterRequestPayment $v) {
        	return $v->toArray();
        }
        
        $result = array(
            'timestamp' => '',
            'service' => array(
                'inn' => $this->inn,
                'payment_address' => $this->paymentAddress,
            ),
            'receipt' => array(
                'items' => array_map('prod_to_arr', $this->products),
                'total' => round($this->amount, self::AMOUNT_PRECISION),
                'payments' => array_map('pay_to_arr', $this->payments),
            ),
        );
                
        if (isset($this->taxingSystem))
            $result['receipt']['attributes']['sno'] = $this->taxingSystem;
        if (isset($this->purchaserEmail))
            $result['receipt']['attributes']['email'] = $this->purchaserEmail;
        if (isset($this->purchaserPhone))
            $result['receipt']['attributes']['phone'] = $this->normalizePhoneNumber($this->purchaserPhone);
        if (isset($this->callbackUrl))
            $result['service']['callback_url'] = $this->callbackUrl;
        
        return $result;
        
        
    }
    
    public function toJson()
    {
        return json_encode($this->toArray());
    }
    
    public function toTextFormat()
    {
        return $this->toJson();
    }
}

class CashRegisterRequestProduct
{
    const TAX_NONE = 'none';
    const TAX_VAT0 = 'vat0';
    const TAX_VAT10 = 'vat10';
    const TAX_VAT18 = 'vat18';
    const TAX_VAT110 = 'vat110';
    const TAX_VAT118 = 'vat118';
    
    const AMOUNT_PRECISION = 2;
        
    private $taxes = array(
    	'NULL' => 'none',
    	0 => 'vat0',
    	10 => 'vat10',
	    18 => 'vat18',
	    110 => 'vat110',
   		118 => 'vat118',
    	);
    
    private $name;
    private $price;
    private $count;
    private $amount;
    private $tax;
    private $taxAmount;
    
    public function setName($newName)
    {
        $this->name = $newName;
    }

    public function setPrice($newPrice)
    {
        $this->price = round($newPrice, self::AMOUNT_PRECISION);
    }

    public function setCount($newCount)
    {
        $this->count = $newCount;
    }

    public function setAmount($newAmount)
    {
        $this->amount = round($newAmount, self::AMOUNT_PRECISION);
    }

    public function setTax($newTax)
    {
        $this->tax = $newTax;
    }
    public function setTaxByNumber($newTax)
    {
        $tax = preg_replace('/^[^0-9]*([0-9\.]+)[^0-9]*$/', '$1', $newTax);
        $tax = preg_replace('/^0?(1?)\.([0-9]+)$/','$1$2', $tax);
        if (key_exists($tax, $this->taxes)) {
        	$this->tax = $this->taxes[$tax];
        }
        else {
        	$this->tax = $this->taxes['NULL'];
        }
    }

    public function setTaxAmount($newTaxAmount)
    {
        $this->taxAmount = round($newTaxAmount, self::AMOUNT_PRECISION);
    }
    
    public function toArray()
    {
    	$arr = array(
            'sum' => $this->amount,
            'tax' => $this->tax,
            'name' => $this->name,
            'price' => $this->price,
            'quantity' => $this->count,
        );
        if (!is_null($this->taxAmount)) {
        	$arr['tax_sum'] = $this->taxAmount;
        }
        return $arr;
    }
}

class CashRegisterRequestPayment
{
    const PAYMENT_TYPE_CASH = 0;
    const PAYMENT_TYPE_ONLINE = 1;
    const PAYMENT_TYPE_ADVANCE = 2;
    const PAYMENT_TYPE_CREDIT = 3;    
    const PAYMENT_TYPE_CUSTOM = 4;
    
    const AMOUNT_PRECISION = 2;
        
    private $amount;
    private $paymentType;
    
    public function __construct($initAmount, $initPaymentType = self::PAYMENT_TYPE_ONLINE)
    {
        $this->amount = round($initAmount, self::AMOUNT_PRECISION);
        $this->paymentType = $initPaymentType;
    }
    
    public function toArray()
    {
        return array(
            'sum' => $this->amount,
            'type' => $this->paymentType,
        );
    }
}

/*abstract class CashRegisterRequestClass
{
    const AMOUNT_PRECISION = 2;
    private function format_sum
}*/