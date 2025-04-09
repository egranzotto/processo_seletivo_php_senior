<?php
// app/controllers/UnidadeController.php

require_once __DIR__ . '/../helpers/AuthMiddleware.php';
require_once __DIR__ . '/../helpers/ResponseHelper.php';
require_once __DIR__ . '/../config/database.php';

class UnidadeController {
    private $db;

    public function __construct() {
        $conn = new Database();
        $this->db = $conn->connect();
    }

    public function listar() {
        requireAuth();

        $sql = "SELECT unid_id, unid_nome, unid_sigla FROM unidade ORDER BY unid_nome";
        $stmt = $this->db->prepare($sql);
        $stmt->execute();

        $dados = $stmt->fetchAll(PDO::FETCH_ASSOC);
        jsonResponse($dados);
    }

    public function buscar($id) {
        requireAuth();

        $stmt = $this->db->prepare("SELECT unid_id, unid_nome, unid_sigla FROM unidade WHERE unid_id = :id");
        $stmt->bindValue(':id', $id);
        $stmt->execute();

        $dado = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($dado) {
            jsonResponse($dado);
        } else {
            jsonResponse(['erro' => 'Unidade não encontrada'], 404);
        }
    }

    public function criar() {
        requireAuth();

        $body = json_decode(file_get_contents("php://input"), true);
        $nome = $body['unid_nome'] ?? null;
        $sigla = $body['unid_sigla'] ?? null;

        if (!$nome || !$sigla) {
            jsonResponse(['erro' => 'unid_nome e unid_sigla são obrigatórios'], 400);
        }

        $stmt = $this->db->prepare("INSERT INTO unidade (unid_nome, unid_sigla) VALUES (:nome, :sigla)");
        $stmt->bindValue(':nome', $nome);
        $stmt->bindValue(':sigla', $sigla);
        $stmt->execute();

        jsonResponse(['mensagem' => 'Unidade criada com sucesso']);
    }

    public function atualizar($id) {
        requireAuth();

        $body = json_decode(file_get_contents("php://input"), true);
        $nome = $body['unid_nome'] ?? null;
        $sigla = $body['unid_sigla'] ?? null;

        if (!$nome || !$sigla) {
            jsonResponse(['erro' => 'unid_nome e unid_sigla são obrigatórios'], 400);
        }

        $stmt = $this->db->prepare("UPDATE unidade SET unid_nome = :nome, unid_sigla = :sigla WHERE unid_id = :id");
        $stmt->bindValue(':nome', $nome);
        $stmt->bindValue(':sigla', $sigla);
        $stmt->bindValue(':id', $id);
        $stmt->execute();

        jsonResponse(['mensagem' => 'Unidade atualizada com sucesso']);
    }

    public function deletar($id) {
        requireAuth();

        $stmt = $this->db->prepare("DELETE FROM unidade WHERE unid_id = :id");
        $stmt->bindValue(':id', $id);
        $stmt->execute();

        jsonResponse(['mensagem' => 'Unidade deletada com sucesso']);
    }
}
