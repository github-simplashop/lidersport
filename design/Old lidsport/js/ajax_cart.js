// Аяксовая корзина
$(document).on('submit','form.cart', function(e){
	e.preventDefault();
	
	button = $(this).find('input[type="submit"]');
	
	if($(this).find('input[name=variant]:checked').size()>0)
		variant = $(this).find('input[name=variant]:checked').val();
	
	if($(this).find('select[name=variant]').size()>0)
		variant = $(this).find('select').val();
	
	$.ajax({
		url: "ajax/cart.php",
		data: {variant: variant},
		dataType: 'json',
		success: function(data)
		{
			$('#cart_informer').html(data);
			if(button.attr('data-result-text'))
				button.val(button.attr('data-result-text'));
		}
	});
	
	var o1 = $(this).offset();
	var o2 = $('.icons_cart').offset();
	var dx = o1.left - o2.left;
	var dy = o1.top - o2.top;
	var distance = Math.sqrt(dx * dx + dy * dy);
	
	$(this).closest('.product').find('.img img').effect("transfer", { to: $(".icons_cart"), className: "transfer_class" }, distance);	
	$('.transfer_class').html($(this).closest('.product').find('.img').html());
	$('.transfer_class').find('img').css('height', '100%');
	return false;
});