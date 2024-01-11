<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
include('dbConnection.php');
session_start();

$sql = "UPDATE game_status SET winner = {$_SESSION['user_id']} WHERE game_id = 1";
$result = $conn->query($sql);

if ($result) {
    $response = ['status' => 'success'];
} else {
    $response = ['status' => 'failed', 'error' => $conn->error];
}


// Return the response as JSON
header('Content-Type: application/json');
echo json_encode($response);
