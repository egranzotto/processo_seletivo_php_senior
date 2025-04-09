<?php
// public/configuracao.php

require_once __DIR__ . '/../vendor/autoload.php';

use Aws\S3\S3Client;
use Aws\S3\Exception\S3Exception;

$dbHost = 'db_postgres';
$dbUser = 'postgres';
$dbPass = 'postgres';
$targetDb = 'processo_seletivo';

$buckets = [];
$tabelas = [];
$dadosTabelas = [];
$erro = '';
$mensagem = '';

// === MINIO === //
try {
    $s3 = new S3Client([
        'version' => 'latest',
        'region' => 'us-east-1',
        'endpoint' => 'http://minio:9000',
        'use_path_style_endpoint' => true,
        'credentials' => [
            'key' => 'minioadmin',
            'secret' => 'minioadmin',
        ]
    ]);

    if (isset($_POST['deletar_bucket']) && !empty($_POST['bucket_delete'])) {
        $bucketDel = trim($_POST['bucket_delete']);
        $objects = $s3->listObjectsV2(['Bucket' => $bucketDel]);
        if (isset($objects['Contents'])) {
            foreach ($objects['Contents'] as $obj) {
                $s3->deleteObject(['Bucket' => $bucketDel, 'Key' => $obj['Key']]);
            }
        }
        $s3->deleteBucket(['Bucket' => $bucketDel]);
        $mensagem = "Bucket '$bucketDel' excluído com sucesso.";
    }

    $buckets = $s3->listBuckets()['Buckets'] ?? [];
} catch (Throwable $e) {
    $erro = "Erro ao conectar no MinIO: " . $e->getMessage();
}

// === POSTGRES === //
try {
    $conn = new PDO("pgsql:host=$dbHost;dbname=postgres", $dbUser, $dbPass);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $result = $conn->query("SELECT 1 FROM pg_database WHERE datname = '$targetDb'");
    $existeDb = $result->fetch() !== false;

    if ($existeDb) {
        $db = new PDO("pgsql:host=$dbHost;dbname=$targetDb", $dbUser, $dbPass);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $tabelas = $db->query("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'")
                     ->fetchAll(PDO::FETCH_COLUMN);

        foreach ($tabelas as $tab) {
            $dadosTabelas[$tab] = $db->query("SELECT * FROM \"$tab\" LIMIT 50")->fetchAll(PDO::FETCH_ASSOC);
        }
    }
} catch (Throwable $e) {
    $erro = "Erro ao conectar no PostgreSQL: " . $e->getMessage();
}
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Configuração Inicial</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    table th, table td { font-size: 0.85rem; }
    .scroll { overflow-x: auto; }
  </style>
</head>
<body class="bg-light">
<div class="container py-4">
  <h2 class="mb-4">Configuração Inicial do Projeto</h2>

  <?php if ($erro): ?>
    <div class="alert alert-danger">❌ <?= $erro ?></div>
  <?php elseif ($mensagem): ?>
    <div class="alert alert-success">✅ <?= $mensagem ?></div>
  <?php endif; ?>

  <div class="mb-4">
    <h4>MinIO - Buckets</h4>
    <ul class="list-group mb-3">
      <?php foreach ($buckets as $bucket): ?>
        <li class="list-group-item d-flex justify-content-between align-items-center">
          <span>✅ <?= htmlspecialchars($bucket['Name']) ?></span>
          <form method="post" class="d-inline">
            <input type="hidden" name="bucket_delete" value="<?= htmlspecialchars($bucket['Name']) ?>">
            <button type="submit" name="deletar_bucket" class="btn btn-sm btn-outline-danger">Excluir</button>
          </form>
        </li>
      <?php endforeach; ?>
    </ul>
  </div>

  <div class="mb-4">
    <h4>Banco de Dados: <?= $targetDb ?></h4>
    <p>
      <?php if ($existeDb): ?>
        ✅ Banco encontrado.
      <?php else: ?>
        ⚠️ Banco não encontrado.
      <?php endif; ?>
    </p>
  </div>

  <?php if (!empty($tabelas)): ?>
    <div class="mb-4">
      <h4>Tabelas encontradas:</h4>
      <ul class="list-group mb-3">
        <?php foreach ($tabelas as $tab): ?>
          <li class="list-group-item">
            <strong><?= htmlspecialchars($tab) ?></strong>
            <?php if (!empty($dadosTabelas[$tab])): ?>
              <div class="scroll mt-2">
                <table class="table table-bordered table-sm">
                  <thead class="table-light">
                    <tr>
                      <?php foreach (array_keys($dadosTabelas[$tab][0]) as $col): ?>
                        <th><?= htmlspecialchars($col) ?></th>
                      <?php endforeach; ?>
                    </tr>
                  </thead>
                  <tbody>
                    <?php foreach ($dadosTabelas[$tab] as $linha): ?>
                      <tr>
                        <?php foreach ($linha as $val): ?>
                          <td><?= htmlspecialchars($val) ?></td>
                        <?php endforeach; ?>
                      </tr>
                    <?php endforeach; ?>
                  </tbody>
                </table>
              </div>
            <?php else: ?>
              <p class="text-muted mb-0">(sem registros)</p>
            <?php endif; ?>
          </li>
        <?php endforeach; ?>
      </ul>
    </div>
  <?php endif; ?>
</div>
</body>
</html>