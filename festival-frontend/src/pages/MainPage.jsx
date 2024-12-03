import React from "react";
import Header from "../components/Header";
import FestivalList from "../components/FestivalList";
import FestivalDetail from "../components/FestivalDetail";
import MyGoogleMap from "../components/GoogleMap";

const MainPage = () => {
    return (
        <div className="App">
            {/* Header */}
            <header className="header">
                <Header />
            </header>

            {/* Main Content */}
            <div className="main-content">
                {/* 좌측 지도 */}
                <div className="map-container">
                    <MyGoogleMap />
                </div>
                {/* 우측 축제 리스트 */}
                <div className="list-container">
                    <FestivalList />
                </div>
            </div>

            {/* Footer */}
            <footer className="footer">
                <FestivalDetail />
            </footer>
        </div>
    );
};

export default MainPage;
