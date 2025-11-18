package com.example.LabAttendance.RollCall.global.jwt;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import java.nio.charset.StandardCharsets;
import java.security.Key;
import java.util.Collections;
import java.util.Date;


@Component
public class JwtTokenProvider {

    private final Key key;

    public JwtTokenProvider(@Value("${jwt.secret}") String secret) {
        this.key = Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
    }

    private final long EXPIRATION = 1000 * 60 * 60 * 1; // 1시간


    private Key getSigningKey() {
        return key;
    }

    public String generateToken(Long memberId, String email) {
        Date now = new Date();
        Date expiry = new Date(now.getTime() + EXPIRATION);

        String memberIdStr = (memberId != null) ? memberId.toString() : "";

        return Jwts.builder()
                .setSubject(email)
                .claim("memberId", memberIdStr)
                .setIssuedAt(now)
                .setExpiration(expiry)

                .signWith(getSigningKey())
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

        Object memberIdObj = claims.get("memberId");
        Long memberId = null;

        if (memberIdObj instanceof Number) {
            memberId = ((Number) memberIdObj).longValue();
        } else if (memberIdObj instanceof String str && !str.isBlank()) {
            memberId = Long.valueOf(str);
        } else {
            throw new IllegalArgumentException("JWT에 유효한 memberId가 존재하지 않습니다.");
        }


        return new UsernamePasswordAuthenticationToken(
                memberId,
                "",
                Collections.emptyList()
        );
    }
}