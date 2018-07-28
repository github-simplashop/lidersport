$(document).ready(function () {
    
    $('.tabs-wrapper > ul li').click(function () {
        $(this).addClass('current-tab').siblings().removeClass('current-tab').parents('.tabs-wrapper').find('.tab').eq($(this).index()).addClass('visible').siblings().removeClass('visible');
    });
    
});