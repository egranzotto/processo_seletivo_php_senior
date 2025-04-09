<?php

require_once __DIR__ . '/TokenHelper.php';
require_once __DIR__ . '/ResponseHelper.php';

function requireAuth() {
    $headers = getallheaders();
    $authHeader = $headers['Authorization'] ?? '';

    if (!str_starts_with($authHeader, 'Bearer ')) {
        jsonResponse(['error' => 'Token ausente ou mal formatado'], 401);
    }

    $token = str_replace('Bearer ', '', $authHeader);

    if (!isTokenValid($token)) {
        jsonResponse(['error' => 'Token inválido ou expirado'], 401);
    }

    return decodeToken($token);
}
