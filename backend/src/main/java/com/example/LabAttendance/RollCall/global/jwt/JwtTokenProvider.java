package com.example.LabAttendance.RollCall.global.jwt;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders; // Base64 디코더를 위해 필요합니다.
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import java.security.Key;
import java.util.Collections;
import java.util.Date;
import java.util.Base64;

@Component
public class JwtTokenProvider {

    // [중요 수정]: Base64 디코딩 오류를 방지하기 위해, Secret Key 자체를 Base64 인코딩된 문자열로 정의합니다.
    // Base64 인코딩된 문자열은 'a' 대신 'b'와 같이 안전한 문자로만 구성됩니다.
    // HS256 알고리즘 사용을 위해 최소 32바이트(256비트) 이상이어야 합니다.
    private final String SECRET_KEY = Base64.getEncoder().encodeToString("MySuperSecretKeyForJwt1234567890!@#MySuperSecretKeyLongerThan32Bytes".getBytes());

    private final long EXPIRATION = 1000 * 60 * 60 * 24; // 24시간

    private Key getSigningKey() {
        // Base64 문자열을 디코딩하여 바이트 배열을 얻고 Key 객체를 생성합니다.
        // Base64 오류가 발생하지 않도록 안정적인 Decoders.BASE64를 사용합니다.
        byte[] keyBytes = Decoders.BASE64.decode(SECRET_KEY);
        return Keys.hmacShaKeyFor(keyBytes);
    }

    public String generateToken(Long userId, String email) {
        Date now = new Date();
        Date expiry = new Date(now.getTime() + EXPIRATION);

        // Long 타입 ID를 String으로 변환하여 Claim에 추가 (Null 처리 및 안정성 확보)
        String userIdString = (userId != null) ? userId.toString() : "";

        return Jwts.builder()
                .setSubject(email)
                .claim("userId", userIdString) // Long 대신 String으로 변경
                .setIssuedAt(now)
                .setExpiration(expiry)
                .signWith(getSigningKey(), SignatureAlgorithm.HS256)
                .compact();
    }

    public boolean validateToken(String token) {
        try {
            Jwts.parser()
                    .setSigningKey(getSigningKey())
                    .build()
                    .parseClaimsJws(token);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public Authentication getAuthentication(String token) {
        Claims claims = Jwts.parser()
                .setSigningKey(getSigningKey())
                .build()
                .parseClaimsJws(token)
                .getBody();

        String email = claims.getSubject();

        return new UsernamePasswordAuthenticationToken(
                email,
                "",
                Collections.emptyList()
        );
    }
}