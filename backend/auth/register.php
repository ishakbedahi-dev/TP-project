<?php
require_once __DIR__ . '/../config/database.php';

requireMethod('POST');

$input           = getInput();
$accountType     = $input['accountType'] ?? 'student';
$fullName        = trim($input['fullName'] ?? '');
$email           = strtolower(trim($input['email'] ?? ''));
$password        = $input['password'] ?? '';
$confirmPassword = $input['confirmPassword'] ?? '';

// Admin accounts cannot be created through public registration
if ($accountType !== 'student') {
    jsonResponse(403, ['success' => false, 'message' => 'Admin accounts can only be created by the system administrator.']);
}

// ---- Validation ----
if ($fullName === '' || mb_strlen($fullName) > 100) {
    jsonResponse(422, ['success' => false, 'message' => 'Full name is required (max 100 characters).']);
}
if (!filter_var($email, FILTER_VALIDATE_EMAIL) || strlen($email) > 100) {
    jsonResponse(422, ['success' => false, 'message' => 'Please enter a valid email address.']);
}
if (strlen($password) < 8) {
    jsonResponse(422, ['success' => false, 'message' => 'Password must be at least 8 characters.']);
}
if ($password !== $confirmPassword) {
    jsonResponse(422, ['success' => false, 'message' => 'Passwords do not match.']);
}

$db = getDB();

try {
    // Email must be unique across students (and not clash with an admin email)
    $check = $db->prepare(
        'SELECT 1 FROM students WHERE email = ? UNION SELECT 1 FROM admins WHERE email = ?'
    );
    $check->execute([$email, $email]);
    if ($check->fetch()) {
        jsonResponse(409, ['success' => false, 'message' => 'This email is already registered.']);
    }

    $stmt = $db->prepare('INSERT INTO students (full_name, email, password) VALUES (?, ?, ?)');
    $stmt->execute([$fullName, $email, password_hash($password, PASSWORD_DEFAULT)]);

    jsonResponse(201, ['success' => true, 'message' => 'Account created successfully. You can now log in.']);
} catch (PDOException $e) {
    // Duplicate key race condition
    if ($e->getCode() === '23000') {
        jsonResponse(409, ['success' => false, 'message' => 'This email is already registered.']);
    }
    jsonResponse(500, ['success' => false, 'message' => 'Server error. Please try again later.']);
}
