<?php
// routes/routes.php

require_once __DIR__ . '/../controllers/BaseController.php';
require_once __DIR__ . '/../controllers/AuthController.php';
require_once __DIR__ . '/../controllers/PessoaController.php';
require_once __DIR__ . '/../controllers/ServidorEfetivoController.php';
require_once __DIR__ . '/../controllers/ServidorTemporarioController.php';
require_once __DIR__ . '/../controllers/UnidadeController.php';
require_once __DIR__ . '/../controllers/LotacaoController.php';
require_once __DIR__ . '/../controllers/FotoController.php';
require_once __DIR__ . '/../controllers/ConsultaController.php';
require_once __DIR__ . '/../helpers/AuthMiddleware.php';

$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$method = $_SERVER['REQUEST_METHOD'];

$authController = new AuthController();
$pessoaController = new PessoaController();
$servidorEfetivoController = new ServidorEfetivoController();
$servidorTemporarioController = new ServidorTemporarioController();
$unidadeController = new UnidadeController();
$lotacaoController = new LotacaoController();
$fotoController = new FotoController();
$consultaController = new ConsultaController();

switch (true) {
    case $uri === '/api/ping' && $method === 'GET':
        echo json_encode(["message" => "API funcionando!"]);
        break;

    case $uri === '/api/login' && $method === 'POST':
        $authController->login();
        break;

    case $uri === '/api/refresh' && $method === 'POST':
        $authController->refresh();
        break;

    case $uri === '/api/segredo' && $method === 'GET':
        $user = requireAuth();
        jsonResponse(['mensagem' => 'Você está autenticado!', 'usuario' => $user->user]);
        break;

    case $uri === '/api/pessoas' && $method === 'GET':
        $pessoaController->listar();
        break;

    case $uri === '/api/servidores' && $method === 'GET':
        $servidorEfetivoController->listar();
        break;

    case preg_match('#^/api/servidores/[0-9]+$#', $uri) && $method === 'GET':
        $id = basename($uri);
        $servidorEfetivoController->buscar($id);
        break;

    case $uri === '/api/servidores' && $method === 'POST':
        $servidorEfetivoController->criar();
        break;

    case preg_match('#^/api/servidores/[0-9]+$#', $uri) && $method === 'PUT':
        $id = basename($uri);
        $servidorEfetivoController->atualizar($id);
        break;

    case preg_match('#^/api/servidores/[0-9]+$#', $uri) && $method === 'DELETE':
        $id = basename($uri);
        $servidorEfetivoController->deletar($id);
        break;

    case $uri === '/api/servidoresTemporarios' && $method === 'GET':
        $servidorTemporarioController->listar();
        break;

    case preg_match('#^/api/servidoresTemporarios/[0-9]+$#', $uri) && $method === 'GET':
        $id = basename($uri);
        $servidorTemporarioController->buscar($id);
        break;

    case $uri === '/api/servidoresTemporarios' && $method === 'POST':
        $servidorTemporarioController->criar();
        break;

    case preg_match('#^/api/servidoresTemporarios/[0-9]+$#', $uri) && $method === 'PUT':
        $id = basename($uri);
        $servidorTemporarioController->atualizar($id);
        break;

    case preg_match('#^/api/servidoresTemporarios/[0-9]+$#', $uri) && $method === 'DELETE':
        $id = basename($uri);
        $servidorTemporarioController->deletar($id);
        break;

    case $uri === '/api/unidades' && $method === 'GET':
        $unidadeController->listar();
        break;

    case preg_match('#^/api/unidades/[0-9]+$#', $uri) && $method === 'GET':
        $id = basename($uri);
        $unidadeController->buscar($id);
        break;

    case $uri === '/api/unidades' && $method === 'POST':
        $unidadeController->criar();
        break;

    case preg_match('#^/api/unidades/[0-9]+$#', $uri) && $method === 'PUT':
        $id = basename($uri);
        $unidadeController->atualizar($id);
        break;

    case preg_match('#^/api/unidades/[0-9]+$#', $uri) && $method === 'DELETE':
        $id = basename($uri);
        $unidadeController->deletar($id);
        break;

    case $uri === '/api/lotacoes' && $method === 'GET':
        $lotacaoController->listar();
        break;

    case preg_match('#^/api/lotacoes/[0-9]+$#', $uri) && $method === 'GET':
        $id = basename($uri);
        $lotacaoController->buscar($id);
        break;

    case $uri === '/api/lotacoes' && $method === 'POST':
        $lotacaoController->criar();
        break;

    case preg_match('#^/api/lotacoes/[0-9]+$#', $uri) && $method === 'PUT':
        $id = basename($uri);
        $lotacaoController->atualizar($id);
        break;

    case preg_match('#^/api/lotacoes/[0-9]+$#', $uri) && $method === 'DELETE':
        $id = basename($uri);
        $lotacaoController->deletar($id);
        break;

    case $uri === '/api/uploadFoto' && $method === 'POST':
        $fotoController->upload();
        break;

    case preg_match('#^/api/foto/.+$#', $uri) && $method === 'GET':
        $nome = basename($uri);
        $fotoController->gerarLink($nome);
        break;

    case $uri === '/api/consulta/servidoresPorUnidade' && $method === 'GET':
        $consultaController->servidoresPorUnidade();
        break;

    case $uri === '/api/consulta/servidoresPorUnidade' && $method === 'GET':
        $consultaController->servidoresPorUnidade();
        break;

    case $uri === '/api/consulta/enderecoFuncional' && $method === 'GET':
        $consultaController->enderecoFuncional();
        break;

    default:
        http_response_code(404);
        echo json_encode(["message" => "Endpoint não encontrado."]);
        break;
}