//var el = document.getElementById('canvas-map');
//el.addEventListener('click', getClickXY, false);
var index_check_zoom_map = true;
if ($('.canvas-map').length) {
    var directionsMap, directionsMarkers;
    ymaps.ready(function () {
        var InnerPointBalloon = ymaps.templateLayoutFactory.createClass(
            '<div class="map-balloon-inner">' +
            '<p class="map-point-name">{{ properties.name }}</p>' +
            '<div class="map-point-info">' +
            '<p class="map-point-address">{{ properties.address }}</p>' +
            '<p class="map-point-phone">{{ properties.phone }}</p>' +
            '</div>' +
            '</div>'
        );

        var OuterPointBalloon = ymaps.templateLayoutFactory.createClass(
            '<div class="map-balloon-inner">' +
            '<p class="map-point-name">{{ properties.name }}</p>' +
            '<div class="map-point-info">' +
            '<p>{{ properties.info }}</p>' +
            '</div>' +
            '</div>'
        );

        directionsMap = new ymaps.Map('canvas-map', {
            center: [55.76378764, 37.61243421], // Москва
            zoom: 3,
            controls: []

        });
        var zoom = new ymaps.control.ZoomControl({
            options: {
                size: "large",
                position: {
                    left: 20,
                    bottom: 45
                }
            }
        });
        directionsMap.controls.add(zoom);

        directionsMarkers = new ymaps.GeoObjectCollection();
        $.each(window.innerMapPoints, function (idx, elt) {
            var placemark = new ymaps.Placemark([parseFloat(elt.lat), parseFloat(elt.long)], {
                name: elt.name,
                address: elt.address,
                phone: elt.phone,
                link: elt.link
            }, {
                balloonContentLayout: InnerPointBalloon,
                iconLayout: 'default#image',
                iconImageHref: $('html').hasClass('lt-ie9') ? 'big-marker-red.png' : 'big-marker-red.png',
                iconImageSize: [41 / 1.3, 49 / 1.3]
            });
            directionsMarkers.add(placemark)
        });
        $.each(window.outerMapPoints, function (idx, elt) {
            var placemark = new ymaps.Placemark([parseFloat(elt.lat), parseFloat(elt.long)], {
                name: elt.name,
                info: elt.info,
                link: elt.link
            }, {
                balloonContentLayout: OuterPointBalloon,
                iconLayout: 'default#image',
                iconImageHref: $('html').hasClass('lt-ie9') ? 'big-marker-blue.png' : 'big-marker-blue.png',
                iconImageSize: [41 / 1.3, 49 / 1.3]
            });
            directionsMarkers.add(placemark)
        });

        directionsMap.geoObjects.add(directionsMarkers);

        /**
         * Перерисовывает карту, устанавливает масштаб и центр.
         */
        function setZoomAndCenter() {
            directionsMap.container.fitToViewport();

            if (window.zoomLevel !== undefined) {
                directionsMap.setZoom(window.zoomLevel);
            } else {
                directionsMap.setBounds(directionsMarkers.getBounds(), {
                    checkZoomRange: true,
                });
            }

            if (window.centerPoint !== undefined) {
                directionsMap.setCenter(window.centerPoint);
            }

            directionsMap.events.add('actionend', function (e) {
                console.log('Coords: ', directionsMap.getCenter());
                console.log('Zoom: ', directionsMap.getZoom());
            });
        }

        setZoomAndCenter();

        $('#change-map-visibility').on('click', function () {
            $(this).closest('.calculate-it').css('display', 'none');
            $('#canvas-map').css('display', 'block');
            setZoomAndCenter();
        });
        $('.map-link').on('click', function (e) {
            e.preventDefault();

            var $this = $(this),
                id = $this.attr('data-id');
            var adress = $this.attr('data-adress');
            directionsMap.setCenter([+$this.attr('data-latitude'), +$this.attr('data-longitude')], 16, {
                checkZoomRange: true
            }).then(function () {
            });
            $('html, body').animate({
                scrollTop: ($('#canvas-map').offset().top) - 40
            }, 400);

            $.each(window.innerMapPoints, function (idx, elt) {
                if (($this.attr('data-latitude') == parseFloat(elt.lat)) & ($this.attr('data-longitude') == parseFloat(elt.long))) {
                    console.log("zashel");
                    directionsMap.balloon.open([parseFloat(elt.lat), parseFloat(elt.long)], {
                        content: '<div class="map-balloon-inner">' +
                        '<p class="map-point-name">' + elt.name + '</p>' +
                        '<div class="map-point-info">' +
                        '<p class="map-point-address">' + elt.address + '</p>' +
                        '<p class="map-point-phone">' + elt.phone + '</p>' +
                        '</div>' +
                        '</div>'
                    }, {
                        balloonContentLayout: InnerPointBalloon,
                    });
                }

            });
        });
    });
}


