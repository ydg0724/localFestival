import React from "react";
import { useNavigate } from "react-router-dom";

const Header = () => {
    const navigate = useNavigate();

    return (
        <div className="header">
            {/* 왼쪽: 제목 */}
            <div className="header-left">
                <h1>축제어때</h1>
            </div>

            {/* 오른쪽: 버튼 */}
            <div className="header-right">
                <button onClick={() => navigate("/login")}>
                    로그인/회원가입
                </button>
            </div>
        </div>
    );
};

export default Header;
