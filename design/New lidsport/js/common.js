var url = location.href,
		url_array = url.split('='),
		default_phone = '8-8652-22-15-77',
		default_link = '+78652221577',
		utm_phone = '8-8652-22-15-67',
		utm_link = '+78652221567';

if (url_array[1] == 'priceUp&_openstat') {
	$.cookie('utm', 'true');
}

//Slide filter
function slideValue(minPrice, maxPrice, currentMinPrice, currentMaxPrice) {

	$('.filter__slider').slider({
		range: true,
		min: minPrice,
		max: maxPrice,
		values: [currentMinPrice, currentMaxPrice],
		slide: function(event, ui) {
			currentMinPrice = ui.values[0];
			currentMaxPrice = ui.values[1];
			$('#minCost').val(currentMinPrice);
			$('#maxCost').val(currentMaxPrice);
		}
	});
}

//Quantity product
function quantity() {
  var count,
      totalPrice = 0;

  $('.number__reduce').on('click', function() {
    var section = $(this).closest('.number'),
        count = Number(section.find('.number__value').html());

    if (count > 1) {
      section.find('.number__value').val(count);
      section.find('.number__value').html(count - 1);
    }
  });

  $('.number__add').on('click', function() {
    var section = $(this).closest('.number'),
        count = Number(section.find('.number__value').html());

    section.find('.number__value').val(count);
    section.find('.number__value').html(count + 1);
  });
}

// Choose
function choose() {
  $('.catalog--choose').on('click', function(e) {
    e.preventDefault();
    var id = $(this).attr("product");

    $.ajax({
      url: "/price/productInCatalog.php",
      type: "GET",
      data: {
        "productId" : id,
      },
      success: function(data) {
        $('.p-choose__content').html(data);
        $('.p-choose').arcticmodal();
      }
    });

    return false;
  });
}

// Add to cart
function addToCart() {
  $('form.tocart').on('submit', function(e) {
    e.preventDefault();

    var form = $(this).closest('form'),
        amount1 = Number(form.find('.number__value').html());

    button = $(this).find('input[type="submit"]');

    if ($(this).find('input[name=variant]:checked').size() > 0) {
      variant = $(this).find('input[name=variant]:checked').val();
    }

    if ($(this).find('select[name=variant]').size() > 0) {
      variant = $(this).find('select').val();
    }

    $.ajax({
      url: "ajax/cart.php",
      data: {variant: variant,amount:amount1},
      dataType: 'json',
      success: function(data) {
        $('#cart_informer').html(data);
        if (button.attr('data-result-text')) {
          button.val(button.attr('data-result-text'));
        }
        $('.p-add').arcticmodal();
      }
    });

    var o1 = $(this).offset();
    var o2 = $('#cart_informer').offset();
    var dx = o1.left - o2.left;
    var dy = o1.top - o2.top;
    var distance = Math.sqrt(dx * dx + dy * dy);

    $(this).closest('.product').find('.img img').effect("transfer", { to: $(".icons_cart"), className: "transfer_class" }, distance); 
    $('.transfer_class').html($(this).closest('.product').find('.img').html());
    $('.transfer_class').find('img').css('height', '100%');

    return false;
  });
}

