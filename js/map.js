
$(document).ready(function(){
initialize();

});

<!--
function initialize()
	{//установим свойства карты
	var myOptions = 
		{
    	zoom: 3,
    	center: new google.maps.LatLng(55.35027, 54.138272),
    	mapTypeId: google.maps.MapTypeId.ROADMAP
  		}
  	//создадим карту
  	var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

	//нарисуем маркеры
  	setMarkers(map, branches);
  	
  	//нарисуем ломанную линию
  	var flightPlanCoordinates = 
  		[
        new google.maps.LatLng(48.05869,12.17168),
		new google.maps.LatLng(53.930422,27.604437),
        new google.maps.LatLng(59.918582,30.396453),
        new google.maps.LatLng(55.708697,37.597872),
        new google.maps.LatLng(45.036115,39.066896),
        new google.maps.LatLng(53.251603,50.295452),
        new google.maps.LatLng(55.781906,49.125044),
        new google.maps.LatLng(56.864374,60.592219),
        new google.maps.LatLng(55.017321,82.917414),
        new google.maps.LatLng(56.074396,92.999121)
    	];
    var flightPath = new google.maps.Polyline({
      	path: flightPlanCoordinates,
      	strokeColor: "gold",
      	strokeOpacity: 1.0,
      	strokeWeight: 2
    	});
   flightPath.setMap(map);
	}

/**
 * Data for the markers consisting of a name, a LatLng and a zIndex for
 * the order in which these markers should display on top of each
 * other.
 */
var branches = 
  [
  ["Deutschland, D-83531, Edling, Viehhauser Straße, 6." + "\r\n"+"tel. +49 (0) 8071-59-95 #0 / fax: +49 (0) 8071-59-95 #99" + "\r\n"+"Schechtl Maschinenbau GmbH\r\nзавод-производитель", 48.05869,12.17168, 1],
  ["г.Минск, пр-т Независимости 85Б,\r\n помещение 11Н\r\n +375(17)385-61-01, +375(29)268-22-22", 53.930422,27.604437, 2],
  ["г. Санкт-Петербург, пр-т Обуховской обороны, д. 7.\r\n+7 (951) 646-01-44, +7 (911) 139-85-22,\r\n+7 (800) 555-05-40\r\nофис продаж, склад, демонстрационный зал", 59.918582,30.396453, 3],
  ["г. Москва, ул. Орджоникидзе, д. 11 корп. 44.\r\n+7 (495) 737-08-80, +7 (800) 555-05-40\r\nофис продаж, склад, демонстрационный зал", 55.708697,37.597872, 4],
  ["г. Краснодар, ул. Уральская, д. 87,\r\nлитер Г 63, пом.№ 10.\r\n+7 (918) 356-26-26, +7 (800) 555-05-40\r\nофис продаж, склад, демонстрационный зал", 45.036115,39.066896, 5],
  ["г. Казань, Спартаковская, д. 2, корп. 1, 2 этаж.\r\n+7 (951) 646-01-44, +7 (911) 139-85-22,\r\n+7 (800) 555-05-40\r\nофис продаж, склад, демонстрационный зал", 55.781906,49.125044, 6],
  ["г. Екатеринбург, ул. Завокзальная, д. 5,\r\nтерритория ОАО «Машпродукция».\r\n+7 (343) 346-72-45, +7 (967) 639-72-45,\r\n+7 (800) 555-05-40\r\nсклад", 56.864374,60.592219, 7],
  ["г. Новосибирск, ул. Фабричная 17 стр. 6, офис 5.\r\n+7 (383) 286-04-56, +7 (913) 002-04-56,\r\n+7 (800) 555-05-40\r\nофис продаж, склад, демонстрационный зал", 55.017321,82.917414, 8],
  ["г. Красноярск, ул. Пограничников, д. 105 \"А\",\r\nофис № 18. +7 (391)272-53-28, +7 (800) 555-05-40\r\nофис продаж, склад, демонстрационный зал", 56.074396,92.999121, 9],
  ["г.Самара, ул. Олимпийская, д.67,\r\n «База Стройматериалов» \r\n +7 (903) 301-93-81, +7 (846) 991-93-81\r\nофис продаж, склад, демонстрационный зал", 53.251603,50.295452, 10]
  
  ];




