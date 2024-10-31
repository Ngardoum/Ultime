// app/javascript/packs/map.js
function initMap() {
    const location = { lat: -34.397, lng: 150.644 }; // Coordonnées par défaut
    const map = new google.maps.Map(document.getElementById("map"), {
      zoom: 8,
      center: location,
    });
  
    const marker = new google.maps.Marker({
      position: location,
      map: map,
      draggable: true, // Permet de déplacer le marqueur
    });
  
    google.maps.event.addListener(marker, 'dragend', function (event) {
      document.getElementById('restaurant_latitude').value = event.latLng.lat();
      document.getElementById('restaurant_longitude').value = event.latLng.lng();
    });
  }
  