if ($('.canvas-map2').length) {
    var directionsMap2, directionsMarkers2;
    ymaps.ready(function () {
        var InnerPointBalloon2 = ymaps.templateLayoutFactory.createClass(
            '<div class="map-balloon-inner">' +
            '<p class="map-point-name">{{ properties.name }}</p>' +
            '<div class="map-point-info">' +
            '<p class="map-point-address">{{ properties.address }}</p>' +
            '<p class="map-point-phone">{{ properties.phone }}</p>' +
            '</div>' +
            '</div>'
        );

        var OuterPointBalloon2 = ymaps.templateLayoutFactory.createClass(
            '<div class="map-balloon-inner">' +
            '<p class="map-point-name">{{ properties.name }}</p>' +
            '<div class="map-point-info">' +
            '<p>{{ properties.info }}</p>' +
            '</div>' +
            '</div>'
        );

        directionsMap2 = new ymaps.Map('canvas-map2', {
            center: [55.76378764, 37.61243421], // Москва
            zoom: 3,
            controls: []

        });
        var zoom = new ymaps.control.ZoomControl({
            options: {
                size: "large",
                position: {
                    left: 20,
                    bottom: 45
                }
            }
        });
        directionsMap2.controls.add(zoom);

        directionsMarkers2 = new ymaps.GeoObjectCollection();
        $.each(window.innerMapPoints2, function (idx, elt) {
            var placemark2 = new ymaps.Placemark([parseFloat(elt.lat), parseFloat(elt.long)], {
                name: elt.name,
                address: elt.address,
                phone: elt.phone,
                link: elt.link
            }, {
                balloonContentLayout: InnerPointBalloon2,
                iconLayout: 'default#image',
                iconImageHref: $('html').hasClass('bx-ie') ? 'big-marker-red.png' : 'big-marker-red.png',
                iconImageSize: [41 / 1.3, 49 / 1.3]
            });
            directionsMarkers2.add(placemark2)
        });
        $.each(window.outerMapPoints2, function (idx, elt) {
            var placemark2 = new ymaps.Placemark([parseFloat(elt.lat), parseFloat(elt.long)], {
                name: elt.name,
                info: elt.info,
                link: elt.link
            }, {
                balloonContentLayout: OuterPointBalloon,
                iconLayout: 'default#image',
                iconImageHref: $('html').hasClass('bx-ie') ? 'big-marker-blue.png' : 'big-marker-blue.png',
                iconImageSize: [41 / 1.3, 49 / 1.3]
            });
            directionsMarkers2.add(placemark2)
        });

        directionsMap2.geoObjects.add(directionsMarkers2);


        if (window.zoomLevel !== undefined) {
            directionsMap2.setZoom(window.zoomLevel);
        } else {
            directionsMap2.setBounds(directionsMarkers2.getBounds(), {
                checkZoomRange: true
            });
        }

        if (window.centerPoint !== undefined) {
            directionsMap2.setCenter(window.centerPoint);
        }

        directionsMap2.events.add('actionend', function (e) {
            if (index_check_zoom_map) {
                directionsMap2.setZoom(directionsMap2.getZoom() - 1, {duration: 1000});
                index_check_zoom_map = false;
            }
            console.log('Coords: ', directionsMap2.getCenter());
            console.log('Zoom: ', directionsMap2.getZoom());
        });
        $('.map-link').on('click', function (e) {
            e.preventDefault();

            var $this = $(this),
                id = $this.attr('data-id');
            var adress = $this.attr('data-adress');
            directionsMap2.setCenter([+$this.attr('data-latitude'), +$this.attr('data-longitude')], 16, {
                checkZoomRange: true
            }).then(function () {
            });
            $('html, body').animate({
                scrollTop: ($('#canvas-map').offset().top) - 40
            }, 400);

            $.each(window.innerMapPoints2, function (idx, elt) {
                if (($this.attr('data-latitude') == parseFloat(elt.lat)) & ($this.attr('data-longitude') == parseFloat(elt.long))) {
                    console.log("zashel");
                    directionsMap2.balloon.open([parseFloat(elt.lat), parseFloat(elt.long)], {
                        content: '<div class="map-balloon-inner">' +
                        '<p class="map-point-name">' + elt.name + '</p>' +
                        '<div class="map-point-info">' +
                        '<p class="map-point-address">' + elt.address + '</p>' +
                        '<p class="map-point-phone">' + elt.phone + '</p>' +
                        '</div>' +
                        '</div>'
                    }, {
                        balloonContentLayout: InnerPointBalloon2,
                    });
                }

            });
        });
    });
}


























