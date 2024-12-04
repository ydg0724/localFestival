// Google Maps API 연동.
//     마커 추가, 선택된 마커 강조 등 지도 관련 기능 처리.
import React, { useState } from "react";

import { GoogleMap, useJsApiLoader } from "@react-google-maps/api";

//GoogleMap test 용
const center = {
  lat: 37.5665, // 서울의 위도
  lng: 126.978, // 서울의 경도
};

const MyGoogleMap = () => {
  // console.log("Google Maps API Key:", process.env.REACT_APP_GOOGLE_MAPS_API_KEY);

  const { isLoaded } = useJsApiLoader({
    id: "google-map-script",
    googleMapsApiKey: process.env.REACT_APP_GOOGLE_MAPS_API_KEY, // 환경 변수에서 API 키 가져오기
  });

  if (!isLoaded) {
    return <div>Loading...</div>;
  }

  return (
    <div className="map-container">
      <GoogleMap
        mapContainerStyle={{ width: "100%", height: "100%" }}
        center={center}
        zoom={14} // 확대/축소 레벨
      ></GoogleMap>
    </div>
  );
};

export default MyGoogleMap;
