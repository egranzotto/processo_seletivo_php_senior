# 📘 API REST - Processo Seletivo

Este projeto é uma API REST desenvolvida em PHP puro, utilizando Docker, PostgreSQL e MinIO para armazenamento de arquivos. O objetivo é atender aos requisitos funcionais definidos para um processo seletivo técnico.

---

## 🚀 Tecnologias Utilizadas

| Tecnologia         | Versão           |
|--------------------|------------------|
| PHP                | 8.2              |
| Apache             | 2.4              |
| PostgreSQL         | 16               |
| MinIO              | RELEASE.2024-01-15T04-32-43Z |
| Docker             | 24+              |
| Docker Compose     | 2+               |
| Composer           | 2.x              |
| AWS SDK PHP (MinIO)| ^3.298           |
| Firebase PHP-JWT   | ^6.11            |
| Bootstrap          | 5.3              |

---

## 🧰 Como Executar o Projeto

### 1. Clone o repositório
```bash
git clone https://github.com/egranzotto/processo_seletivo.git
cd processo_seletivo
```

### 2. Suba os containers com Docker Compose
```bash
docker-compose up -d --build
```

### 3. Acesse a tela de configuração inicial
```
http://localhost:8080/configuracao.php
```

> ⚠️ Use essa tela para:
> - Criar o banco `processo_seletivo` (se necessário)
> - Listar/criar/excluir buckets MinIO
> - Importar um `dump.sql` para popular o banco

### 4. Acesse o banco de dados para corrigir as sequences (caso necessário)

Você pode acessar o banco de dados usando o Adminer, que está disponível em:
```
http://localhost:8081
```

Use as seguintes credenciais:
- **Sistema:** PostgreSQL
- **Servidor:** db_postgres
- **Usuário:** postgres
- **Senha:** postgres
- **Banco de dados:** processo_seletivo

Após acessar, execute os seguintes comandos SQL na aba de execução para garantir a integridade das sequences:
```sql
SELECT setval('unidade_unid_id_seq', (SELECT MAX(unid_id) FROM unidade));
SELECT setval('lotacao_lot_id_seq', (SELECT MAX(lot_id) FROM lotacao));
SELECT setval('foto_pessoa_fp_id_seq', (SELECT MAX(fp_id) FROM foto_pessoa));
```

### 5. Acesse o Swagger para testar a API
```
http://localhost:8080/swagger
```

---

## ✅ Funcionalidades Implementadas

- Autenticação JWT com expiração em 5 minutos e refresh
- Upload de fotografias para o MinIO (bucket `fotos`)
- Geração de link temporário (expira em 5 min)
- CRUD para:
  - Servidor Efetivo
  - Servidor Temporário
  - Unidade
  - Lotação
- Consultas específicas:
  - Listar servidores efetivos por unidade (com idade, foto e nome)
  - Consultar endereço funcional por parte do nome do servidor
- Tela `configuracao.php` com:
  - Diagnóstico do banco e MinIO
  - Execução de dump.sql
  - Drop geral das tabelas
  - Visualização dos dados das tabelas

---

## 🔗 Endpoints Principais

- `POST /api/login` → autenticação
- `POST /api/refresh` → renovar token
- `GET /api/segredo` → rota protegida
- `POST /api/uploadFoto` → upload de imagem + gravação no banco
- `GET /api/foto/{nome}` → gerar link temporário da imagem
- `GET /api/consulta/servidoresPorUnidade?unid_id=` → listar servidores com foto
- `GET /api/consulta/enderecoFuncional?nome=` → buscar endereço funcional da unidade por nome

---

## 👤 Autor

**Eduardo Granzotto**  
E-mail: [egranzotto@gmail.com](mailto:egranzotto@gmail.com)  
GitHub: [@egranzotto](https://github.com/egranzotto)

---

> Projeto desenvolvido como parte de um processo seletivo técnico. Todos os direitos reservados.
