<?php
// app/controllers/ConsultaController.php

require_once __DIR__ . '/../helpers/AuthMiddleware.php';
require_once __DIR__ . '/../helpers/ResponseHelper.php';
require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../services/MinioService.php';

class ConsultaController {
    private $db;

    public function __construct() {
        $conn = new Database();
        $this->db = $conn->connect();
    }

    public function servidoresPorUnidade() {
        requireAuth();

        if (!isset($_GET['unid_id'])) {
            jsonResponse(['erro' => 'unid_id é obrigatório'], 400);
        }

        $unid_id = $_GET['unid_id'];

        $sql = "SELECT p.pes_nome,
                       DATE_PART('year', AGE(CURRENT_DATE, p.pes_data_nascimento)) AS idade,
                       u.unid_nome AS unidade_lotacao,
                       fp.fp_hash
                FROM servidor_efetivo se
                JOIN pessoa p ON se.pes_id = p.pes_id
                JOIN lotacao l ON l.pes_id = p.pes_id AND l.unid_id = :unid_id
                JOIN unidade u ON u.unid_id = l.unid_id
                LEFT JOIN foto_pessoa fp ON fp.pes_id = p.pes_id
                ORDER BY p.pes_nome";

        $stmt = $this->db->prepare($sql);
        $stmt->bindValue(':unid_id', $unid_id);
        $stmt->execute();

        $dados = $stmt->fetchAll(PDO::FETCH_ASSOC);

        foreach ($dados as &$d) {
            if (!empty($d['fp_hash'])) {
                $minio = new MinioService();
                $d['foto_link'] = $minio->gerarLinkTemporario($d['fp_hash']);
            } else {
                $d['foto_link'] = null;
            }
        }

        jsonResponse($dados);
    }

    public function enderecoFuncional() {
        requireAuth();

        if (!isset($_GET['nome']) || strlen(trim($_GET['nome'])) < 2) {
            jsonResponse(['erro' => 'Parâmetro nome é obrigatório e deve ter pelo menos 2 caracteres'], 400);
        }

        $nome = '%' . $_GET['nome'] . '%';

        $sql = "SELECT p.pes_nome, u.unid_nome,
                       e.end_tipo_logradouro, e.end_logradouro, e.end_numero, e.end_bairro,
                       c.cid_nome, c.cid_uf
                FROM pessoa p
                JOIN servidor_efetivo se ON se.pes_id = p.pes_id
                JOIN lotacao l ON l.pes_id = p.pes_id
                JOIN unidade u ON u.unid_id = l.unid_id
                JOIN unidade_endereco ue ON ue.unid_id = u.unid_id
                JOIN endereco e ON e.end_id = ue.end_id
                JOIN cidade c ON c.cid_id = e.cid_id
                WHERE LOWER(p.pes_nome) LIKE LOWER(:nome)";

        $stmt = $this->db->prepare($sql);
        $stmt->bindValue(':nome', $nome);
        $stmt->execute();

        $dados = $stmt->fetchAll(PDO::FETCH_ASSOC);
        jsonResponse($dados);
    }
}