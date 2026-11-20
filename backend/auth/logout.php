<?php
require_once __DIR__ . '/../config/database.php';

// Clear session data
$_SESSION = [];

// Remove the session cookie
if (ini_get('session.use_cookies')) {
    $p = session_get_cookie_params();
    setcookie(session_name(), '', time() - 42000, $p['path'], $p['domain'], $p['secure'], $p['httponly']);
}

session_destroy();

jsonResponse(200, ['success' => true, 'message' => 'Logged out successfully.']);
