<?php
// app/controllers/ServidorEfetivoController.php

require_once __DIR__ . '/../helpers/AuthMiddleware.php';
require_once __DIR__ . '/../helpers/ResponseHelper.php';
require_once __DIR__ . '/../config/database.php';

class ServidorEfetivoController {
    private $db;

    public function __construct() {
        $conn = new Database();
        $this->db = $conn->connect();
    }

    public function listar() {
        requireAuth();

        $page = $_GET['page'] ?? 1;
        $limit = $_GET['limit'] ?? 10;
        $offset = ($page - 1) * $limit;

        $sql = "SELECT p.pes_id, p.pes_nome, p.pes_data_nascimento, p.pes_sexo, se.se_matricula
                FROM servidor_efetivo se
                JOIN pessoa p ON se.pes_id = p.pes_id
                LIMIT :limit OFFSET :offset";

        $stmt = $this->db->prepare($sql);
        $stmt->bindValue(':limit', (int)$limit, PDO::PARAM_INT);
        $stmt->bindValue(':offset', (int)$offset, PDO::PARAM_INT);
        $stmt->execute();

        $dados = $stmt->fetchAll(PDO::FETCH_ASSOC);
        jsonResponse($dados);
    }

    public function buscar($pes_id) {
        requireAuth();

        $sql = "SELECT p.pes_id, p.pes_nome, p.pes_data_nascimento, p.pes_sexo, se.se_matricula
                FROM servidor_efetivo se
                JOIN pessoa p ON se.pes_id = p.pes_id
                WHERE p.pes_id = :pes_id";

        $stmt = $this->db->prepare($sql);
        $stmt->bindValue(':pes_id', $pes_id, PDO::PARAM_INT);
        $stmt->execute();

        $dado = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($dado) {
            jsonResponse($dado);
        } else {
            jsonResponse(['erro' => 'Servidor não encontrado'], 404);
        }
    }

    public function criar() {
        requireAuth();

        $body = json_decode(file_get_contents("php://input"), true);
        $pes_id = $body['pes_id'] ?? null;
        $matricula = $body['se_matricula'] ?? null;

        if (!$pes_id || !$matricula) {
            jsonResponse(['erro' => 'pes_id e se_matricula são obrigatórios'], 400);
        }

        $stmt = $this->db->prepare("INSERT INTO servidor_efetivo (pes_id, se_matricula) VALUES (:pes_id, :matricula)");
        $stmt->bindValue(':pes_id', $pes_id, PDO::PARAM_INT);
        $stmt->bindValue(':matricula', $matricula);
        $stmt->execute();

        jsonResponse(['mensagem' => 'Servidor efetivo criado com sucesso']);
    }

    public function atualizar($pes_id) {
        requireAuth();

        $body = json_decode(file_get_contents("php://input"), true);
        $matricula = $body['se_matricula'] ?? null;

        if (!$matricula) {
            jsonResponse(['erro' => 'se_matricula é obrigatória'], 400);
        }

        $stmt = $this->db->prepare("UPDATE servidor_efetivo SET se_matricula = :matricula WHERE pes_id = :pes_id");
        $stmt->bindValue(':matricula', $matricula);
        $stmt->bindValue(':pes_id', $pes_id);
        $stmt->execute();

        jsonResponse(['mensagem' => 'Servidor efetivo atualizado com sucesso']);
    }

    public function deletar($pes_id) {
        requireAuth();

        $stmt = $this->db->prepare("DELETE FROM servidor_efetivo WHERE pes_id = :pes_id");
        $stmt->bindValue(':pes_id', $pes_id);
        $stmt->execute();

        jsonResponse(['mensagem' => 'Servidor efetivo deletado com sucesso']);
    }
}
