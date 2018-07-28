$( document ).ready(function () {

    $.when(
        // $.getScript( "http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js" ),
        // $.getScript( "http://www.elevateweb.co.uk/wp-content/themes/radial/jquery.fancybox.pack.js" ),
        $.getScript( "http://www.elevateweb.co.uk/wp-content/themes/radial/jquery.elevatezoom.min.js" )
    ).done(function(){

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
            });

            $(this).toggleClass("active");

        });
    });






});