function setMarkers(map, locations) 
	{
	
		//Установим описания для маркеров
	    var contentString = '<div id="content">'+
        '<div id="siteNotice">'+
        '</div>'+
        '<h1 id="firstHeading" class="firstHeading">Uluru</h1>'+
        '<div id="bodyContent">'+
        '<p><b>Uluru</b>, also referred to as <b>Ayers Rock</b>, is a large ' +
        'sandstone rock formation in the southern part of the '+
        'Northern Territory, central Australia. It lies 335&#160;km (208&#160;mi) '+
        'south west of the nearest large town, Alice Springs; 450&#160;km '+
        '(280&#160;mi) by road. Kata Tjuta and Uluru are the two major '+
        'features of the Uluru - Kata Tjuta National Park. Uluru is '+
        'sacred to the Pitjantjatjara and Yankunytjatjara, the '+
        'Aboriginal people of the area. It has many springs, waterholes, '+
        'rock caves and ancient paintings. Uluru is listed as a World '+
        'Heritage Site.</p>'+
        '<p>Attribution: Uluru, <a href="http://en.wikipedia.org/w/index.php?title=Uluru&oldid=297882194">'+
        'http://en.wikipedia.org/w/index.php?title=Uluru</a> '+
        '(last visited June 22, 2009).</p>'+
        '</div>'+
        '</div>';

    var infowindow = new google.maps.InfoWindow({content: contentString});
    // Add markers to the map

    // Marker sizes are expressed as a Size of X,Y
    // where the origin of the image (0,0) is located
    // in the top left of the image.

    // Origins, anchor positions and coordinates of the marker
    // increase in the X direction to the right and in
    // the Y direction down.
  	var image = new google.maps.MarkerImage('images/logo.gif',
      // This marker is 20 pixels wide by 32 pixels tall.
      new google.maps.Size(43, 44),
      // The origin for this image is 0,0.
      new google.maps.Point(0,0),
      // The anchor for this image is the base of the flagpole at 0,32.
      new google.maps.Point(22, 22));
  	var shadow = new google.maps.MarkerImage('images/beachflag_shadow.png',
      // The shadow image is larger in the horizontal dimension
      // while the position and offset are the same as for the main image.
      new google.maps.Size(37, 32),
      new google.maps.Point(0,0),
      new google.maps.Point(0, 44));
      // Shapes define the clickable region of the icon.
      // The type defines an HTML &lt;area&gt; element 'poly' which
      // traces out a polygon as a series of X,Y points. The final
      // coordinate closes the poly by connecting to the first
      // coordinate.
  	var shape = {
      			coord: [1, 1, 
      		  			1, 42, 
      		  			43, 42, 
      		  			43 , 1],
      			type: 'poly'
  				};
  	for (var i = 0; i < locations.length; i++)
  		{
    	var branch = locations[i];
    	var myLatLng = new google.maps.LatLng(branch[1], branch[2]);
    	var marker = new google.maps.Marker({
    	//marker[i] = new google.maps.Marker({
       		position: myLatLng,
        	map: map,
        	shadow: "",//shadow,
        	icon: image,
        	shape: shape,
        	title: branch[0],
        	zIndex: branch[3]
    		});
   		//установим обработчик нажатия на маркер
     	google.maps.event.addListener(marker, 'click', function()
     	 {
     	 infowindow.close();
		 infowindow.setPosition(this.getPosition());
     	 var content = '<div style="width: 375">' + this.title.replace("\r\n","<BR>").replace("\r\n","<BR>").replace("\r\n","<BR>").replace("\r\n","<BR>") + "</div>";
     	 infowindow.setContent(content);
     	 //var opt = new google.maps.InfoWindowOptions({
     	 //maxWidth: 260
     	 //});
		 //infowindow.setOptions({maxWidth: 360});
		 //infowindow.disableAutoPan = false;
		 infowindow.open(map, this);
     	 });
 		}
	}
//-->