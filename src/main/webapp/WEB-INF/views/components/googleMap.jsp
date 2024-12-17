<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    #map {
        width: 100%;
        height: 100%;
        position: relative;
    }
</style>


<div id="map" class="map-container">
    <div id="google-map" style="width: 100%; height: 100%;"></div>
</div>


<script>

    let map;
    let markers = [];
    let userMarker = null; // 사용자 위치 마커

    // 지도 초기화 함수
    function initMap() {
        // 지도 초기화 (서울 기본 좌표)
        map = new google.maps.Map(document.getElementById('google-map'), {
            center: { lat: 37.5665, lng: 126.9780 },
            zoom: 13,
            mapId: "7dba4cf7e6926426"
        });

        // 사용자 위치 설정 함수 호출 (초기화 이후 지도에 직접 설정)
        setUserLocation();
    }

    // 사용자 위치 설정 함수
    function setUserLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(
                position => {
                    const userLat = position.coords.latitude;
                    const userLng = position.coords.longitude;
                    console.log("사용자 위치:", userLat, userLng);

                    // 지도 중심을 사용자 위치로 이동
                    map.setCenter({ lat: userLat, lng: userLng });
                    map.setZoom(10);

                    // 사용자 위치에 마커 추가
                    if (!userMarker) {
                        userMarker = new google.maps.Marker({
                            position: { lat: userLat, lng: userLng },
                            map: map,
                            title: "내 위치",
                            icon: {
                                url: "http://maps.google.com/mapfiles/ms/icons/blue-dot.png" // 사용자 마커 색상
                            }
                        });
                    }
                },
                error => {
                    console.error("위치 정보를 가져올 수 없습니다:", error);
                }
            );
        } else {
            console.error("브라우저가 위치 정보를 지원하지 않습니다.");
        }
    }
    function updateMapLocation(lat, lng, name) {
        if (map) {
            // 기존 마커 모두 제거
            clearMarkers();

            // 맵 중심 이동 및 줌 레벨 설정
            map.setCenter({ lat, lng });
            map.setZoom(7);

            // InfoWindow 생성
            <%--const infoWindow = new google.maps.InfoWindow({--%>
            <%--    content: `<div style="font-size: 14px; font-weight: bold;">${name}</div>`--%>
            <%--});--%>

            // 새 마커 추가
            const marker = new google.maps.Marker({
                position: { lat, lng },
                map: map,
                title: name
            });

            // 마커 배열에 추가
            markers.push(marker);

            // // InfoWindow를 마커에 연결
            // infoWindow.open({
            //     anchor: marker,
            //     map,
            //     shouldFocus: false
            // });
        }
    }

    // 마커 추가 함수
    function addMarker(lat, lng, title) {
        const marker = new google.maps.Marker({
            position: { lat, lng },
            map: map,
            title: title
        });
        markers.push(marker);
    }

    // 기존 마커 제거 함수
    function clearMarkers() {
        for (let marker of markers) {
            marker.setMap(null);
        }
        markers = [];
    }


</script>
<%--<script src="https://maps.googleapis.com/maps/api/js?key=&callback=initMap" async defer></script>--%>
