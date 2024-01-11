<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
// Start or resume the session
session_start();

// Include your database connection configuration
require_once('../Scripts/dbConnection.php');

// Check if a POST request is made
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Decode the JSON received in the request body
    $requestData = json_decode(file_get_contents("php://input"), true);

    // Check if 'logout' key is set to true
    if (isset($requestData['logout']) && $requestData['logout'] === true) {

        // Log session data for all active sessions
        foreach ($_SESSION as $sessionId => $sessionData) {
            error_log("Session ID: $sessionId, Session Data: " . print_r($sessionData, true));
        }

        if (isset($_SESSION['user_id'])) {
            $playerId = $_SESSION['user_id'];

            // Update the 'logged_id' status to 0 due to logout
            $updateLoggedInSql = "UPDATE players SET logged_in=0 WHERE player_id='$playerId'";
            $conn->query($updateLoggedInSql);

            $resetPlayerIsReadyFlagSql = "Call ResetReadyFlag('$playerId')";
            $conn->query($resetPlayerIsReadyFlagSql);

            $updateQuery = "UPDATE players SET piece_color = null WHERE player_id = ?";

            $stmt = $conn->prepare($updateQuery);
            $stmt->bind_param("i", $playerId);
            $stmt->execute();
            $stmt->close();

            $AbortGame = "UPDATE game_status SET status = 'Aborted' WHERE game_id = 1";
            $stmt = $conn->prepare($AbortGame);
            $stmt->execute();
            $stmt->close();

            $DeleteStatus = "call DeleteGameStatus()";
            $stmt = $conn->prepare($DeleteStatus);
            $stmt->execute();
            $stmt->close();

            // Log the player ID before destroying the session
            error_log('Player ID before destruction: ' . $playerId);
        }

        // Destroy the session
        session_unset();
        session_destroy();

        // Output a JSON response
        header('Content-Type: application/json');
        echo json_encode(['status' => 'success']);
        exit;
    } else {
        // Output a JSON response indicating invalid request
        header('Content-Type: application/json');
        echo json_encode(['status' => 'error', 'message' => 'Invalid request']);
        exit;
    }
} else {
    // Output a JSON response indicating not logged in
    header('Content-Type: application/json');
    echo json_encode(['status' => 'error', 'message' => 'Not logged in']);
    exit;
}
