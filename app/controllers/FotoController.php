<?php
// app/controllers/FotoController.php

require_once __DIR__ . '/../services/MinioService.php';
require_once __DIR__ . '/../helpers/AuthMiddleware.php';
require_once __DIR__ . '/../helpers/ResponseHelper.php';
require_once __DIR__ . '/../config/database.php';

class FotoController {

    private $db;

    public function __construct() {
        $conn = new Database();
        $this->db = $conn->connect();
    }

    public function upload() {
        requireAuth();

        if (!isset($_POST['pes_id']) || !isset($_FILES['foto']) || $_FILES['foto']['error'] !== UPLOAD_ERR_OK) {
            jsonResponse(['erro' => 'pes_id e foto são obrigatórios'], 400);
        }

        $pes_id = $_POST['pes_id'];
        $arquivo = $_FILES['foto'];
        $nome = uniqid() . '_' . basename($arquivo['name']);
        $caminhoTemporario = $arquivo['tmp_name'];

        $minio = new MinioService();
        $sucesso = $minio->uploadFoto($nome, $caminhoTemporario);

        if ($sucesso) {
            $stmt = $this->db->prepare("INSERT INTO foto_pessoa (pes_id, fp_data, fp_bucket, fp_hash) VALUES (:pes_id, :data, :bucket, :hash)");
            $stmt->bindValue(':pes_id', $pes_id);
            $stmt->bindValue(':data', date('Y-m-d'));
            $stmt->bindValue(':bucket', 'fotos');
            $stmt->bindValue(':hash', $nome);
            $stmt->execute();

            jsonResponse(['mensagem' => 'Foto enviada com sucesso', 'arquivo' => $nome]);
        } else {
            jsonResponse(['erro' => 'Falha ao enviar para o MinIO'], 500);
        }
    }

    public function gerarLink($nomeArquivo) {
        requireAuth();

        $minio = new MinioService();
        $url = $minio->gerarLinkTemporario($nomeArquivo);

        if ($url) {
            jsonResponse(['url' => $url]);
        } else {
            jsonResponse(['erro' => 'Não foi possível gerar o link temporário'], 500);
        }
    }
}