<?php

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

const JWT_SECRET = "sua_chave_secreta_supersegura"; // troque para produção
const JWT_EXPIRE_TIME = 300; // 5 minutos

function generateToken(array $payload): string {
    $payload['exp'] = time() + JWT_EXPIRE_TIME;
    return JWT::encode($payload, JWT_SECRET, 'HS256');
}

function decodeToken(string $token): object {
    return JWT::decode($token, new Key(JWT_SECRET, 'HS256'));
}

function isTokenValid(string $token): bool {
    try {
        decodeToken($token);
        return true;
    } catch (Exception $e) {
        return false;
    }
}
