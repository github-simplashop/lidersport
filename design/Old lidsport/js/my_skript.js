$(document).ready(function(){
	$("#click_one").click(function() {
		 $(this).toggleClass("top_strel"); // перебить сss при этом классе стрелка топ
		 $(".hidden1").slideToggle("show"); // открыть при  show
	});
	
	$("#click_two").click(function() {
		 $(this).toggleClass("top_strel"); // перебить сss при этом классе стрелка топ
		 $(".hidden2").slideToggle("show"); // открыть при  show
	});
	
	$('.link_harakt').click(function(){
		var target_7 = $(this).attr('rel');
		$('html, body').animate({scrollTop: $(target_7).offset().top-120}, 600);
   });
   
    $(".fancybox").fancybox({
            openEffect	: 'none',
            closeEffect	: 'none'
        });
	
});