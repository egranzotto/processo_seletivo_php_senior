<?php
// app/controllers/ServidorTemporarioController.php

require_once __DIR__ . '/../helpers/AuthMiddleware.php';
require_once __DIR__ . '/../helpers/ResponseHelper.php';
require_once __DIR__ . '/../config/database.php';

class ServidorTemporarioController {
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

        $sql = "SELECT p.pes_id, p.pes_nome, p.pes_data_nascimento, p.pes_sexo,
                       st.st_data_admissao, st.st_data_demissao
                FROM servidor_temporario st
                JOIN pessoa p ON st.pes_id = p.pes_id
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

        $sql = "SELECT p.pes_id, p.pes_nome, p.pes_data_nascimento, p.pes_sexo,
                       st.st_data_admissao, st.st_data_demissao
                FROM servidor_temporario st
                JOIN pessoa p ON st.pes_id = p.pes_id
                WHERE p.pes_id = :pes_id";

        $stmt = $this->db->prepare($sql);
        $stmt->bindValue(':pes_id', $pes_id, PDO::PARAM_INT);
        $stmt->execute();

        $dado = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($dado) {
            jsonResponse($dado);
        } else {
            jsonResponse(['erro' => 'Servidor temporário não encontrado'], 404);
        }
    }

    public function criar() {
        requireAuth();

        $body = json_decode(file_get_contents("php://input"), true);
        $pes_id = $body['pes_id'] ?? null;
        $admissao = $body['st_data_admissao'] ?? null;
        $demissao = $body['st_data_demissao'] ?? null;

        if (!$pes_id || !$admissao || !$demissao) {
            jsonResponse(['erro' => 'pes_id, st_data_admissao e st_data_demissao são obrigatórios'], 400);
        }

        $stmt = $this->db->prepare("INSERT INTO servidor_temporario (pes_id, st_data_admissao, st_data_demissao)
                                    VALUES (:pes_id, :admissao, :demissao)");
        $stmt->bindValue(':pes_id', $pes_id, PDO::PARAM_INT);
        $stmt->bindValue(':admissao', $admissao);
        $stmt->bindValue(':demissao', $demissao);
        $stmt->execute();

        jsonResponse(['mensagem' => 'Servidor temporário criado com sucesso']);
    }

    public function atualizar($pes_id) {
        requireAuth();

        $body = json_decode(file_get_contents("php://input"), true);
        $admissao = $body['st_data_admissao'] ?? null;
        $demissao = $body['st_data_demissao'] ?? null;

        if (!$admissao || !$demissao) {
            jsonResponse(['erro' => 'st_data_admissao e st_data_demissao são obrigatórios'], 400);
        }

        $stmt = $this->db->prepare("UPDATE servidor_temporario SET st_data_admissao = :admissao, st_data_demissao = :demissao
                                    WHERE pes_id = :pes_id");
        $stmt->bindValue(':admissao', $admissao);
        $stmt->bindValue(':demissao', $demissao);
        $stmt->bindValue(':pes_id', $pes_id);
        $stmt->execute();

        jsonResponse(['mensagem' => 'Servidor temporário atualizado com sucesso']);
    }

    public function deletar($pes_id) {
        requireAuth();

        $stmt = $this->db->prepare("DELETE FROM servidor_temporario WHERE pes_id = :pes_id");
        $stmt->bindValue(':pes_id', $pes_id);
        $stmt->execute();

        jsonResponse(['mensagem' => 'Servidor temporário deletado com sucesso']);
    }
}