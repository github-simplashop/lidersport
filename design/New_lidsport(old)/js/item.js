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

    if ($(this).find('input[name=variant]:checked').size() > 0)
      variant = $(this).find('input[name=variant]:checked').val();

    if ($(this).find('select[name=variant]').size() > 0)
      variant = $(this).find('select').val();

    $.ajax({
      url: "ajax/cart.php",
      data: {variant: variant,amount:amount1},
      dataType: 'json',
      success: function(data) {
        $('#cart_informer').html(data);
        if(button.attr('data-result-text'))
          button.val(button.attr('data-result-text'));
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

//Active alone color
function color() {
  var count = 0;

  $('.colors__item').each(function() {
    count++;
  });

  if (count == 1)
    $('.colors__item label').addClass('active');
}

$(document).ready(function() {
  //color();
  quantity();
  choose();
  addToCart();

  //Accordion
  $('.accordion__item').on('click', function() {
    var num = $(this).data('accordion-menu');
    $('.accordion__tab').removeClass('active');
    $('[data-accordion-tab="'+ num +'"]').addClass('active');
  });

  //Images prewie to main
  $('.images__item').on('click', function() {
    var link = $(this).find('img').attr('src');
    $('.images__main').find('img').attr('src', link);
  });
});







{foreach from=$category->path item=cat}
  {assign var=foocat value=$cat->name}
{/foreach}

{if $product->variants|count > 0}
  <script>
    {if $empty_color}
      var colorValue = false;
    {else}
      var colorValue = true;
    {/if}

    {if $empty_razmer} 
      var razmerValue = false;
    {else}
      var razmerValue = true;
    {/if}

    console.log(colorValue);
    console.log(razmerValue);

    var addColor = function() {
      if ($("#colors").hasClass("active")) {
        if ($("#colors").find("label").hasClass("active")) {
          colorValue = true;
        } else {
          colorValue = false;
        }
      } else {
        colorValue = true;
      }
    }

    var addRazmer = function() {
      if ($("#variants").hasClass("active")) {
        if ($("#variants").hasClass("select")) {
          if ($("#variants option:selected").val() == '0') {
            razmerValue = false;
          } else {
            razmerValue = true;
          }
        } else {
          if ($("#variants").find("label").hasClass("active")) {
            razmerValue = true;
          } else {
            razmerValue = false;
          }
        }
      }
    }

    var variants = [
      {foreach $product->variants as $v} {literal}{{/literal}'id':'{$v->id}','color':'{$color[$v->id]}',  'razmer':'{$razmers[$v->id]}',  'price':'{$v->price|convert}', 'compare_price':'{$v->compare_price}', 'stock':'{$v->stock}'{literal}}{/literal},{/foreach}
    ];

    {literal}
      function changeColor(eventObject) {
        if ($(eventObject).parent().hasClass('not_select')) {return true};
        if ($(eventObject).parent().hasClass('active')) {
          $(eventObject).parent().removeClass('active');
        } else {
          $('#colors label').removeClass('active');
          $(eventObject).parent().addClass('active');
        }
        
        validateVariant();
        
        if ($('#variants label.active').length > 0) {
          return true
        } else {
          $('#variants option').hide();
          $('#variants option').eq(0).show();
          $('#variants label').addClass('not_select');
          $.each(variants, function(id, val) {
              
            if(val.color==$(eventObject).val()) {
              $('#variants label:contains("'+val.razmer +'")').removeClass('not_select').addClass('select');
              $('#variants option:contains("'+val.razmer +'")').show();
            }
          });
        }
        
        if ($('#colors label.active').length <= 0) {
          $('#variants label').removeClass('not_select');
          $('#variants option').show();
        }
      }
        
      function changeVariant(eventObject) {
        if ($('#variants select').val() !== undefined)  {
          $('#colors label').addClass('not_select');

          $.each(variants, function(id, val) {
            if (val.razmer==$('#variants input').val()) {
              $('#colors label[rel="' + val.color + '"]').removeClass('not_select').addClass('select');
            }
            if (val.razmer==$(eventObject).val()) {
              $('#colors label[rel="' + val.color + '"]').removeClass('not_select').addClass('select');
            }
          });
          
          if ($(eventObject).val() == 0) {
            $('#colors label').removeClass('not_select');
          }
        } else {
          if ($(eventObject).parent().hasClass('not_select')) {return true};
          if ($(eventObject).parent().hasClass('active')) {
            $(eventObject).parent().removeClass('active');
            $('#colors label').removeClass('not_select');
          } else {
            $('#variants label').removeClass('active');
            $(eventObject).parent().addClass('active');
            $('#colors label').addClass('not_select');

            $.each(variants, function(id, val) {
              if(val.razmer==$(eventObject).val()) {
                $('#colors label[rel="' + val.color + '"]').removeClass('not_select').addClass('select');
              }
              
              if(val.razmer==$('#variants select').val()) {
                $('#colors label[rel="' + val.color + '"]').removeClass('not_select').addClass('select');
              }
            });
          }
        }
        validateVariant();
      }
    {/literal}
      
    {if $empty_color || $empty_razmer}
      {literal}
        function validateVariant() {
          $.each(variants, function(id, val) {
            if ({/literal}{if $empty_razmer}val.razmer==$('#variants label.active input').val(){/if} {if $empty_razmer && $empty_color}&&{/if}{if $empty_color}val.color==$('#colors label.active input').val(){/if}{literal}) {
              var amount = Number($('.number__value').html());

              if(amount > val.stock) {
                $('.number__value').html(val.stock);
              }

              $('[name=variant]').remove();
              $('form.variants input[type="submit"]').before('<input type="radio" checked="checked" name="variant" style="display: none;" value="' + val.id + '" var_amount="'+ val.stock +'">');
              // $('form.variants input[type="submit"]').removeAttr('disabled');
              $('.price,.product-price').text(val.price);

              return false;
            } else if ({/literal}{if $empty_razmer}val.razmer==$('#variants option:selected').val(){/if} {if $empty_razmer && $empty_color}&&{/if}{if $empty_color}val.color==$('#colors label.active input').val(){/if}{literal}) {
              var amount = Number($('.number__value').html());
              if(amount > val.stock) {
                $('.number__value').html(val.stock);
              }

              $('[name=variant]').remove();
              $('form.variants input[type="submit"]').before('<input type="radio" checked="checked" name="variant" style="display: none;" data="'+ amount +'" value="' + val.id + '" var_amount="'+ val.stock +'">');
              // $('form.variants input[type="submit"]').removeAttr('disabled');
              $('.price,.product-price').text(val.price);
              return false;
            } else {
              // $('form.variants input[type="submit"]').attr('disabled','disabled');
            }
          });
        }
      {/literal}
    {else}
      {literal}
        $(document).ready(function() {
          $.each(variants, function(id, val) {
            var amount = Number($('.number__value').html());
            if (amount > val.stock) {
              $('.number__value').html(val.stock);
            }

            $('form.variants input[type="submit"]').before('<input type="radio" checked="checked" name="variant" style="display: none;" data="'+ amount +'" value="' + val.id + '"var_amount="'+ val.stock +'">');
            // $('form.variants input[type="submit"]').removeAttr('disabled');
            $('.price, .product-price').text(val.price);

            return false;
          });
        });
      {/literal}
    {/if}

    {literal}
      $(function() {
        $('#colors input').on('click', function() {
          changeColor(this);
          addColor();
        });

        $('#variants input').on('click', function(eventObject) {
          changeVariant(this);
          addRazmer();
        });

        $('#variants select').on('change', function(eventObject) {
          changeVariant(this);
          addRazmer();
        });
      });
    {/literal}

    {literal}
      $(document).on("click", ".dataInProduct" ,function(e) {
        addColor();
        addRazmer();

        if (colorValue == false || razmerValue == false) {
          e.preventDefault();

          var id = $(this).attr("product");

          $.ajax({
            url: "/price/productInCatalog.php",
            type: "GET",
            data: {"productId": id},
            success: function(data) {
              $('.p-choose__content').html(data);
              $('[data-popup-block="choose"]').arcticmodal();
            }
          });
        } else {

        }
      });
    {/literal}
  </script>
{/if}