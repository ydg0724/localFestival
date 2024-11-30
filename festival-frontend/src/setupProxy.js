const { createProxyMiddleware } = require('http-proxy-middleware');

module.exports = function(app) {
    app.use(
        '/api', // "/api"로 시작하는 모든 요청을 프록시 설정합니다.
        createProxyMiddleware({
            target: 'http://127.0.0.1:8080', // 백엔드 서버 주소 (Spring Boot 서버)
            changeOrigin: true,
        })
    );
};
