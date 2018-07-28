	
	var di =0;
	var all_prod = 0;
	var select_prod = 1;
	var sel_left = 0;

$(document).ready(function() { 
	$(".consultant_unavailable").click(function() {
		$(".consultant_unavailable").fadeOut("slow");
		$(".message_box").fadeIn("slow");
	});
	$(".top_boxm i").click(function() {
		$(".consultant_unavailable").fadeIn("slow");
		$(".message_box").fadeOut("slow");
	});
	
	
	$(".cart .btn").mouseover(function() {
    	$("#cart_informer").toggleClass("hide");
  	}).mouseout(function(){
    	$("#cart_informer").toggleClass("hide");
  	});
	
	$(".more_text_div").click(function() {
    	$(".more_text_div").toggleClass("more_text_show");
		$("#more_text").toggleClass("more_text_show");
  	}); 
	
	$(".punkt_add5").click(function() {
    	$("#region").show();
		
		/*$('.bfc_content').isotope({
			  // options
			  itemSelector : '.bfc_content > i',
			  masonry: {
				columnWidth: 180,
				rowHeight : 34
			  },
			  getSortData: { name : function ( $elem ) {
				return $elem.find('i.name').text();
			  }},
			  sortBy:"name"
	    });*/
  	});
	 
	$(".block_form_center .close").click(function() {
    	$("#region").hide();
  	}); 
	
	$(".bfc_content i").click(function() {
    	var bes = "";
		var shap= "";
		if ($(this).attr("tb") == 1)	{bes = "<i>звонок по России бесплатный</i>";}
		if ($(this).html() == "Москва" || $(this).html() == "Екатеринбург и обл" || $(this).html() == "Санкт-Петербург") 		{shap = "Филиал компании:<br>";}
		else {shap = "Пункт выдачи:<br>";}
		$(".punkt_add1").html(shap);
		$(".punkt_add2").html($(this).html());
		$(".punkt_add3").html($(this).attr("title"));
		$(".punkt_add4").html($(this).attr("tel"));
		 
		
    	/* $(".phone").html('<i style="margin-bottom: -6px;margin-top: -4px;text-align: right;"><a href="mailto:info@stanko-prof.ru">info@stanko-prof.ru</a></i>'+$(this).attr("tel")+bes);*/
		
		$("#region").hide();
  	});	
	
	di = $("#mycarousel").children("li");
	all_prod = di.length;
	slidego(0);
	$(".dinamic_img .next").click(function() {
    	slidego(1);
  	});
	$(".dinamic_img .prev").click(function() {
    	slidego(-1);
  	}); 
	
	geo();
 });
 
function geo()
{
	$(".bc_i").each(function(){
		if ($(this).html() == citi_geo) 
		{
			var bes = "";
			var shap= "";
			if ($(this).attr("tb") == 1)	{bes = "<i>звонок по России бесплатный</i>";}
			
			if ($(this).html() == "Москва" || $(this).html() == "Екатеринбург и обл" || $(this).html() == "Санкт-Петербург") 		{shap = "Филиал компании:<br>";}
			else {shap = "Пункт выдачи:<br>";}

			
			/*$(".region").html(shap+"<b>"+$(this).html()+"</b><br>"+$(this).attr("title"));
    		$(".phone").html('<i style="margin-bottom: -6px;margin-top: -4px;text-align: right;"><a href="mailto:info@stanko-prof.ru">info@stanko-prof.ru</a></i>'+$(this).attr("tel")+bes);*/
			$(".punkt_add1").html(shap);
		$(".punkt_add2").html($(this).html());
		$(".punkt_add3").html($(this).attr("title"));
		$(".punkt_add4").html($(this).attr("tel"));
			$("#region").hide();	
		}
    });
}
 
 function slidego(zn)
 {
	 select_prod = select_prod + zn; 
	 if (select_prod == all_prod-1) {$(".dinamic_img .next").hide();}
	 else	{$(".dinamic_img .next").show();}
	 
	 if (select_prod == 0) {$(".dinamic_img .prev").hide();}
	 else {$(".dinamic_img .prev").show();}
	 // if (sel_left){$("#mycarousel").css({left:240*zn}, 300);}
	 
	 for (var i=0;i<all_prod;i++)
	 {
		$("#mycarousel").find("li").eq(i).addClass("kri_"+i);
		
		$("#mycarousel").find("li").eq(i).addClass("kr");
		if (select_prod==i) {$("#mycarousel").find("li").eq(i).removeClass("kr"); $(".dinamic_img .title").html($(".kri_"+i).find(".t").html());}
	 }
	 
	 
	 var tecsel = select_prod;
	 if (tecsel < 1) tecsel=1;
	 if (all_prod-2 < tecsel) tecsel = all_prod-2;
	 $("#mycarousel").css({left:240*(tecsel-1)*-1}, 300);
 }
 
function cookieSet(index) { 
    $.cookie('submenuMark-' + index, 'opened', { expires: null, path: '/' }); // Set mark to cookie (submenu is shown):
 }