$(document).ready(function() {
  quantity();
  choose();
  addToCart();

  //phone
  var header_phone = $('.header__phone'),
  		contact_phone = $('.map__link'),
  		footer_phone= $('.footer__phone');


  console.log($.cookie('utm'));
  if ($.cookie('utm') == 'true') {
  	header_phone.html(utm_phone);
  	header_phone.attr('href', utm_link);
  	contact_phone.html(utm_phone);
  	contact_phone.attr('href', utm_link);
  	footer_phone.html(utm_phone);
  	footer_phone.attr('href', utm_link);
  }

	//Phone mask
	$('[name="phone"]').inputmask({'mask': '+7 (999) 999-99-99'});

	//Form styler
	$('select').styler();

	//Slider
	$('.slider').slick({
		slidesToShow: 1,
		slidesToScroll: 1,
		fade: true,
		draggable: false,
		arrows: false,
		dots: true,
		dotsClass: 'slider__dots',
		autoplay: true,
		autoplaySpeed: 5000,
		responsive: [{
			breakpoint: 768,
			settings: {
				dots: false,
				fade: false
			}
		}]
	});

	$('.bought__slider').slick({
		slidesToShow: 4,
		slidesToScroll: 1,
		arrows: false,
		dots: true,
		dotsClass: 'bought__dots',
		autoplay: true,
		autoplaySpeed: 5000,
		responsive: [{
			breakpoint: 1200,
			settings: {slidesToShow: 2,}
		}, {
			breakpoint: 768,
			settings: {slidesToShow: 1,}
		}]
	});

	//Popups
	$('[data-size-path]').on('click', function() {
		var path = $(this).data('size-path');

		$('.p-size__image').attr('src', path);
	});

	$('[data-popup-button]').on('click', function() {
		var popup = $(this).data('popup-button');

		$.arcticmodal('close');
		$('[data-popup-block="'+ popup +'"]').arcticmodal();

		// return false;
	});

	//Menu mobile
	$('.header__button').on('click', function() {
		$(this).toggleClass('active');
		$('.m-menu').toggleClass('active');
		$('.header__overlay').toggleClass('active');
		$('body').css('overflow', 'hidden');
	});

	$('.m-menu__close').on('click', function() {
		$('.m-menu').removeClass('active');
		$('.header__button').removeClass('active');
		$('.header__overlay').toggleClass('active');
		$('body').css('overflow', 'inherit');
	});

	$('.header__overlay').on('click', function() {
		$('.m-menu').removeClass('active');
		$('.header__button').removeClass('active');
		$('.header__overlay').removeClass('active');
		$('body').css('overflow', 'inherit');
	});

	$('.m-menu__caption').on('click', function() {
		x = $(this).find('.m-menu__arrow').data('active');

		if (x == 'true') {
			$(this).find('.m-menu__arrow').removeClass('active').data('active', '');
			$(this).next('.m-menu__navigation').slideUp('500');
		} else {
			$('.m-menu__arrow').removeClass('active').data('active', '');
			$('.m-menu__navigation').slideUp('500');
			$(this).find('.m-menu__arrow').addClass('active').data('active', 'true');
			$(this).next('.m-menu__navigation').slideDown('500');
		}

		return false;
	});

	//Filter
	$('.filter__title--mobile').on('click', function() {
		$(this).toggleClass('active').next('.filter__dropdown').slideToggle('600');
	});

	//Price slider
	var minPrice = parseInt($('#minprice').val()),
			maxPrice = parseInt($('#maxprice').val()),
			currentMinPrice = parseInt($('#current_minprice').val()),
			currentMaxPrice = parseInt($('#current_maxprice').val());

	$('#minCost').val(currentMinPrice);
	$('#maxCost').val(currentMaxPrice);

	slideValue(minPrice, maxPrice, currentMinPrice, currentMaxPrice);

	$('#minCost, #maxCost').bind("change keyup input click", function(e) {
		if (this.value.match(/[^0-9]/g)) {
			this.value = this.value.replace(/[^0-9]/g, '');
		}

		if (e.keyCode === 13) {
			$(this).blur();
		}
	});

	$('#minCost, #maxCost').focusout(function() {
		currentMinPrice = Number($('#minCost').val());
		currentMaxPrice = Number($('#maxCost').val());

		// slideValue(currentMinPrice, currentMaxPrice);
	});

	$('.filter__slider').on('click', function() {
		$('#minCost').val($(".filter__slider").slider("values", 0));
		$('#maxCost').val($(".filter__slider").slider("values", 1));
	});

	//Select brand
	$('.filter__brend select').change(function() {
		var link = $(this).find('option:selected').val();

		$(location).attr('href', link);
	});

	//Mobile search button
	$('.search-ico').on('click', function() {
		$('.header__search').toggleClass('active');
	});

	// Search autocomplete
	$(".search__input").autocomplete({
		serviceUrl: '/ajax/search_products.php',
		minChars: 1,
		noCache: false, 
		deferRequestBy: 400,
		onSelect:
		function(suggestion){
			$(".search__input").closest('form').submit();
		},
		formatResult:
		function(suggestion, currentValue){
			var reEscape = new RegExp('(\\' + ['/', '.', '*', '+', '?', '|', '(', ')', '[', ']', '{', '}', '\\'].join('|\\') + ')', 'g'),
					pattern = '(' + currentValue.replace(reEscape, '\\$1') + ')';

			return suggestion.value.replace(new RegExp(pattern, 'gi'), '<strong>$1<\/strong>');
		}
	});

	// Installments popup
	$('[data-popup-button="installments"]').on("click", function(e) {
		e.preventDefault();

		$.ajax({
			url: "/price/rasrochka.php",
			type: "GET",
			data: {},
			success: function(data){
				$('.p-installments__info').html(data);
			}
		});

		return false;
	});

	//Accordion
  $('.accordion__item').on('click', function() {
    var num = $(this).data('accordion-menu');

    $('.accordion__tab').removeClass('active');
    $('[data-accordion-tab="'+ num +'"]').addClass('active');
  });

	//Send form
	$('[name="send"]').on('click', function(e) {
		e.preventDefault();

		var form = $(this).closest('form'),
				inpName = form.find('[name="name"]'),
				valName = inpName.val();
				inpPhone = form.find('[name="phone"]'),
				valPhone = inpPhone.val(),
				valItem = $('.card__title').html();
				message = $('.p-message__text'),
				textMessage = '';

		if (valName == '') {
			textMessage = 'Введите имя';
			message.html(textMessage);
			$('.p-message').arcticmodal();
		} else if (valPhone == '') {
			textMessage = 'Введите номер телефона';
			message.html(textMessage);
			$('.p-message').arcticmodal();
		} else {
			textMessage = 'Спасибо за заявку!<br> В ближайшее время с Вами свяжутся.';
			message.html(textMessage);
			$.ajax({
				type: 'POST',
				url: '/send.php',
				data: {
					'name': valName,
					'phone': valPhone,
					'item': valItem
				},
				success: function(data) {
					$.arcticmodal('close');
					$('.p-message').arcticmodal();
					inpName.val('');
					inpPhone.val('');
				}
			});
		}
	});

});