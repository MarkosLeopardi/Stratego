<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);


session_start(); // Start the session

// Include dbConnection.php to get the $conn variable
include('dbConnection.php');

// Get the current turn from the database
function getCurrentTurn() {
    global $conn; // Use the $conn variable from dbConnection.php

    // Implement this function based on your database structure
    // For example, using a simple query to fetch player_turn from the game status table
    $result = $conn->query("SELECT player_turn FROM game_status");
    $row = $result->fetch_assoc();

    return $row['player_turn'];
}

// Initialize the previous turn if it's not set in the session
if (!isset($_SESSION['prevTurn'])) {
    $_SESSION['prevTurn'] = 'R';
}

// Get the current turn
$currentTurn = getCurrentTurn();

// Check if the turn has changed
$response = [];

if ($currentTurn != $_SESSION['prevTurn']) {
    // Handle the case where the turn has changed
    $response['status'] = 'turn_changed';
    $response['previous_turn'] = $_SESSION['prevTurn'];
    $response['current_turn'] = $currentTurn;

    // Update the previous turn to the current turn
    $_SESSION['prevTurn'] = $currentTurn;

    // Perform other actions if needed
} else {
    // Handle the case where the turn has not changed
    $response['status'] = 'turn_not_changed';
    $response['current_turn'] = $currentTurn;
}

// Send the JSON-encoded response to the client
echo json_encode($response);
?>
