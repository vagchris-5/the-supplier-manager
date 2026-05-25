<?php
/**
 * Database Configuration File
 * Σύνδεση με MySQL Database
 */

// Database credentials
$host = 'localhost';
$user = 'root';
$password = '';
$database = 'supplier_manager';

// Create connection
$conn = new mysqli($host, $user, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Set charset to utf8
$conn->set_charset("utf8");

// Function to execute queries safely
function executeQuery($conn, $sql) {
    $result = $conn->query($sql);
    if (!$result) {
        die("Query failed: " . $conn->error);
    }
    return $result;
}

// Function to get last insert ID
function getLastId($conn) {
    return $conn->insert_id;
}

// Function to get affected rows
function getAffectedRows($conn) {
    return $conn->affected_rows;
}
?>
