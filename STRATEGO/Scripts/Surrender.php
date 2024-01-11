<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
include('dbConnection.php');
session_start();

$sql = "SELECT player_id FROM players WHERE player_id != {$_SESSION['user_id']} AND ready_to_play = 1 LIMIT 1";
$result = $conn->query($sql);

if ($result && $result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $winnerId = $row['player_id'];

    // Update the game_status table with the other player's username as the winner
    $updateSql = "UPDATE game_status SET winner = '$winnerId' WHERE game_id = 1";
    $updateResult = $conn->query($updateSql);

    if ($updateResult) {
        $response = ['status' => 'success'];
    } else {
        $response = ['status' => 'failed', 'error' => $conn->error];
    }
} else {
    $response = ['status' => 'failed', 'error' => 'Other player not found'];
}

// Return the response as JSON
header('Content-Type: application/json');
echo json_encode($response);
