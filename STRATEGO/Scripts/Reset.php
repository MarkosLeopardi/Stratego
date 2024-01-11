<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
include('dbConnection.php');
session_start();

$sqlResetBoard = "CALL ResetBoard()";
$sqlResetReadyFlag = "CALL ResetReadyFlag($pid)";
$result1 =$conn->query($sqlResetBoard);
$result1 = $conn->query($sqlResetReadyFlag);

if ($result1  && $result2) {
    $response = ['status' => 'success'];
} else {
    $response = ['status' => 'failed', 'error' => $conn->error];
}


// Return the response as JSON
header('Content-Type: application/json');
echo json_encode($response);