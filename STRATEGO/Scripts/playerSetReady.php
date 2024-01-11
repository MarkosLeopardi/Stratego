<?php
include('dbConnection.php');
session_start();
if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $playerId = isset($_SESSION['user_id']) ? $_SESSION['user_id'] : 'null';
    //echo ('player id = '.$playerId);
    if ($playerId !== null) {
        // Update the player readiness in the database
        $sql = "UPDATE players SET ready_to_play = 1 WHERE player_id = ?";
        $stmt = mysqli_prepare($conn, $sql);

        if ($stmt) {
            mysqli_stmt_bind_param($stmt, "i", $playerId);
            $result = mysqli_stmt_execute($stmt);

            if ($result) {
                echo json_encode(['status' => 'success']);
            } else {
                echo json_encode(['status' => 'error']);
            }

            mysqli_stmt_close($stmt);
        } else {
            echo json_encode(['status' => 'error']);
        }
    } else {
        $response = ['status' => 'error', 'message' => 'ID not set or null'];
        echo json_encode($response);
    }
}
