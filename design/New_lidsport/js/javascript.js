$(function() {
	$( ".calck table tr" ).each(function(r) {
	  $(this).find("td").each(function (i) {
		 if (i>0)	{
			 $(this).addClass("pr_tut niceCheck");
			 $(this).prepend('<input style="display:none" type="checkbox"> <span></span>');
			 $(this).append('<em>руб</em>');
			 var price = $(this).find("i").text();
			 $(this).find("i").text(moneyFormat(Math.ceil(price*cur_eur)));
		 } 
	  });
	});
	setTimeout("go_inputs",1500); 
	
	$(".characterization li").click(function() {
		$(".characterization li").removeClass("activ3");
		$(this).addClass("activ3");
		
		$(".info2 > div").removeClass("active");
		$(".info2 .in_tb"+$(this).attr("rel")).addClass("active");
  	}); 
});



var sum = 0;

$(function() 
{
	price_itog();
});
function price_itog	()
{
	var cou = 0;
	sum = 0;
	$('.calck input:checked').each(function(){	
		cou++;
		var val=0;
		var item = $(this).closest('.niceCheck');
		val = item.find('i').text().replace(" ", "")*1;
		sum = sum + val;
	});
	
	if (sum>0) {$(".cal_n").show(); $(".stoim strong").text(moneyFormat(sum));}
	else {$(".cal_n").hide();}
}



	function go_inputs (){
			jQuery(".niceCheck").mousedown(
			function() {
				 changeCheck(jQuery(this));
				 price_itog();
			});
			
			
			jQuery(".niceCheck").each(
			function() {
				 changeCheckStart(jQuery(this));
			});
	}
		
	function changeCheck(el)
	{
		 var el = el,
		input = el.find("input").eq(0);
		 if(!input.attr("checked")) {
			el.find("span").eq(0).css("background-position","0 -19px");
			input.attr("checked", true);
			
		} else {
			el.find("span").eq(0).css("background-position","0 0");	
			input.attr("checked", false)
		}
		 return true;
	}
	
	function changeCheckStart(el)
	{
		var el = el,
		input = el.find("input").eq(0);
		  if(input.attr("checked")) {
			el.find("span").eq(0).css("background-position","0 -19px");
		}
		 return true;
	}
		
  function moneyFormat(n) {
	  var s = String(n);
	  var k = s.indexOf('.');
	  if (k < 0) {
		  k = s.length;
		  // s += '.00';
	  }
	  else {
		  // s += '00';
	  }
	  s = s.substr(0, k + 3);
	  for (var i = k - 3, j = n < 0 ? 1 : 0; i > j; i -= 3) s = s.substr(0, i) + ' ' + s.substr(i);
	  return s;
  }
  
  
  
  /* проверка формы и отправка ее */
  function valid_Int(o) {
	  var Int2552 = /^([0-9_\-\. \/\\]{1,250})+$/;
	  if (o.match(Int2552)) {
		  return false;
	  } else {
		   return true;
	  }
  }
  function valid_email(o) {
		var email  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
		 if (o.match(email)) {
			return false;
		  } else {
			return true;
		  }
  }
  
  
  function post_oza(kom)
  {
	  var oki = 0;
	  if ($(".oza_name").val().length < 2)
	  {
		  $("#erro_home_kredit").show().html("Укажите свое Имя!");
		  oki = 1;
	  }
	  else if ($(".oza_cit").val().length < 2)
	  {
		  $("#erro_home_kredit").show().html("Укажите свой город!");
		  oki = 1;
	  }
	  else if (valid_Int($(".oza_kol").val()))
	  {
		  $("#erro_home_kredit").show().html("Укажите количество!");
		  oki = 1;
	  }
	  else if (valid_Int($(".oza_tel").val()))
	  {
		  $("#erro_home_kredit").show().html("Укажите телефон!");
		  oki = 1;
	  }

	  
	  if (oki == 0)
	  {
		  $("#erro_home_kredit").hide();
		  $("#success_home_kredit").show();
		  
		  $.post(
			  "/ajax/mail.php",
			  {
				  type: "text/plain",
				  name: $(".oza_name").val(),
				  city: $(".oza_cit").val(),
				  kol: $(".oza_kol").val(),
				  tel: $(".oza_tel").val(),
				  url: document.location.href,
				  title: $("title").text(),
				  kom: kom
			  },
				  
			  function (data)
			  {
				  setTimeout('close_hh_block("myModal2")',3000);
			  });
	  }
	  
	  $("#myModal2").height(388);
  }
  
 
  

  
  function post_zvon()
  {
	  var oki = 0;
	  if ($(".ozb_name").val().length < 2)
	  {
		  $("#erro_2").show().html("Укажите свое Имя!");
		  oki = 1;
	  }
	  if ($(".ozb_com").val().length < 2)
	  {
		  $("#erro_2").show().html("Напишите комментарий!");
		  oki = 1;
	  }
	  else if (valid_Int($(".ozb_tel").val()))
	  {
		  $("#erro_2").show().html("Укажите телефон!");
		  oki = 1;
	  }

	  
	  if (oki == 0)
	  {
		  $("#erro_2").hide();
		  $("#success_2").show();
		  
		  $.post(
			  "/ajax/mail.php",
			  {
				  type: "text/plain",
				  name: $(".ozb_name").val(),
				  oz_comment: $(".ozb_com").val(),
				  tel: $(".ozb_tel").val(),
				  email: $(".ozb_email").val(),
				  url: document.location.href,
				  title: $("title").text(),
				  zvon: 1
			  },
				  
			  function (data)
			  {
				  setTimeout('close_hh_block("myModal")',3000);
			  });
	  }
	  
	  $("#myModal").height(357);
  }

  function close_hh_block(vala)
  {
	  $('#'+vala).hide();
	  $('.modal-backdrop').hide();
  }

