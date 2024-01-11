<?php
include('dbConnection.php');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $postData = json_decode(file_get_contents('php://input'), true);

    // You might want to validate and sanitize the data here
    $playerId = $postData['player_id'];

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
}
?>



