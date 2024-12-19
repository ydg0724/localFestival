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
    let currentMarker = null;   // 타이틀 클릭 시 마커 (파란색 마커)
    let persistentMarkers = []; // 체크박스 마커 배열 (빨간색 마커)

    // 지도 초기화 함수
    function initMap() {
        // 지도 초기화 (서울 기본 좌표)
        map = new google.maps.Map(document.getElementById('google-map'), {
            center: { lat: 37.5665, lng: 126.9780 },
            zoom: 13,
            mapId: "7dba4cf7e6926426"
        });
        const currentPage = window.location.pathname;
        console.log("현재 경로:", currentPage);

        if (currentPage === "/" || currentPage.includes("tour")) {
            console.log("사용자 위치 설정 중...");
            setUserLocation();
        } else {
            console.log("사용자 위치 설정 불필요.");
        }

        if (typeof window.onMapLoaded === "function") {
            window.onMapLoaded(map);
        }
        document.dispatchEvent(new Event("DOMContentLoaded"));


        // 사용자 위치 설정 함수 호출 (초기화 이후 지도에 직접 설정)


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
    function setFestivalLocation(lat, lng, title) {
        if (!map) {
            console.warn("Google Map이 아직 초기화되지 않았습니다. 초기화 후 실행합니다.");
            setTimeout(() => setFestivalLocation(lat, lng, title), 500); // 0.5초 후 재시도
            return;
        }

        if (map) {
            // 기존 마커 제거
            clearMarkers();

            // 새 마커 추가
            const festivalMarker = new google.maps.Marker({
                position: { lat: lat, lng: lng },
                map: map,
                title: title,
                icon: {
                    url: "${pageContext.request.contextPath}/images/festival-marker.png", // 이미지 경로
                    scaledSize: new google.maps.Size(32, 32) // 마커 이미지 크기 조절 (너비, 높이)
                }
            });

            // 지도 중심 이동
            map.setCenter({ lat: lat, lng: lng });
            map.setZoom(12);

            console.log("마커 추가 완료:", title, lat, lng);
        } else {
            console.error("Google Map이 아직 초기화되지 않았습니다.");
        }
    }

    function selectTour(mapX, mapY, title) {
        const lat = parseFloat(mapY);
        const lng = parseFloat(mapX);

        if (isNaN(lat) || isNaN(lng)) {
            console.error("유효하지 않은 좌표입니다.");
            return;
        }

        // 기존 파란색 마커 제거
        if (currentMarker) {
            currentMarker.setMap(null);
        }

        // 새로운 파란색 마커 추가
        currentMarker = new google.maps.Marker({
            position: { lat: lat, lng: lng },
            map: map,
            title: title,
            // label: title,
            icon: "http://maps.google.com/mapfiles/ms/icons/blue-dot.png" // 파란색 마커
        });

        map.setCenter({ lat: lat, lng: lng });
        map.setZoom(12);

        console.log("타이틀 클릭 마커 추가:", title, lat, lng);
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

    // 체크박스 이벤트 처리
    function handleCheckboxChange(checkbox) {
        const title = checkbox.getAttribute("data-title");
        const mapX = parseFloat(checkbox.getAttribute("data-mapx"));
        const mapY = parseFloat(checkbox.getAttribute("data-mapy"));

        if (checkbox.checked) {
            addPersistentMarker(mapY, mapX, title);
        } else {
            removePersistentMarker(title);
        }
    }

    // 체크박스 마커 추가
    function addPersistentMarker(lat, lng, title) {
        const marker = new google.maps.Marker({
            position: { lat: lat, lng: lng },
            map: map,
            title: title,
            icon: {
                url: "${pageContext.request.contextPath}/images/selected-tour-marker.png", // 이미지 경로
                scaledSize: new google.maps.Size(32, 32) // 마커 이미지 크기 조절 (너비, 높이)
            }
        });

        persistentMarkers.push({ marker, title });
        console.log("체크박스 마커 추가:", title, lat, lng);
    }

    // 체크박스 마커 제거
    function removePersistentMarker(title) {
        persistentMarkers = persistentMarkers.filter(item => {
            if (item.title === title) {
                item.marker.setMap(null);
                return false; // 해당 마커는 제거
            }
            return true;
        });
        console.log("체크박스 마커 제거:", title);
    }

    // 마커 추가 함수
    function addMarker(lat, lng, title, color) {
        if (!map) {
            console.error("Map 객체가 초기화되지 않았습니다.");
            return;
        }

        if (isNaN(lat) || isNaN(lng)) {
            console.error(`잘못된 좌표로 마커 추가 실패: ${lat}, ${lng}`);
            return;
        }

        console.log(`마커 추가: ${title} (${lat}, ${lng}) - 색상: ${color}`);
        const marker = new google.maps.Marker({
            position: { lat, lng },
            map: map,
            title: title,
            icon: {
                url: "${pageContext.request.contextPath}/images/selected-tour-marker.png", // 이미지 경로
                scaledSize: new google.maps.Size(32, 32) // 마커 이미지 크기 조절 (너비, 높이)
            }
        });
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
