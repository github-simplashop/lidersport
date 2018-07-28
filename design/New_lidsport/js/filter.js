$(document).ready(function(){
	//Price slider
    var minPrice = parseInt($('#minprice').val()),
        maxPrice = parseInt($('#maxprice').val()),
        currentMinPrice = parseInt($('#current_minprice').val()),
        currentMaxPrice = parseInt($('#current_maxprice').val()),
        url = $('#priceurl').val()
        ;


    $('#minCost').val(currentMinPrice);
    $('#maxCost').val(currentMaxPrice);

		$('#filter-slider').slider({
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

    $('#filter-slider').on('click', function() {
        $('#minCost').val($("#filter-slider").slider("values", 0));
        $('#maxCost').val($("#filter-slider").slider("values", 1));
    });

    /*$('#minCost, #maxCost').change(function () {
        window.location.href = jQuery.query.set(
            'min_price', $('#minCost').val()).set('max_price', $('#maxCost').val());
    });

    $('#filter-slider').slider({
        stop: function () {
            window.location.href = jQuery.query.set(
                'min_price', $('#minCost').val()).set('max_price', $('#maxCost').val());
        }
    });*/

    var changeUrlFunc = function(){
        result_url = url;
        if($( "#minCost" ).val() != minPrice){
            result_url += '/price-min=' + $( "#minCost" ).val();
        }
        if($( "#maxCost" ).val() != maxPrice){
            result_url += '/price-max=' + $( "#maxCost" ).val();
        }
        window.location = result_url;
    }
    $('#minCost, #maxCost').change(changeUrlFunc);
    $('#filter-slider').slider({
        stop: changeUrlFunc
    });

});