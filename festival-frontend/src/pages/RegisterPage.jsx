import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import '../styles/global.css';

function RegisterPage() {
    const navigate = useNavigate();
    const [name, setName] = useState('');
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const [nickname, setNickname] = useState('');

    const handleRegister = async () => {
        try {
            await axios.post('http://localhost:8080/api/register', {
                name,
                username,
                password,
                nickname,
            });
            alert('회원가입 완료! 로그인 페이지로 이동합니다.');
            navigate('/login');
        } catch (error) {
            console.error('회원가입 오류:', error);
            alert('회원가입에 실패했습니다. 다시 시도해 주세요.');
        }
    };

    return (
        <div className="register-page">
            <h2 className="register-title">회원가입</h2>
            <div className="register-container">
                <input
                    type="text"
                    placeholder="이름"
                    className="input-field"
                    value={name}
                    onChange={(e) => setName(e.target.value)}
                />
                <input
                    type="text"
                    placeholder="아이디"
                    className="input-field"
                    value={username}
                    onChange={(e) => setUsername(e.target.value)}
                />
                <input
                    type="password"
                    placeholder="비밀번호"
                    className="input-field"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                />
                <input
                    type="text"
                    placeholder="닉네임"
                    className="input-field"
                    value={nickname}
                    onChange={(e) => setNickname(e.target.value)}
                />
                <button onClick={handleRegister} className="register-button">회원가입</button>
                <button onClick={() => navigate('/login')} className="register-button">뒤로가기</button>
            </div>
        </div>
    );
}

export default RegisterPage;