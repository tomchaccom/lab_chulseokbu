package com.example.LabAttendance.RollCall.global.jwt;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import java.security.Key;
import java.util.Collections;
import java.util.Date;
import java.util.Base64;

@Component
public class JwtTokenProvider {

    private final String SECRET_KEY = Base64.getEncoder().encodeToString(
            "MySuperSecretKeyForJwt1234567890!@#MySuperSecretKeyLongerThan32Bytes".getBytes()
    );

    private final long EXPIRATION = 1000 * 60 * 60 * 1; // 24시간

    private Key getSigningKey() {
        byte[] keyBytes = Decoders.BASE64.decode(SECRET_KEY);
        return Keys.hmacShaKeyFor(keyBytes);
    }

    // JWT 생성 시 memberId claim 사용
    public String generateToken(Long memberId, String email) {
        Date now = new Date();
        Date expiry = new Date(now.getTime() + EXPIRATION);

        String memberIdStr = (memberId != null) ? memberId.toString() : "";

        return Jwts.builder()
                .setSubject(email)
                .claim("memberId", memberIdStr) // userId -> memberId
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

        // claims에서 memberId 안전하게 가져오기
        Object memberIdObj = claims.get("memberId");
        Long memberId = null;

        if (memberIdObj instanceof Number) {
            memberId = ((Number) memberIdObj).longValue();
        } else if (memberIdObj instanceof String str && !str.isBlank()) {
            memberId = Long.valueOf(str);
        } else {
            throw new IllegalArgumentException("JWT에 유효한 memberId가 존재하지 않습니다.");
        }

        // principal에 memberId 넣기
        return new UsernamePasswordAuthenticationToken(
                memberId,
                "",
                Collections.emptyList()
        );
    }
}
