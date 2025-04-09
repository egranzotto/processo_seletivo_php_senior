<?php
// controllers/BaseController.php

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../helpers/ResponseHelper.php';

class BaseController {
    protected $db;

    public function __construct() {
        $database = new Database();
        $this->db = $database->connect();
    }
}