function cookieDel(index) { 
    $.cookie('submenuMark-' + index, null, { expires: null, path: '/' }); // Delete mark from cookie (submenu is hidden):
 }
 
 
 
  function post_zvon()
  {
	  var oki = 0;
	  if ($(".ozb_name").val().length < 2)
	  {
		  $("#erro_2").fadeIn("slow").html("Укажите свое Имя!");
		  oki = 1;
	  }
	  if ($(".ozb_com").val().length < 2)
	  {
		  $("#erro_2").fadeIn("slow").html("Напишите комментарий!");
		  oki = 1;
	  }
	  else if ($(".ozb_tel").val().length < 2)
	  {
		  $("#erro_2").fadeIn("slow").html("Укажите телефон!");
		  oki = 1;
	  }

	  
	  if (oki == 0)
	  {
		  $("#erro_2").fadeOut();
		  $("#success_2").fadeIn("slow");
		  
		  $.post(
			  "/ajax/mail.php",
			  {
				  type: "text/plain",
				  name: $(".ozb_name").val(),
				  oz_comment: $(".ozb_com").val(),
				  tel: $(".ozb_tel").val(),
				  url: document.location.href,
				  title: $("title").text(),
				  zvon: 1
			  },
				  
			  function (data)
			  {
				  setTimeout(function (){
					  $(".consultant_unavailable").fadeIn("slow");
					  $(".message_box").fadeOut("slow");
				  },3000);
			  });
	  }
  }

 
 
 
 ;(function($){
	$.fn.superfish = function(op){

		var sf = $.fn.superfish,
			c = sf.c,
			$arrow = $(['<span class="',c.arrowClass,'"> &#187;</span>'].join('')),
			over = function(){
				var $$ = $(this), menu = getMenu($$);
				clearTimeout(menu.sfTimer);
				$$.showSuperfishUl().siblings().hideSuperfishUl();
			},
			out = function(){
				var $$ = $(this), menu = getMenu($$), o = sf.op;
				clearTimeout(menu.sfTimer);
				menu.sfTimer=setTimeout(function(){
					o.retainPath=($.inArray($$[0],o.$path)>-1);
					$$.hideSuperfishUl();
					if (o.$path.length && $$.parents(['li.',o.hoverClass].join('')).length<1){over.call(o.$path);}
				},o.delay);	
			},
			getMenu = function($menu){
				var menu = $menu.parents(['ul.',c.menuClass,':first'].join(''))[0];
				sf.op = sf.o[menu.serial];
				return menu;
			},
			addArrow = function($a){ $a.addClass(c.anchorClass).append($arrow.clone()); };
			
		return this.each(function() {
			var s = this.serial = sf.o.length;
			var o = $.extend({},sf.defaults,op);
			o.$path = $('li.'+o.pathClass,this).slice(0,o.pathLevels).each(function(){
				$(this).addClass([o.hoverClass,c.bcClass].join(' '))
					.filter('li:has(ul)').removeClass(o.pathClass);
			});
			sf.o[s] = sf.op = o;
			
			$('li:has(ul)',this)[($.fn.hoverIntent && !o.disableHI) ? 'hoverIntent' : 'hover'](over,out).each(function() {
				if (o.autoArrows) addArrow( $('>a:first-child',this) );
			})
			.not('.'+c.bcClass)
				.hideSuperfishUl();
			
			var $a = $('a',this);
			$a.each(function(i){
				var $li = $a.eq(i).parents('li');
				$a.eq(i).focus(function(){over.call($li);}).blur(function(){out.call($li);});
			});
			o.onInit.call(this);
			
		}).each(function() {
			var menuClasses = [c.menuClass];
			if (sf.op.dropShadows  && !($.browser.msie && $.browser.version < 7)) menuClasses.push(c.shadowClass);
			$(this).addClass(menuClasses.join(' '));
		});
	};

	var sf = $.fn.superfish;
	sf.o = [];
	sf.op = {};
	sf.IE7fix = function(){
		var o = sf.op;
		if ($.browser.msie && $.browser.version > 6 && o.dropShadows && o.animation.opacity!=undefined)
			this.toggleClass(sf.c.shadowClass+'-off');
		};
	sf.c = {
		bcClass     : 'sf-breadcrumb',
		menuClass   : 'sf-js-enabled',
		anchorClass : 'sf-with-ul',
		arrowClass  : 'sf-sub-indicator',
		shadowClass : 'sf-shadow'
	};
	sf.defaults = {
		hoverClass	: 'sfHover',
		pathClass	: 'overideThisToUse',
		pathLevels	: 1,
		delay		: 800,
		animation	: {opacity:'show'},
		speed		: 'normal',
		autoArrows	: true,
		dropShadows : true,
		disableHI	: false,		// true disables hoverIntent detection
		onInit		: function(){}, // callback functions
		onBeforeShow: function(){},
		onShow		: function(){},
		onHide		: function(){}
	};
	$.fn.extend({
		hideSuperfishUl : function(){
			var o = sf.op,
				not = (o.retainPath===true) ? o.$path : '';
			o.retainPath = false;
			var $ul = $(['li.',o.hoverClass].join(''),this).add(this).not(not).removeClass(o.hoverClass)
					.find('>ul').hide().css('visibility','hidden');
			o.onHide.call($ul);
			return this;
		},
		showSuperfishUl : function(){
			var o = sf.op,
				sh = sf.c.shadowClass+'-off',
				$ul = this.addClass(o.hoverClass)
					.find('>ul:hidden').css('visibility','visible');
			sf.IE7fix.call($ul);
			o.onBeforeShow.call($ul);
			$ul.animate(o.animation,o.speed,function(){ sf.IE7fix.call($ul); o.onShow.call($ul); });
			return this;
		}
	});

})(jQuery);