function calck_zacaz()
{
	  var oki = 0;
	  if ($(".oza_name").val().length < 2)
	  {
		  $("#erro_home_kredit").show().html("Укажите свое Имя!");
		  oki = 1;
	  }
	  else if ($(".oza_cit").val().length < 2)
	  {
		  $("#erro_home_kredit").show().html("Укажите свой город!");
		  oki = 1;
	  }
	  else if (valid_Int($(".oza_tel").val()))
	  {
		  $("#erro_home_kredit").show().html("Укажите телефон!");
		  oki = 1;
	  }

	  
	  if (oki == 0)
	  {
		  $("#erro_home_kredit").hide();
		  $("#success_home_kredit").show();
		  $(".calck input").show();
		  $(".calck table").attr("border",1);
		  var texta = $(".calck").html();
		  $(".calck table").attr("border",0);
		  $(".calck input").hide();
		  
		  $.post(
			  "/ajax/mail.php",
			  {
				  type: "text/plain",
				  name: $(".oza_name").val(),
				  city: $(".oza_cit").val(),
				  tel: $(".oza_tel").val(),
				  url: document.location.href,
				  title: $("title").text(),
				  kom: texta.replace('border="0"', ""),
				  kalk: 1
			  },
				  
			  function (data)
			  {
				  setTimeout('close_hh_block("myModal3")',3000);
			  });
	  }
	  
	  $("#myModal3").height(388);
}


$(function() {
	$(".ul_city li").mouseenter(function() {
		var at = $(".ct_"+$(this).attr("rel")).attr("it");
		var al = $(".ct_"+$(this).attr("rel")).attr("il");

		/* получить высоту блока animform_start */
		var he_ani = $(".animform_start").height();
		
		$(".animform_start div").html($(".ct_"+$(this).attr("rel")+" td").eq(2).html());
		$(".animform_start").css({top:(at-(he_ani/2)-12)+"px",left:(al*1+9)+"px"}).show().addClass("animform");
	});
	
	$(".city").mouseenter(function() {
		var at = $(".ct_"+$(this).attr("rel")).attr("at");
		var al = $(".ct_"+$(this).attr("rel")).attr("al");

		$(".animform_start").css({top:at+"px",left:al+"px"}).show().addClass("animform");
		/* .addClass("animform") */
		/*
			.css("left",$(".ct_"+$(this).attr("rel")).attr("al"))
		*/
		
		$(".animform_start div").html($(".ct_"+$(this).attr("rel")+" td").eq(2).html());
		
		// .replace(" ", "")*1;
	}).mouseleave(function() {
		// $(".animform_start").removeClass("animform");
	});
	$(".bg_map").mouseenter(function() { 
		$(".animform_start").removeClass("animform").hide();
	});
});


jQuery(document).ready(function($){
    var deviceAgent = navigator.userAgent.toLowerCase();
    var agentID = deviceAgent.match(/(iphone|ipod|ipad)/);
    if (agentID) {
		$(".flash_apid").hide();
        // mobile code here
 
    }
});

