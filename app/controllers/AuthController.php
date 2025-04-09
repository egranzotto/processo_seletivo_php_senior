<?php

require_once __DIR__ . '/../vendor/autoload.php';
require_once __DIR__ . '/../helpers/TokenHelper.php';
require_once __DIR__ . '/../helpers/ResponseHelper.php';

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

class AuthController {

    public function login() {
        $body = json_decode(file_get_contents("php://input"), true);

        $username = $body['username'] ?? '';
        $password = $body['password'] ?? '';

        // Login fixo para testes
        if ($username === 'admin' && $password === '123456') {
            $token = generateToken(['user' => $username]);
            jsonResponse(['token' => $token]);
        } else {
            jsonResponse(['error' => 'Credenciais inválidas'], 401);
        }
    }

    public function refresh() {
        $headers = getallheaders();
        $authHeader = $headers['Authorization'] ?? '';

        if (!str_starts_with($authHeader, 'Bearer ')) {
            jsonResponse(['error' => 'Token ausente ou inválido'], 401);
        }

        $token = str_replace('Bearer ', '', $authHeader);

        try {
            $payload = decodeToken($token);
            $newToken = generateToken(['user' => $payload->user]);
            jsonResponse(['token' => $newToken]);
        } catch (Exception $e) {
            jsonResponse(['error' => 'Token inválido ou expirado'], 401);
        }
    }
}
