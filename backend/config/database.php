<?php
/**
 * Database connection + shared helpers.
 * Every auth script does: require_once __DIR__ . '/../config/database.php';
 */

// ---- Database settings (XAMPP/WAMP defaults) ----
const DB_HOST = 'localhost';
const DB_NAME = 'dss_database';
const DB_USER = 'root';
const DB_PASS = '';

// ---- JSON API headers ----
header('Content-Type: application/json; charset=utf-8');
header('X-Content-Type-Options: nosniff');

// ---- Secure session start ----
if (session_status() === PHP_SESSION_NONE) {
    session_set_cookie_params([
        'lifetime' => 0,
        'path'     => '/',
        'httponly' => true,
        'samesite' => 'Lax',
        'secure'   => !empty($_SERVER['HTTPS']),
    ]);
    session_start();
}

/** Returns a shared PDO connection. */
function getDB(): PDO
{
    static $pdo = null;
    if ($pdo === null) {
        try {
            $pdo = new PDO(
                'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=utf8mb4',
                DB_USER,
                DB_PASS,
                [
                    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                    PDO::ATTR_EMULATE_PREPARES   => false,
                ]
            );
        } catch (PDOException $e) {
            jsonResponse(500, ['success' => false, 'message' => 'Database connection failed.']);
        }
    }
    return $pdo;
}

/** Sends a JSON response and stops the script. */
function jsonResponse(int $status, array $data): void
{
    http_response_code($status);
    echo json_encode($data, JSON_UNESCAPED_UNICODE);
    exit;
}

/** Only allow the given HTTP method. */
function requireMethod(string $method): void
{
    if ($_SERVER['REQUEST_METHOD'] !== $method) {
        jsonResponse(405, ['success' => false, 'message' => 'Method not allowed.']);
    }
}

/** Reads input from a JSON body or a normal form POST. */
function getInput(): array
{
    $raw = file_get_contents('php://input');
    $json = json_decode($raw, true);
    return is_array($json) ? $json : $_POST;
}
