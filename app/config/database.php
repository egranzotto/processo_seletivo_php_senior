<?php

class Database {
    private $host = 'postgres';
    private $db_name = 'processo_seletivo';
    private $username = 'postgres';
    private $password = 'postgres';
    public $conn;

    public function connect() {
        $this->conn = null;

        try {
            $dsn = "pgsql:host={$this->host};port=5432;dbname={$this->db_name}";
            $this->conn = new PDO($dsn, $this->username, $this->password);
            $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            echo 'Connection Error: ' . $e->getMessage();
        }

        return $this->conn;
    }
}