<?php
require_once __DIR__ . '/../config/database.php';

requireMethod('POST');

$input    = getInput();
$role     = $input['role'] ?? 'student';
$email    = strtolower(trim($input['email'] ?? ''));
$password = $input['password'] ?? '';

if (!in_array($role, ['student', 'admin'], true)) {
    jsonResponse(422, ['success' => false, 'message' => 'Invalid account type.']);
}
if ($email === '' || $password === '') {
    jsonResponse(422, ['success' => false, 'message' => 'Email and password are required.']);
}

// Basic brute-force protection (per session)
$_SESSION['login_attempts'] = $_SESSION['login_attempts'] ?? 0;
$_SESSION['lockout_until']  = $_SESSION['lockout_until'] ?? 0;
if (time() < $_SESSION['lockout_until']) {
    jsonResponse(429, ['success' => false, 'message' => 'Too many failed attempts. Try again in a few minutes.']);
}

// Table name comes from a whitelist, never from user input directly
$table = $role === 'admin' ? 'admins' : 'students';

try {
    $stmt = getDB()->prepare("SELECT id, full_name, email, password FROM {$table} WHERE email = ? LIMIT 1");
    $stmt->execute([$email]);
    $user = $stmt->fetch();
} catch (PDOException $e) {
    jsonResponse(500, ['success' => false, 'message' => 'Server error. Please try again later.']);
}

if (!$user || !password_verify($password, $user['password'])) {
    $_SESSION['login_attempts']++;
    if ($_SESSION['login_attempts'] >= 5) {
        $_SESSION['lockout_until']  = time() + 300; // 5 minutes
        $_SESSION['login_attempts'] = 0;
    }
    jsonResponse(401, ['success' => false, 'message' => 'Invalid email or password.']);
}

// Success: prevent session fixation and store the user
session_regenerate_id(true);
$_SESSION['login_attempts'] = 0;
$_SESSION['lockout_until']  = 0;
$_SESSION['user'] = [
    'id'        => (int) $user['id'],
    'full_name' => $user['full_name'],
    'email'     => $user['email'],
    'role'      => $role,
];

jsonResponse(200, [
    'success' => true,
    'message' => 'Login successful.',
    'user'    => $_SESSION['user'],
]);
