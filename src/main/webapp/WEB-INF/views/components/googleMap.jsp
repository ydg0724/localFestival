<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    #map {
        width: 100%;
        height: 100%;
        position: relative;
    }
</style>


<div id="map" class="map-container">
    <div id="google-map"></div>
</div>


<script>

    let map;
    function initMap() {
        map = new google.maps.Map(document.getElementById('google-map'), {
            center: { lat: 37.5665, lng: 126.9780 }, // Seoul default location
            zoom: 10
        });
    }

    function updateMapLocation(lat, lng, name) {
        // if (map) {
        //     // 기존 마커 제거 (옵션)
        //     map.setCenter({ lat, lng });
        //     map.setZoom(14);
        //
        //     // 새 마커 추가
        //     new google.maps.Marker({
        //         position: { lat, lng },
        //         map: map,
        //         title: name
        //     });
        // }
    }
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=&callback=initMap" async defer></script>
