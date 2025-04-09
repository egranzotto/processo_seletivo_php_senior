<?php
// app/controllers/PessoaController.php

require_once __DIR__ . '/../helpers/AuthMiddleware.php';
require_once __DIR__ . '/../helpers/ResponseHelper.php';
require_once __DIR__ . '/../config/database.php';

class PessoaController {
    private $db;

    public function __construct() {
        $conn = new Database();
        $this->db = $conn->connect();
    }

    public function listar() {
        requireAuth();

        $sql = "SELECT pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai FROM pessoa ORDER BY pes_nome ASC";
        $stmt = $this->db->prepare($sql);
        $stmt->execute();

        $dados = $stmt->fetchAll(PDO::FETCH_ASSOC);
        jsonResponse($dados);
    }
}