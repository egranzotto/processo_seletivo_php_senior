<?php
// app/controllers/LotacaoController.php

require_once __DIR__ . '/../helpers/AuthMiddleware.php';
require_once __DIR__ . '/../helpers/ResponseHelper.php';
require_once __DIR__ . '/../config/database.php';

class LotacaoController {
    private $db;

    public function __construct() {
        $conn = new Database();
        $this->db = $conn->connect();
    }

    public function listar() {
        requireAuth();

        $sql = "SELECT l.lot_id, l.pes_id, p.pes_nome, l.unid_id, u.unid_nome, l.lot_data_lotacao, l.lot_data_remocao, l.lot_portaria
                FROM lotacao l
                JOIN pessoa p ON l.pes_id = p.pes_id
                JOIN unidade u ON l.unid_id = u.unid_id
                ORDER BY l.lot_data_lotacao DESC";

        $stmt = $this->db->prepare($sql);
        $stmt->execute();

        $dados = $stmt->fetchAll(PDO::FETCH_ASSOC);
        jsonResponse($dados);
    }

    public function buscar($id) {
        requireAuth();

        $sql = "SELECT l.lot_id, l.pes_id, p.pes_nome, l.unid_id, u.unid_nome, l.lot_data_lotacao, l.lot_data_remocao, l.lot_portaria
                FROM lotacao l
                JOIN pessoa p ON l.pes_id = p.pes_id
                JOIN unidade u ON l.unid_id = u.unid_id
                WHERE l.lot_id = :id";

        $stmt = $this->db->prepare($sql);
        $stmt->bindValue(':id', $id, PDO::PARAM_INT);
        $stmt->execute();

        $dado = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($dado) {
            jsonResponse($dado);
        } else {
            jsonResponse(['erro' => 'Lotação não encontrada'], 404);
        }
    }

    public function criar() {
        requireAuth();

        $body = json_decode(file_get_contents("php://input"), true);

        $pes_id = $body['pes_id'] ?? null;
        $unid_id = $body['unid_id'] ?? null;
        $data_lotacao = $body['lot_data_lotacao'] ?? null;
        $data_remocao = $body['lot_data_remocao'] ?? null;
        $portaria = $body['lot_portaria'] ?? null;

        if (!$pes_id || !$unid_id || !$data_lotacao || !$data_remocao || !$portaria) {
            jsonResponse(['erro' => 'Todos os campos são obrigatórios'], 400);
        }

        $stmt = $this->db->prepare("INSERT INTO lotacao (pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria)
                                    VALUES (:pes_id, :unid_id, :data_lotacao, :data_remocao, :portaria)");
        $stmt->bindValue(':pes_id', $pes_id);
        $stmt->bindValue(':unid_id', $unid_id);
        $stmt->bindValue(':data_lotacao', $data_lotacao);
        $stmt->bindValue(':data_remocao', $data_remocao);
        $stmt->bindValue(':portaria', $portaria);
        $stmt->execute();

        jsonResponse(['mensagem' => 'Lotação criada com sucesso']);
    }

    public function atualizar($id) {
        requireAuth();

        $body = json_decode(file_get_contents("php://input"), true);

        $pes_id = $body['pes_id'] ?? null;
        $unid_id = $body['unid_id'] ?? null;
        $data_lotacao = $body['lot_data_lotacao'] ?? null;
        $data_remocao = $body['lot_data_remocao'] ?? null;
        $portaria = $body['lot_portaria'] ?? null;

        if (!$pes_id || !$unid_id || !$data_lotacao || !$data_remocao || !$portaria) {
            jsonResponse(['erro' => 'Todos os campos são obrigatórios'], 400);
        }

        $stmt = $this->db->prepare("UPDATE lotacao
                                    SET pes_id = :pes_id, unid_id = :unid_id, lot_data_lotacao = :data_lotacao,
                                        lot_data_remocao = :data_remocao, lot_portaria = :portaria
                                    WHERE lot_id = :id");
        $stmt->bindValue(':pes_id', $pes_id);
        $stmt->bindValue(':unid_id', $unid_id);
        $stmt->bindValue(':data_lotacao', $data_lotacao);
        $stmt->bindValue(':data_remocao', $data_remocao);
        $stmt->bindValue(':portaria', $portaria);
        $stmt->bindValue(':id', $id);
        $stmt->execute();

        jsonResponse(['mensagem' => 'Lotação atualizada com sucesso']);
    }

    public function deletar($id) {
        requireAuth();

        $stmt = $this->db->prepare("DELETE FROM lotacao WHERE lot_id = :id");
        $stmt->bindValue(':id', $id);
        $stmt->execute();

        jsonResponse(['mensagem' => 'Lotação deletada com sucesso']);
    }
}
