import React from "react";
import Header from "../components/Header";
import GoogleMap from "../components/GoogleMap";
import FestivalList from "../components/FestivalList";
import FestivalDetail from "../components/FestivalDetail";

const MainPage = () => {
    return (
        <div className="App">
            {/* Header (상단) */}
            <header className="header">
                <Header />
            </header>

            {/* Main Content (지도와 축제 리스트) */}
            <div className="main-content">
                {/* 좌측 지도 */}
                <div className="map-container">
                    <GoogleMap />
                </div>

                {/* 우측 축제 리스트 */}
                <div className="list-container">
                    <FestivalList />
                </div>
            </div>

            {/* Footer (하단 축제 정보) */}
            <footer className="footer">
                <FestivalDetail />
            </footer>
        </div>
    );
};

export default MainPage;
