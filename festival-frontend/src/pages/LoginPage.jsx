// 로그인과 회원가입 기능 구현.
//     상태 변경 시 메인 페이지로 리다이렉트.
import React from 'react';
import { useNavigate } from 'react-router-dom';
import '../styles/global.css';

function LoginPage() {
    const navigate = useNavigate();

    const handleLogin = () => {
        // 로그인 기능은 나중에 추가할 예정입니다.
        alert('로그인 기능은 아직 구현되지 않았습니다.');
    };

    return (
        <div className="login-page">
            <h1 className="project-title">축제어때</h1>
            <div className="login-container">
                <input type="text" placeholder="아이디" className="input-field" />
                <input type="password" placeholder="비밀번호" className="input-field" />
                <button onClick={handleLogin} className="login-button">로그인</button>
                <button onClick={() => navigate('/register')} className="login-button">회원가입</button>
            </div>
        </div>
    );
}

export default LoginPage;
