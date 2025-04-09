<?php
// app/services/MinioService.php

require_once __DIR__ . '/../vendor/autoload.php';

use Aws\S3\S3Client;
use Aws\S3\Exception\S3Exception;

class MinioService {
    private $client;
    private $bucket = 'fotos';

    public function __construct() {
        $this->client = new S3Client([
            'version' => 'latest',
            'region'  => 'us-east-1',
            'endpoint' => 'http://minio:9000',
            'use_path_style_endpoint' => true,
            'credentials' => [
                'key'    => 'minioadmin',
                'secret' => 'minioadmin',
            ]
        ]);
    }

    public function uploadFoto($nomeArquivo, $caminhoTemporario) {
        try {
            $this->client->putObject([
                'Bucket' => $this->bucket,
                'Key'    => $nomeArquivo,
                'SourceFile' => $caminhoTemporario,
                'ACL'    => 'private',
                'ContentType' => mime_content_type($caminhoTemporario)
            ]);
            return true;
        } catch (S3Exception $e) {
            error_log('Erro no upload: ' . $e->getMessage());
            return false;
        }
    }

    public function gerarLinkTemporario($nomeArquivo, $tempoSegundos = 300) {
        try {
            $cmd = $this->client->getCommand('GetObject', [
                'Bucket' => $this->bucket,
                'Key'    => $nomeArquivo
            ]);

            $request = $this->client->createPresignedRequest($cmd, "+{$tempoSegundos} seconds");
            return (string) $request->getUri();

        } catch (S3Exception $e) {
            error_log('Erro ao gerar link: ' . $e->getMessage());
            return null;
        }
    }
}
