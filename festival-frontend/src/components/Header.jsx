import React from "react";

const Header = () => {
    return (
        <div className="header">
            {/* 왼쪽: 제목 */}
            <div className="header-left">
                <h1>축제어때</h1>
            </div>

            {/* 오른쪽: 버튼 */}
            <div className="header-right">
                <button onClick={() => alert("로그인 또는 회원가입 페이지로 이동합니다.")}>
                    로그인/회원가입
                </button>
            </div>
        </div>
    );
};

export default Header;
