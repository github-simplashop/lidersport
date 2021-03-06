var url = location.href,
        url_array = url.split('&'),
        default_phone = '8-8652-22-15-77',
        default_link = '+78652221577',
        utm_phone = '8-8652-99-00-59',
        default_phone = '8-8652-22-15-77',
        utm_link = '+78652990059';

url_array.forEach(function (item, i, url_array) {
    if (item.match(/utm_source/i)) {
        $.cookie('utm', 'true', { expires: 365 });
        $.cookie('utm_path', url, { expires: 365 });
    }
    else {

    }
    i++;
});

if($.cookie('city')) {
    $('.header__town').html($.cookie('city'));
}
else {
    $('.header__town').html($.cookie('city'));
}

//if ($.cookie('utm') == 'true') {

  //  change_phone(utm_phone, utm_link);
//}

$( document ).ready(function () {

    $(".owl-carousel__product").owlCarousel({
        items: 1,
        dots: false,
        slideSpeed: 2000,
        autoplay: false,
        nav: true,
        navText: ['<i class="fa fa-angle-left" aria-hidden="true"></i>','<i class="fa fa-angle-right" aria-hidden="true"></i>'],
        loop: true,
        responsiveBaseWidth: '.owl-carousel__product'
    });


   /* $('.p-sale-5-percents__button').on('click', function() {
        var popup = "sale-5-percents";
        $('[data-popup-block="'+ popup +'"]').arcticmodal('close');
    })

    $('.p-choice-city__body').on("click", "#city__yes", function () {
        if (!$.cookie('sale-5-percents')) {
            var popup = "sale-5-percents";
            setTimeout(function() {
                $('[data-popup-block="'+ popup +'"]').arcticmodal();
                $.cookie('sale-5-percents', 'first', { expires: 30 });
            }, 2000);
        }
    });*/

/* start --- Комментарии к товару --- */

    var aver_rating_val = 0;
    var aver_rating_count = 0;

    $('.comment__score').each(function() {
        var rating_val = $(this).data("score");

        $(this).raty({
            readOnly: true,
            score: function() {
                return $(this).attr('data-score');
            },
            hints: ['Ужасно', 'Плохо', 'Неплохо', 'Очень хорошо', 'Отлично']
        });

        aver_rating_count ++;
        aver_rating_val += rating_val;

        var inputValue = aver_rating_val / (aver_rating_count * 5) * 5;

        var decimal = 1;

        inputValue = (Math.ceil(inputValue * 2) / 2).toFixed(decimal);

        $('.aver_rating').raty({
            readOnly: true,
            score: inputValue,
            hints: ['Ужасно', 'Плохо', 'Неплохо', 'Очень хорошо', 'Отлично'],
        });

        $('.aver_rating--desc').html("<strong> Общая оценка " + inputValue + " из 5 </strong>");
        $('.aver_rating--count').text(aver_rating_count + " " + declOfNum(aver_rating_count, ['отзыв', 'отзыва', 'отзывов']));
    });

    $('.comment__send').on('click', function() {
        var pattern = /^([a-z0-9_\.-])+@[a-z0-9-]+\.([a-z]{2,4}\.)?[a-z]{2,4}$/i;
        if(($("#comment_name").val()) != 0 && pattern.test($("#comment_email").val()) != false && $(".comment_star input[name='score']").val() != 0 && ($("#comment_text").val()) != 0 && ($("#comment_captcha").val()) != "") {
            $(this).prop({type:"submit"});
        }
        else {
            if ($("#comment_name").val() == 0) {
                $('#comment_name').css({'border' : '1px solid red'});
                $('#comment__pleaseInputName').css({'display' : 'block'});
            }
            if (pattern.test($("#comment_email").val()) == false) {
                $('#comment_email').css({'border' : '1px solid red'});
                $('#comment__pleaseInputEmail').css({'display' : 'block'});
            }
            if ($(".comment_star input[name='score']").val() == 0) {
                $('#comment__pleaseInputRating').css({'display' : 'block'});
            }
            if ($("#comment_text").val() == 0) {
                $('#comment_text').css({'border' : '1px solid red'});
                $('#comment__pleaseInputMessage').css({'display' : 'block'});
            }
            if ($("#comment_captcha").val() == "") {
                $('#comment_captcha').css({'border' : '1px solid red'});
                $('#comment__pleaseInputCaptcha').css({'display' : 'block'});
            }
        }
    });

/* end --- Комментарии к товару --- */

/* start --- Убрать красную подсветку с полей при попытке ввода значения --- */

    $('#comment_name').on('click', function() {
        $('#comment_name').css({'border' : '1px solid #a9a9a9'});
        $('#comment__pleaseInputName').css({'display' : 'none'});
    });

    $('#comment_email').on('click', function() {
        $('#comment_email').css({'border' : '1px solid #a9a9a9'});
        $('#comment__pleaseInputEmail').css({'display' : 'none'});
    });

    $('.comment_star').on('click', function() {
        $('#comment__pleaseInputRating').css({'display' : 'none'});
    });

    $('#comment_text').on('click', function() {
        $('#comment_text').css({'border' : '1px solid #a9a9a9'});
        $('#comment__pleaseInputMessage').css({'display' : 'none'});
    });

    $('#comment_captcha').on('click', function() {
        $('#comment_captcha').css({'border' : '1px solid #a9a9a9'});
        $('#comment__pleaseInputCaptcha').css({'display' : 'none'});
    });

/* end --- Убрать красную подсветку с полей при попытке ввода значения --- */

    $('.comment_star').raty({
        number : 5,
    });

    $("#scroll__reviews").click(function () {
        $("#scroll__reviews").mPageScroll2id();
        $('.accordion__item, .accordion__tab').each(function() {
            $(this).removeClass('active');
        });
        $('#accordion__reviews, .accordion__tab__2').toggleClass('active');
    });

    $("#scroll__delivery, #scroll__delivery_how").click(function () {
        $("#scroll__delivery, #scroll__delivery_how").mPageScroll2id();
        $('.accordion__item, .accordion__tab').each(function() {
            $(this).removeClass('active');
        });
        $('#accordion__delivery, .accordion__tab__3').toggleClass('active');
    });
    

    $(".aver_rating__button--a").mPageScroll2id();

/* start --- Галерея изображений + zoom --- */

    $("#zoom").elevateZoom({
        zoomType: 'inner',
        gallery: 'gallery_zoom',
        cursor: 'crosshair',
        galleryActiveClass: "active",
        imageCrossfade: true,
        loadingIcon: "/design/New_lidsport/images/loading_spinner.gif",
    });

    // $("#zoom").bind("click", function (e) {
    //     var ez = $('#zoom').data('elevateZoom');
    //     // ez.closeAll(); //NEW: This function force hides the lens, tint and window
    //     // $.fancybox(ez.getGalleryList());
    //     return false;
    // });

    $(".elevatezoom-gallery").bind("click", function () {

        $(".elevatezoom-gallery").each(function () {
            $(this).attr({
                'class': 'elevatezoom-gallery'
            });
            $(this).parent().removeClass("active");
        });

        $(this).toggleClass("active");
        $(this).parent().toggleClass("active");

    });

/* end --- Галерея изображений + zoom --- */

/* start --- Popup youtube видео "Ёлки искусственные" --- */

    $('#popup__eli').click(function() {
        $('.p-youtube-video__body').html('<iframe src="https://www.youtube.com/embed/YnZhMY01r_M" frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen></iframe>')
        $.arcticmodal('close');
        $('.p-youtube-video').arcticmodal();
    });

/* end --- Popup youtube видео "Снегокаты" --- */

/* start --- Popup youtube видео "Ёлки искусственные" --- */

    $('#popup__snegokaty').click(function() {
        $('.p-youtube-video__body').html('<iframe src="https://www.youtube.com/embed/vwU6AeADIUY" frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen></iframe>')
        $.arcticmodal('close');
        $('.p-youtube-video').arcticmodal();
    });

    /* end --- Popup youtube видео "Ёлки искусственные" --- */

/* start --- Popup youtube видео "Санки и ледянки" --- */

    $('#popup__sanki').click(function() {
        $('.p-youtube-video__body').html('<iframe src="https://www.youtube.com/embed/UjtZD4x-S04" frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen></iframe>')
        $.arcticmodal('close');
        $('.p-youtube-video').arcticmodal();
    });

/* end --- Popup youtube видео "Санки и ледянки" --- */

    ymaps.ready(function() {

        var city_for_delivery = "";

        if($("div").is("#deliverie_map")) {

            window.scrollTo(0, 0);

            var myMap = new ymaps.Map('deliverie_map', {
                center: [45.0446, 41.9714],
                zoom: 16
            });

            myMap.behaviors.disable('scrollZoom');

            $('.cart__deliverie').css({
                'display' : 'none',
                'opacity' : '1',
                'height' : 'auto',
            });

            $('.accordion__tab__3').removeClass("map");


        }


        $(".header__town").bind("DOMSubtreeModified", function () {
            var city_for_delivery = $('.header__town').text();

            $('.page__delivery__city').text(city_for_delivery);

            if (city_for_delivery == "Ставрополь") {
                $('.header__adress').text("Адреса магазинов");
                $('.header__time').text("ждем звонки с 9:00 до 20:00");
                $('.footer__time').text("ждем звонки с 9:00 до 20:00");
                $('.page__delivery__days').text("1-2");
                $('.page__delivery__days__courier').text("1-2");
                $('.page__delivery__cost').text("Стоимость доставки по Ставрополю - 150 рублей. При заказе на сумму от 2900 рублей и выше - доставка бесплатно.");
                $('.contact__caption__text').text('Магазины "Лидерспорт" в г. ');
                $('.contact__caption__city').text(city_for_delivery);

                if ($.cookie('utm') == 'true') {
                    var phone = "8-8652-99-00-59",
                        link = "+78652990059";
                    //change_phone(phone, link);
                }
                else {
                    var phone = "8-8652-22-15-77",
                        link = "+78652221577";
                        //change_phone(phone, link);
                }

            }
            else {
                $('.header__adress').text("Контакты");
                $('.header__time').text("звонок бесплатный с 9:00 до 20:00 (мск)");
                $('.footer__time').text("звонок бесплатный с 9:00 до 20:00 (мск)");
                $('.page__delivery__days').text("2-4");
                $('.page__delivery__cost').text("Стоимость доставки в среднем 500-1000 рублей (уточняется у менеджера).");
                $('.contact__caption__text').text('Пункты выдачи "Лидерспорт" в г. ');
                $('.contact__caption__city').text(city_for_delivery);

                var phone = "8-8652-99-00-59",
                    link = "+78005119133";
                //change_phone(phone, link);
            }

            if($("div").is("#deliverie_map") && city_for_delivery != "") {
                getshops(city_for_delivery, myMap);
            }

            //Расчет стоимости DPD

            if($("div").is(".card")) {
                if (city_for_delivery != "") {
                    var city = city_for_delivery;
                    var shops_count = $(".shops__item").length;
                    if(city_for_delivery == "Ставрополь") {
                        $('.card__delivery__date--value').text("завтра до двери");
                        $('.card__delivery__shops--value').text("сегодня из " + shops_count + " " + declOfNum(shops_count, ['магазина', 'магазинов', 'магазинов']));

                        $('.special-text').hover(
                            function () {
                                $('.special-text__tooltip').css({"visibility": "hidden", "opacity": "0"});
                                $('.special-text__tooltip--stavropol').css({"visibility": "visible", "opacity": "1"});
                            },
                            function () {
                                $('.special-text__tooltip').css({"visibility": "hidden ", "opacity": "0"});
                                $('.special-text__tooltip--stavropol').css({"visibility": "hidden ", "opacity": "0"});
                        });
                    }
                    else {
                        if($('#packing_params').text() != "" && $('#packing_weight').text() != "") {
                            var params = $('#packing_params').text().split('x');

                            var weight = $('#packing_weight').text().trim();
                            var length = params[0].trim();
                            var width = params[1].trim();
                            var height = params[2].trim();

                            // console.log(city + " " + weight + " " + height + " " + width + " " + length);
                            $.ajax({
                                url: "/php/DPD/delivery_cost.php",
                                type: "POST",
                                data: {
                                    city: city,
                                    weight: weight,
                                    height: height,
                                    width: width,
                                    length: length
                                },
                                success: function (data) {
                                    if (data != "disallow") {
                                        var data = jQuery.parseJSON(data);
                                        var shops_count = $(".shops__item").length;
                                        $('.card__delivery__date--value').text(data.days + 1 + " " + declOfNum(data.days + 1, ['день', 'дня', 'дней']));
                                        $('.card__delivery__date--cost').text(data.cost);
                                        $('.card__delivery__shops--value').text("из " + shops_count + " " + declOfNum(shops_count, ['пункта', 'пунктов', 'пунктов']) + " выдачи");


                                        $('.special-text').hover(
                                            function () {
                                                $('.special-text__tooltip').css({"visibility": "visible", "opacity": "1"});
                                                $('.special-text__tooltip--stavropol').css({"visibility": "hidden", "opacity": "0"});
                                            },
                                            function () {
                                                $('.special-text__tooltip').css({"visibility": "hidden ", "opacity": "0"});
                                                $('.special-text__tooltip--stavropol').css({"visibility": "hidden", "opacity": "0"});
                                            });

                                        // console.log(data);
                                    }
                                    else {
                                        // var phone = $('.header__phone:first').text();
                                        $('.card__delivery__date--value').text("уточняйте по телефону");
                                        $('.card__delivery__shops--value').text("уточняйте по телефону");

                                        $('.special-text').hover(
                                            function () {
                                                $('.special-text__tooltip').css({"visibility": "hidden", "opacity": "0"});
                                                $('.special-text__tooltip--stavropol').css({"visibility": "hidden", "opacity": "0"});
                                            },
                                            function () {
                                                $('.special-text__tooltip').css({"visibility": "hidden ", "opacity": "0"});
                                                $('.special-text__tooltip--stavropol').css({"visibility": "hidden", "opacity": "0"});
                                        });
                                        // console.log(data);
                                    }
                                }
                            });
                        }
                        else {
                            // var phone = $('.header__phone:first').text();
                            $('.card__delivery__date--value').text("уточняйте по телефону");
                            $('.card__delivery__shops--value').text("уточняйте по телефону");

                            $('.special-text').hover(
                                function () {
                                    $('.special-text__tooltip').css({"visibility": "hidden", "opacity": "0"});
                                },
                                function () {
                                    $('.special-text__tooltip').css({"visibility": "hidden ", "opacity": "0"});
                                });
                        }
                    }
                }
            }

            //Расчет стоимости DPD
        });

        $('.header__town').on("click", function () {
            getregions();

            $.arcticmodal('close');
            $('.p-regions').arcticmodal();
        });

        $('.p-choice-city__body').on("click", "#city__no", function () {
            getregions();

            $.arcticmodal('close');
            $('.p-regions').arcticmodal();
        });

        $('.p-regions__body').on('click', '.p-regions__link', function () {
            var region = $(this).attr('href').substring(7);
            $('.p-cities__title').html("<i class='fa fa-long-arrow-left p-regions__back__icon' aria-hidden='true'></i> <a href='#' class='p-regions__back'>" + $(this).text() + "</a>");

            getsities(region);

            $.arcticmodal('close');
            $('.p-cities').arcticmodal();
        });

        $('.p-cities__title').on('click', '.p-regions__back', function () {
            $.arcticmodal('close');
            $('.p-regions').arcticmodal();
        });

        $('.p-cities__body').on('click', '.p-cities__link', function () {

            var city = $(this).text();

            $.cookie('city', city, {path: '/'});

            $('.header__town').html(city);
            $.arcticmodal('close');

            // Показать popap "sale-5-percents"

           /* if (!$.cookie('sale-5-percents')) {
                var popup = "sale-5-percents";
                setTimeout(function() {
                    $('[data-popup-block="'+ popup +'"]').arcticmodal();
                    $.cookie('sale-5-percents', 'first', { expires: 30 });
                }, 2000);
            }*/

            // Показать popap "sale-5-percents"
        });

        $('.p-cities__region-delivery').on('click', function () {
            $.arcticmodal('close');
            $('.p-input-city').arcticmodal();
            $('#city_input').focus();
        });

        $('#city__input-ok').on("click", function () {
            if ($("#city__input").val() == 0) {
                $('#city__input').css({'border': '1px solid red'});
                $('#city__input-alert').css({'display': 'block'});
            }
            else {
                choice_city = $("#city__input").val();
                $('.header__town').html(choice_city);
                $.cookie('city', choice_city, {path: '/'});
                $.arcticmodal('close');
            }
        });

        $('#city__input').on('click', function () {
            $('#city__input').css({'border': '1px solid #ececec'});
            $('#city__input-alert').css({'display': 'none'});
        });

        $('.p-regions__body--open').on('click', function () {

            getregions();

            $.arcticmodal('close');
            $('.p-regions').arcticmodal();
        });

        var pattern = /^([a-z0-9_\.-])+@[a-z0-9-]+\.([a-z]{2,4}\.)?[a-z]{2,4}$/i;
        var patternPhone = /(_)/;
        $("#changeform").on('click', function() {
            if ($("#inputName").val() != 0 && $("#inputPhone").val() != 0 && patternPhone.test($("#inputPhone").val()) == false && $('#inputPers').prop("checked") == true) {
                $.ajax({
                    type: "POST",
                    url: "/php/mail.php",
                    data: {
                        tovar: $('#inputTovar').val(),
                        name: $('#inputName').val(),
                        phone: $('#inputPhone').val()
                    }
                }).done(function() {

                });

                var city_for_delivery = $('.header__town').text();

                // yaCounter36200345.reachGoal('ORDER');

                $(  '.header,' +
                    '.cart__logo,' +
                    '.cart__title,' +
                    '.cart__list,' +
                    '.cart__coupon,' +
                    '.cart__total,' +
                    '.cart__issue'
                ).css({'display' : 'none'});
                $(  '.cart__logo,' +
                    '.cart__phone,' +
                    '.cart__deliverie'
                ).css({'display' : 'block'});

                $('.cart__phone').css({'float':'right'});

                var inputNameVal = $("#inputName").val();
                var inputPhoneVal = $("#inputPhone").val();
                $("#prosloikaName").text(inputNameVal);
                $("#inputNameForm2").val(inputNameVal);
                $("#inputNameForm3").val(inputNameVal);
                $("#inputPhoneForm2").val(inputPhoneVal);
                $("#inputPhoneForm3").val(inputPhoneVal);

                window.scrollTo(0, 0);

                var delivery_address = "";

                $('#inputDelivery_idForm3').val("1");

            }
            else {
                if ($("#inputName").val() == 0) {
                    $('#inputName').css({'border' : '1px solid red'});
                    $('#pleaseInputName').css({'display' : 'block'});
                }
                if (patternPhone.test($("#inputPhone").val()) == true || $("#inputPhone").val() == 0) {
                    $('#inputPhone').css({'border' : '1px solid red'});
                    $('#pleaseInputPhone').css({'display' : 'block'});
                }
                if ($('#inputPers').prop("checked") == false) {
                    $('#pleaseInputPers').css({'display' : 'block'});
                }
            }
        });

        $('#samovyvoz-button').on('mouseover', function() {

            if(delivery_address == 0 && $("#cart__deliverie__metod__1").hasClass("cart__deliverie__metod-item--active")) {
                $(this).css({"cursor" : "no-drop"});
            }
            else {
                $(this).css({"cursor" : "pointer"});
            }
        });

        $('#samovyvoz-button').on('click', function() {

            if(delivery_address != 0 || !$("#cart__deliverie__metod__1").hasClass("cart__deliverie__metod-item--active")) {

                window.scrollTo(0, 0);
                var city = $('.p-regions__body--open').text();
                if(!$("#cart__deliverie__metod__1").hasClass("cart__deliverie__metod-item--active")){
                    $('.cart__deliverie__contacts__right').css({'display' : 'inline-block'});
                    $('#inputCityForm3').val(city);
                }
                else {
                    $('#inputAddressForm3').val(city + ', ' + delivery_address);
                }
                $('.cart__deliverie__inner__step-one, .cart__deliverie__inner__step-tree').removeClass("cart__deliverie__inner--active");
                $('.cart__deliverie__inner__step-two').addClass("cart__deliverie__inner--active");
            }
        });

        $('.cart__deliverie__metod-item').on('click', function() {
            $('.cart__deliverie__metod-item').removeClass("cart__deliverie__metod-item--active");
            $(this).addClass("cart__deliverie__metod-item--active")

            var method_id = $(this).attr('id');
            $('.cart__deliverie__metod__body').css({'display' : 'none'});

            if(method_id == "cart__deliverie__metod__1"){
                $('.cart__deliverie__metod__body__1').css({'display' : 'block'});
                $('#inputDelivery_idForm3').val("1");
            }

            if(method_id == "cart__deliverie__metod__2"){
                $('.cart__deliverie__metod__body__2').css({'display' : 'block'});
                $('#inputDelivery_idForm3').val("2");
            }

            if(method_id == "cart__deliverie__metod__3"){
                $('.cart__deliverie__metod__body__3').css({'display' : 'block'});
                $('#inputDelivery_idForm3').val("3");
            }

            if(method_id == "cart__deliverie__metod__4"){
                $('.cart__deliverie__metod__body__4').css({'display' : 'block'});
                $('#inputDelivery_idForm3').val("4");
            }
        });

        $("#nextOrderForm3").on('click', function() {

            if ($("#inputNameForm3").val() == 0 || $("#inputMailForm3").val() == 0 || $("#inputPhoneForm3").val() == 0 || pattern.test($("#inputMailForm3").val()) == false) {
                validate_delivery_left();
                if(!$("#cart__deliverie__metod__1").hasClass("cart__deliverie__metod-item--active")){
                    validate_delivery_right();
                }
            }
            else if (!$("#cart__deliverie__metod__1").hasClass("cart__deliverie__metod-item--active") && ($("#inputCityForm3").val() == 0 || $("#inputStreetForm3").val() == 0 || $("#inputHomeForm3").val() == 0)) {
                validate_delivery_right();
            }
            else {
                if(!$("#cart__deliverie__metod__1").hasClass("cart__deliverie__metod-item--active")){
                    var city = $(".p-regions__body--open").text(),
                        street = "ул. " + $("#inputStreetForm3").val(),
                        home = "д. " + $("#inputHomeForm3").val(),
                        bloc = "корп. " + $("#inputBlocForm3").val(),
                        apartment = "кв. " + $("#inputApartmentForm3").val();

                    $('#inputAddressForm3').val(city + ', ' + street + ', ' + home + ', ' + bloc + ', ' + apartment);
                }
                $("#nextOrderForm3").prop({type:"submit"});
            }
        });

    });


/* start --- Генерация промокода --- */

/*

    if(!navigator.cookieEnabled || !supports_html5_storage()) {
        alert('Включите cookie для комфортной работы с этим сайтом');
    }
    else {
        url_array.forEach(function (item, i, url_array) {
            if (item.match(/utm_source/i)) {

                if (supports_html5_storage()) {
                    if (localStorage.getItem("promo_d")) {
                        localStorage.setItem("promo_d", "repeat");

                    }
                    else {
                        localStorage.setItem("promo_d", "first");
                    }
                }

                if (!$.cookie('promo_d')) {
                    $.cookie('promo_d', 'first', { expires: 7 });
                }

                // localStorage.setItem("promo_d", "first");
                // $.cookie('promo_d', 'first', { expires: 7 });

                $.ajax({
                    url: "/php/promocodes.php",
                    type: "POST",
                    data: {
                        localStorage: localStorage.getItem("promo_d"),
                        cookie: $.cookie('promo_d'),
                    },
                    success: function (data) {
                        var res = JSON.parse(data);
                        if (res.count > 1) {
                            
                        }
                        else {
                            if(res.promo && res.expire) {
                                var popup = "promo_d";
                                $(".p-promo_d__promocode").text(res.promo);
                                $(".p-promo_d__date").text("Промокод действует до " + res.expire + " г.");

                                $(".p-promo_d__body").css({"display":"block"});
                                $.arcticmodal('close');

                                setTimeout(function() {
                                    $('[data-popup-block="'+ popup +'"]').arcticmodal();
                                }, 2000);
                            }
                        }

                        if (res.cookie == "repeat" && res.localStorage == "repeat") {
                            localStorage.setItem("promo_d", "repeat");
                            $.cookie('promo_d', 'repeat', { expires: 7 });
                        }

                    }
                });
            }
            i++;
        });
    }

    $('[name="send_promo"]').on('click', function(e) {
        var pattern = /^([a-z0-9_\.-])+@[a-z0-9-]+\.([a-z]{2,4}\.)?[a-z]{2,4}$/i;
        if(!pattern.test($(".p-promo_d__input").val())) {
            $('.p-promo_d__input').css({'border':'1px solid red'});
            $('#p-promo_d__pleaseInputEmail').text("Пожалуйста введите корректный E-mail");
            $('#p-promo_d__pleaseInputEmail').css({'display':'block'});
            setTimeout(function() {
                $('.p-promo_d__input').css({'border': '1px solid #ECECEC'});
                $('#p-promo_d__pleaseInputEmail').css({'display':'none'});
            }, 2000);
        }
        else {
            $.ajax({
                url: "/php/mail_promocodes.php",
                type: "POST",
                data: {
                    email: $('.p-promo_d__input').val(),
                    promo: $('.p-promo_d__promocode').text(),
                },
                success: function (data) {
                    if(data == "На данную почту уже высылался промокод!"){
                        $('.p-promo_d__input').css({'border':'1px solid red'});
                        $('#p-promo_d__pleaseInputEmail').text("На эту почту уже высылался промокод!");
                        $('#p-promo_d__pleaseInputEmail').css({'display':'block'});
                        setTimeout(function() {
                            $('.p-promo_d__input').css({'border': '1px solid #ECECEC'});
                            $('#p-promo_d__pleaseInputEmail').css({'display':'none'});
                        }, 2000);
                    }
                    else {
                        $.arcticmodal('close');
                        $('.p-message__text').text(data);
                        $('.p-message').arcticmodal();
                        setTimeout(function() {
                            $.arcticmodal('close');
                        }, 2000);
                    }
                }
            });
        }


    });

*/

/* end --- Генерация промокода --- */

/* start --- Cart.tpl ввод/очистка промокода --- */

    if($("input[name='coupon_code']").val() !== "" || $('.message_error').text() != "") {
        $('.cart__coupon--open').css({'display': 'none'});
        $('.cart__coupon--active').css({'display': 'block'});
    }

    $('.cart__coupon--open').click(function() {
        $('.cart__coupon--open').css({'display': 'none'});
        $('.cart__coupon--active').css({'display': 'block'});
    });

    $('.cart__coupon__apply').click(function() {
        document.cart.submit();
    });

/* end --- Cart.tpl ввод/очистка промокода --- */

/* start --- Убрать красную подсветку с полей при попытке ввода значения --- */

    $('#inputName').on('click', function() {
        $('#inputName').css({'border' : '1px solid #ececec'});
        $('#pleaseInputName').css({'display' : 'none'});
    });

    $('#inputPhone').on('click', function() {
        $('#inputPhone').css({'border' : '1px solid #ececec'});
        $('#pleaseInputPhone').css({'display' : 'none'});
    });

    $('#inputPers').on('click', function() {
        $('#pleaseInputPers').css({'display' : 'none'});
    });

    $('#inputNameForm3').on('click', function() {
        $('#inputNameForm3').css({'border' : '1px solid #ececec'});
        $('#pleaseInputName1').css({'display' : 'none'});
    });

    $('#inputMailForm3').on('click', function() {
        $('#inputMailForm3').css({'border' : '1px solid #ececec'});
        $('#pleaseInputEmail1').css({'display' : 'none'});
    });

    $('#inputPhoneForm3').on('click', function() {
        $('#inputPhoneForm3').css({'border' : '1px solid #ececec'});
        $('#pleaseInputPhone1').css({'display' : 'none'});
    });

    $('#inputCityForm3').on('click', function() {
        $('#inputCityForm3').css({'border' : '1px solid #ececec'});
        $('#pleaseInputCityForm3').css({'display' : 'none'});
    });

    $('#inputStreetForm3').on('click', function() {
        $('#inputStreetForm3').css({'border' : '1px solid #ececec'});
        $('#pleaseInputStreetForm3').css({'display' : 'none'});
    });

    $('#inputHomeForm3').on('click', function() {
        $('#inputHomeForm3').css({'border' : '1px solid #ececec'});
        $('#pleaseInputHomeForm3').css({'display' : 'none'});
    });

/* end --- Убрать красную подсветку с полей при попытке ввода значения --- */

    var inputMailVal2 = $('#inputMailForm3').val();
    $('#prosloikaMail').text(inputMailVal2);

    $("#change-sposob").on('click', function() {
        $('.hidden-order3').css({'display': 'none'});
        $('.hidden-order4').css({'display': 'block'});
    });

    $("#change-form").on('click', function() {
        $('.hidden-order4').css({'display': 'none'});
        $('.hidden-order1').css({'display': 'block'});
    });

// Ордер
    $( "#payment_9").on('click', function() {
        $('#orderNext').css({'display' : 'none'});
        $('#orderEnd').css({'display' : 'block'});
    });
    $( "#payment_10").on('click', function() {
        $('#orderNext').css({'display' : 'block'});
        $('#orderEnd').css({'display' : 'none'});
    });

    $('#orderEnd').on('click', function() {
        $('.hidden-order3').css({'display' : 'none'});
        $('.prosloikaCash').css({'display' : 'block'});
        $('.prosloikaOnline').css({'display' : 'none'});
        setTimeout( 'location="/";', 5000 );
    });
    $('.payOnline').on('click', function() {
        $('.hidden-order3').css({'display' : 'none'});
        $('.prosloikaCash').css({'display' : 'none'});
        $('.prosloikaOnline').css({'display' : 'block'});
        $('.payOnline').prop({type:"submit"});
        setTimeout( "$('.payOnline').click();", 5000 );
    });


/* start --- Вызов функций --- */

    quantity();
    choose();
    addToCart();

/* end --- Вызов функций --- */

/* start --- Валидация полей корзины Step 2 --- */

    function validate_delivery_left() {
        if ($("#inputNameForm3").val() == 0) {
            $('#pleaseInputName1').css({'display' : 'block'});
            $('#inputNameForm3').css({'border' : '1px solid red'});
        }
        if ($("#inputMailForm3").val() == 0 || pattern.test($("#inputMailForm3").val()) == false) {
            $('#pleaseInputEmail1').css({'display' : 'block'});
            $('#inputMailForm3').css({'border' : '1px solid red'});
        }
        if ($("#inputPhoneForm3").val() == 0) {
            $('#pleaseInputPhone1').css({'display' : 'block'});
            $('#inputPhoneForm3').css({'border' : '1px solid red'});
        }
    }

    function validate_delivery_right() {
        if ($("#inputCityForm3").val() == 0) {
            $('#pleaseInputCityForm3').css({'display' : 'block'});
            $('#inputCityForm3').css({'border' : '1px solid red'});
        }
        if ($("#inputStreetForm3").val() == 0) {
            $('#pleaseInputStreetForm3').css({'display' : 'block'});
            $('#inputStreetForm3').css({'border' : '1px solid red'});
        }
        if ($("#inputHomeForm3").val() == 0) {
            $('#pleaseInputHomeForm3').css({'display' : 'block'});
            $('#inputHomeForm3').css({'border' : '1px solid red'});
        }
    }

/* end --- Валидация полей корзины Step 2 --- */

/* start --- Получить список регионов --- */

    function getregions() {
        $('.p-regions__body').css({
            'column-count' : '3'
        });
        $('.p-regions').css({
            'width' : 'auto'
        });

        $.ajax({
            url: "/php/DPD/DPD.php",
            type: "POST",
            data: {

            },
            success: function (data) {
                var data = jQuery.parseJSON(data);

                $('.p-regions__title').text('Выберите свой регион');
                $('.p-regions__body').text('');
                for(i in data.regions) {
                    var name = data.regions[i].region_name;
                    var code = data.regions[i].region_code;
                    $('.p-regions__body').append('<a href="#region' + code + '" class="p-regions__link">' + name + '</a>');

                };
            }
        });
    }

/* end --- Получить список регионов --- */

/* start --- Получить список городов --- */

    function getsities(region) {
        $.ajax({
            url: "/php/DPD/DPD.php",
            type: "POST",
            data: {
                region: region,
            },
            success: function (data) {
                var data = jQuery.parseJSON(data);


                $('.p-cities__body').text('');

                if(data.cities.length == 1) {
                    $('.p-cities__body').css({
                        'column-count' : '1'
                    });
                }
                else if(data.cities.length <= 50) {
                    $('.p-cities__body').css({
                        'column-count' : '2'
                    });
                }
                else {
                    $('.p-cities__body').css({
                        'column-count' : '3'
                    });
                }

                for(i in data.cities) {
                    var name = data.cities[i];
                    $('.p-cities__body').append('<a href="#" class="p-cities__link">' + name + '</a>');
                };
            }
        });
    }

/* end --- Получить список городов --- */

/* start --- Получить список магазинов --- */

    function getshops(city, myMap) {

        $('.p-regions__body--open').text(city);
        myMap.geoObjects.removeAll();
        $('.cart__deliverie__shops__body').text('');
        delivery_address = "";
        // $('#deliverie_map').css({'display' : 'block'});

        var menu = $('<div class="cart__deliverie__shops__list"></div>'),
            collection = new ymaps.GeoObjectCollection(null, { preset: 'islands#icon', iconColor: '#612f87'});

        collection.events.add('click', function (e) {

            // placemark на который кликнули

            var activeGeoObject = e.get('target'),
                regexp = /<strong>(.*)<\/strong>/im,
                body = activeGeoObject.properties.get('balloonContent'),
                out = body.match(regexp);

            $("input[value='"+ out[1] +"'][name='shops']").click();

            var $container = $('.cart__deliverie__shops__body'),
                $scrollTo = $("input[value='"+ out[1] +"'][name='shops']").parent();

            $container.scrollTop(
                $scrollTo.offset().top - $container.offset().top + $container.scrollTop() - 40
            );

        });

        // Добавляем коллекцию на карту.
        myMap.geoObjects.add(collection);

        if (city == "Ставрополь") {

            $('#cart__deliverie__metod__3, #cart__deliverie__metod__4').css({'display':'none'});

            $('.cart__deliverie__shops__title div').text("Выберите магазин или пункт выдачи");

            if($("div").is(".window__product")) {
                var shops = new Array();

                if($('#shop_sclad').text() > 0) {
                    shops.push(
                        {address: "ул. Кулакова, д. 8я", geoCoordinates: {latitude: 45.05349307459068, longitude: 41.91173499999998}}
                    );
                }
                if($('#shop_makarova').text() > 0) {
                    shops.push(
                        {address: "ул. Макарова, д. 26, стр Б", geoCoordinates: {latitude: 45.0646, longitude: 41.9363}}
                    );
                }
                if($('#shop_204').text() > 0) {
                    shops.push(
                        {address: "ул. Серова 486/1", geoCoordinates: {latitude: 45.0334, longitude: 42.0275}}
                    );
                }
                if($('#shop_mira').text() > 0) {
                    shops.push(
                        {address: "ул. Мира 334", geoCoordinates: {latitude: 45.0350, longitude: 41.9521}}
                    );
                }
                if($('#shop_yog').text() > 0) {
                    shops.push(
                        {address: "ул. Тухачевского 20/1", geoCoordinates: {latitude: 45.0148, longitude: 41.9093}}
                    );
                }
                if($('#shop_passaj').text() > 0) {
                    shops.push(
                        {address: "ТЦ Пассаж, 1 этаж", geoCoordinates: {latitude: 45.0503, longitude: 41.9847}}
                    );
                }
                if($('#shop_sclad').text() > 0) {
                    shops.push(
                        {address: "г. Михайловск, ул. Войкова 393/1", geoCoordinates: {latitude: 45.126964074574886, longitude: 42.03277399999998}}
                    );
                }
            }
            else if ($("div").is(".cart")){
                var shop_sclad = new Array();
                var shop_makarova = new Array();
                var shop_204 = new Array();
                var shop_mira = new Array();
                var shop_yog = new Array();
                var shop_passaj = new Array();

                var shop_sclad_min = 1;
                var shop_makarova_min = 1;
                var shop_204_min = 1;
                var shop_mira_min = 1;
                var shop_yog_min = 1;
                var shop_passaj_min = 1;

                for(i =0; i < $('.shop_sclad').length; i++) {
                    if($('.shop_sclad:eq(' + i +')').text() <= shop_sclad_min)
                        shop_sclad_min = $('.shop_sclad:eq(' + i +')').text();

                    shop_sclad.push(
                        $('.shop_sclad:eq(' + i +')').text()
                    );

                    if($('.shop_makarova:eq(' + i +')').text() <= shop_makarova_min)
                        shop_makarova_min = $('.shop_makarova:eq(' + i +')').text();

                    shop_makarova.push(
                        $('.shop_makarova:eq(' + i +')').text()
                    );

                    if($('.shop_204:eq(' + i +')').text() <= shop_204_min)
                        shop_204_min = $('.shop_204:eq(' + i +')').text();

                    shop_204.push(
                        $('.shop_204:eq(' + i +')').text()
                    );

                    if($('.shop_mira:eq(' + i +')').text() <= shop_mira_min)
                        shop_mira_min = $('.shop_mira:eq(' + i +')').text();

                    shop_mira.push(
                        $('.shop_mira:eq(' + i +')').text()
                    );

                    if($('.shop_yog:eq(' + i +')').text() <= shop_yog_min)
                        shop_yog_min = $('.shop_yog:eq(' + i +')').text();

                    shop_yog.push(
                        $('.shop_yog:eq(' + i +')').text()
                    );

                    if($('.shop_passaj:eq(' + i +')').text() <= shop_passaj_min)
                        shop_passaj_min = $('.shop_passaj:eq(' + i +')').text();

                    shop_passaj.push(
                        $('.shop_passaj:eq(' + i +')').text()
                    );
                }

                var shops = new Array();
                if(shop_sclad_min > 0 || shop_makarova_min > 0 || shop_204_min > 0 || shop_mira_min > 0 || shop_yog_min > 0 || shop_passaj_min > 0) {
                    if(shop_sclad_min > 0) {
                        shops.push(
                            {address: "ул. Кулакова, д. 8я", geoCoordinates: {latitude: 45.05349307459068, longitude: 41.91173499999998}}
                        );
                    }
                    if(shop_makarova_min > 0) {
                        shops.push(
                            {address: "ул. Макарова, д. 26, стр Б", geoCoordinates: {latitude: 45.0646, longitude: 41.9363}}
                        );
                    }
                    if(shop_204_min > 0) {
                        shops.push(
                            {address: "ул. Серова 486/1", geoCoordinates: {latitude: 45.0334, longitude: 42.0275}}
                        );
                    }
                    if(shop_mira_min > 0) {
                        shops.push(
                            {address: "ул. Мира 334", geoCoordinates: {latitude: 45.0350, longitude: 41.9521}}
                        );
                    }
                    if(shop_yog_min > 0) {
                        shops.push(
                            {address: "ул. Тухачевского 20/1", geoCoordinates: {latitude: 45.0148, longitude: 41.9093}}
                        );
                    }
                    if(shop_passaj_min > 0) {
                        shops.push(
                            {address: "ТЦ Пассаж, 1 этаж", geoCoordinates: {latitude: 45.0503, longitude: 41.9847}}
                        );
                    }
                    if(shop_sclad_min > 0) {
                        shops.push(
                            {address: "г. Михайловск, ул. Войкова 393/1", geoCoordinates: {latitude: 45.126964074574886, longitude: 42.03277399999998}}
                        );
                    }
                }
                else {
                    shops = [
                        {address: "ул. Кулакова, д. 8я", geoCoordinates: {latitude: 45.05349307459068, longitude: 41.91173499999998}},
                        {address: "ул. Макарова, д. 26, стр Б", geoCoordinates: {latitude: 45.0646, longitude: 41.9363}},
                        {address: "ул. Серова 486/1", geoCoordinates: {latitude: 45.0334, longitude: 42.0275}},
                        {address: "ул. Мира 334", geoCoordinates: {latitude: 45.0350, longitude: 41.9521}},
                        {address: "ул. Тухачевского 20/1", geoCoordinates: {latitude: 45.0148, longitude: 41.9093}},
                        {address: "ТЦ Пассаж, 1 этаж", geoCoordinates: {latitude: 45.0503, longitude: 41.9847}},
                        {address: "г. Михайловск, ул. Войкова 393/1", geoCoordinates: {latitude: 45.126964074574886, longitude: 42.03277399999998}}
                    ];
                }
            }
            else {
                shops = [
                    {address: "ул. Кулакова, д. 8я", geoCoordinates: {latitude: 45.05349307459068, longitude: 41.91173499999998}},
                    {address: "ул. Макарова, д. 26, стр Б", geoCoordinates: {latitude: 45.0646, longitude: 41.9363}},
                    {address: "ул. Серова 486/1", geoCoordinates: {latitude: 45.0334, longitude: 42.0275}},
                    {address: "ул. Мира 334", geoCoordinates: {latitude: 45.0350, longitude: 41.9521}},
                    {address: "ул. Тухачевского 20/1", geoCoordinates: {latitude: 45.0148, longitude: 41.9093}},
                    {address: "ТЦ Пассаж, 1 этаж", geoCoordinates: {latitude: 45.0503, longitude: 41.9847}},
                    {address: "г. Михайловск, ул. Войкова 393/1", geoCoordinates: {latitude: 45.126964074574886, longitude: 42.03277399999998}}
                ];
            }


            for(i in shops) {
                createMapList(shops[i], myMap, collection, menu);
            }

            menu.appendTo($('.cart__deliverie__shops__body'));
            // Выставляем масштаб карты чтобы были видны все группы.

            myMap.setBounds(myMap.geoObjects.getBounds(),{
                checkZoomRange: true
            });
        }
        else
        {

            $('#cart__deliverie__metod__3, #cart__deliverie__metod__4').css({'display':'inline-block'});

            $.ajax({
                url: "/php/DPD/DPD.php",
                type: "POST",
                data: {
                    city: city,
                },
                success: function (data) {
                    var data = jQuery.parseJSON(data);
                    if (data.shops.length != 0) {

                        $('.cart__deliverie__shops__title div').text("Выберите магазин или пункт выдачи");
                        for (i in data.shops) {
                            createMapList(data.shops[i], myMap, collection, menu);
                        }
                        ;

                        menu.appendTo($('.cart__deliverie__shops__body'));
                        // Выставляем масштаб карты чтобы были видны все группы.

                        myMap.setBounds(myMap.geoObjects.getBounds(), {
                            checkZoomRange: true
                        });
                    }
                    else {
                        $('.cart__deliverie__shops__title div').text("В данном населенном пункте отсутвуют пункты выдачи товара");
                        // $('#deliverie_map').css({'display' : 'none'});
                        // $('.cart__deliverie__shops__body').css()
                    }
                }
            });
        }
    }

/* end --- Получить список магазинов --- */

/* start --- Нанести магазины на карту и занести в список --- */

    function createMapList(item, myMap, collection, submenu) {

        if (!item.name) {
            var name = "Магазин «Лидерспорт»";
        }
        else {
            var name = item.name
        }
        var address = item.address;
        var latitude = item.geoCoordinates.latitude;
        var longitude = item.geoCoordinates.longitude;
        if (!item.opentimetable) {
            var opentimetable = "<li>без выходных с 9:00 до 20:00</li>";
        }
        else {
            var opentimetable = "";
            for(g in item.opentimetable) {
                opentimetable += '<li>' + item.opentimetable[g].weekDays + ': ' + item.opentimetable[g].workTime + '</li>';
            }
        }

        if (address == "ул. Кулакова, д. 8я")   {
            name = "Главный офис «Лидерспорт»";
        }
        if (address == "г. Михайловск, ул. Войкова 393/1")   {
            name = "Магазин «Тилибом»";
        }

        var menu = $(
            '<div class="shops__item">' +
            '<input type="radio" name="shops" class="shops__item__radio" id="c' + i + '" value="'+ address +'">' +
            '<label for="c' + i + '">' +
            '<span></span>' +
            '<div class="shops__item__card">' +
            '<div class="shops__item__card__title">' + address + '</div>' +
            '<div class="shops__item__card__name">Пункт выдачи: ' + name + '</div>' +
            '<div class="shops__item__card__time">Время работы:<ul>' + opentimetable + '</ul></div>' +
            '</div>' +
            '</label>' +
            '</div>'
        );

        // Создаем метку.
        var placemark = new ymaps.Placemark([latitude, longitude], {
                balloonContent: "<div><strong>" + address + "</strong></div> <div>Пункт выдачи: " + name + "</div> <div>Время работы:<ul>" + opentimetable +"</ul></div>"
            },
            {
                hideIconOnBalloonOpen: false
            });

        // Добавляем метку в коллекцию.
        collection.add(placemark);
        // Добавляем пункт в подменю.
        menu
            .appendTo(submenu)
            // При клике по пункту подменю открываем/закрываем баллун у метки.
            .find('input')
            .bind('change', function () {
                if (!placemark.balloon.isOpen()) {

                    for (j = 0; j < collection.getLength(); j++) {
                        var currentPm = collection.get(j);
                        currentPm.options.set(
                            'iconColor', '#612f87'
                        );
                    }
                    delivery_address = $(this).val();
                    placemark.balloon.open();
                    placemark.options.set('iconColor', '#db8229');

                } else {
                    myMap.geoObjects.each(function (geoObject) {
                        geoObject.options.set('iconColor', '#612f87');
                    });
                    placemark.balloon.close();
                }
                return false;
            });
    }

/* end --- Нанести магазины на карту и занести в список --- */

/* start --- Слайдер owlCarousel --- */

    $(".owl-carousel").owlCarousel({
        items: 1,
        dots: true,
        autoplay: true,
        autoplayTimeout: 5000,
        slideSpeed: 2000,
        loop: true,
    });

/* end --- Слайдер owlCarousel --- */

    //Phone mask
    $('[name="phone"]').inputmask({'mask': '+7 (999) 999-99-99'});

    //Form styler
    $('.js-select').styler();

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
        autoplaySpeed: 1000,
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

    var productName  = '',
        productPrice = 0;

    $('[data-popup-button]').on('click', function() {
        var popup = $(this).data('popup-button');

        $.arcticmodal('close');
        $('[data-popup-block="'+ popup +'"]').arcticmodal();

        productName  = $(this).parents('.tiny-product').find('.tiny-product__name').text().trim();
        productPrice = $(this).parents('.tiny-product').find('.tiny-product__price').text().trim()
            .replace(/[^0-9^\s\.]/g, '');

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
    $(".search__input, .search__input2").autocomplete({
        serviceUrl: '/ajax/search_products.php',
        minChars: 1,
        noCache: false,
        deferRequestBy: 400,
        onSelect:
            function(suggestion){
                $(this).closest('form').submit();
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

        $('.accordion__item').removeClass('active');
        $('[data-accordion-menu="'+ num +'"]').addClass('active');
    });

    //Send form
    $('[name="send"]').on('click', function(e) {
        e.preventDefault();

        var form     = $(this).closest('form'),
            inpName  = form.find('[name="name"]'),
            valName  = inpName.val(),
            inpPhone = form.find('[name="phone"]'),
            valPhone = inpPhone.val(),
            valItem  = productName ? productName : $('.card__title').html(),
            valPrice = productPrice ? productPrice : $('.product__to-cart .card__new').text().replace(' ', '').trim(),
            message  = $('.p-message__text'),
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
            yaCounter36200345.reachGoal('ONE_CLICK');
            $.ajax({
                type: 'POST',
                url: '/php/mail_one_click.php',
                data: {
                    'name': valName,
                    'phone': valPhone,
                    'item': valItem,
                    'price': valPrice
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

//Проверка наличия у пользователя html5 storage
function supports_html5_storage() {
    try {
        return 'localStorage' in window && window['localStorage'] !== null;
    } catch (e) {
        return false;
    }
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
        $('select').styler();
        $('.p-choose').arcticmodal();
      }
    });

    return false;
  });
}

// Delete from cart

// $('.cart__delete span').on('click', function() {
//     var href = $(this).data("remove");
//
//     $.ajax({
//         url: href,
//         type: "GET",
//         data: {
//
//         },
//         success: function(data) {
//             location.reload();
//         }
//     });
// });

// Add to cart
function addToCart() {
  // $('.products__to-cart').on('submit', function(e) {
  //   e.preventDefault();
  //
  //   var form = $(this).closest('form'),
  //       amount1 = Number(form.find('.number__value').html());
  //
  //   button = $(this).find('input[type="submit"]');
  //
  //   if ($(this).find('input[name=variant]:checked').size() > 0) {
  //     variant = $(this).find('input[name=variant]:checked').val();
  //   }
  //
  //   if ($(this).find('select[name=variant]').size() > 0) {
  //     variant = $(this).find('select').val();
  //   }
  //
  //   $.ajax({
  //     url: "ajax/cart.php",
  //     data: {variant: variant,amount:amount1},
  //     dataType: 'json',
  //     success: function(data) {
  //       $('#cart_informer').html(data);
  //       if (button.attr('data-result-text')) {
  //         button.val(button.attr('data-result-text'));
  //       }
  //       $('.p-add').arcticmodal();
  //     }
  //   });
  //
  //   var o1 = $(this).offset();
  //   var o2 = $('#cart_informer').offset();
  //   var dx = o1.left - o2.left;
  //   var dy = o1.top - o2.top;
  //   var distance = Math.sqrt(dx * dx + dy * dy);
  //
  //   $(this).closest('.product').find('.img img').effect("transfer", { to: $(".icons_cart"), className: "transfer_class" }, distance);
  //   $('.transfer_class').html($(this).closest('.product').find('.img').html());
  //   $('.transfer_class').find('img').css('height', '100%');
  //
  //   return false;
  // });

    $('.product__to-cart, .tocart').on('submit', function(e) {
        e.preventDefault();

        $.arcticmodal('close');

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
            url: "/ajax/cart.php",
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

/* function change_phone (phone, link) {

    var header_phone = $('.header__phone'),
        contact_phone = $('.map__link'),
        contact_phone_all = $('.contact__link'),
        footer_phone= $('.footer__phone');

    header_phone.html(phone);
    header_phone.attr('href', link);
    contact_phone.html(phone);
    contact_phone.attr('href', link);
    contact_phone_all.html(phone);
    contact_phone_all.attr('href', link);
    footer_phone.html(phone);
    footer_phone.attr('href', link);
} */

function declOfNum(number, titles) {
    cases = [2, 0, 1, 1, 1, 2];
    return titles[ (number%100>4 && number%100<20)? 2 : cases[(number%10<5)?number%10:5] ];
}

