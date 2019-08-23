var mymap = L.map('map');
	

       L.tileLayer('http://services.arcgisonline.com/ArcGIS/rest/services/Ocean_Basemap/MapServer/tile/{z}/{y}/{x}.png', {
            attribution: 'Esri Ocean Basemap - &copy; Esri, GEBCO, NOAA, National Geographic, DeLorme, HERE, Geonames.org, INFOMAR and other contributors',
            noWrap: true,
            minZoom: 4,
            maxZoom: 12
        }).addTo(mymap);
		
    L.tileLayer('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
            //attribution: '<br/>Esri World Imagery - &copy; Esri, DigitalGlobe, GeoEye, Earthstar Geographics, CNES/Airbus DS, USDA, USGS, AEX, Getmapping, Aerogrid, IGN, IGP, swisstopo, and the GIS User Community',
            noWrap: true,
            minZoom: 12.1,
            maxZoom: 18
        }).addTo(mymap);
	
	var gjLayer = L.geoJSON(thisGeoJsonFeature).addTo(mymap);
	mymap.fitBounds(gjLayer.getBounds());