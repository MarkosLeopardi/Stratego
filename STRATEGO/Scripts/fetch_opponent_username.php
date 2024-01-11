<?php
include('dbConnection.php');
session_start();

// Assuming you have a database connection, adjust the query accordingly
$query = "SELECT player_username FROM players WHERE player_id != {$_SESSION['user_id']} AND piece_color != '{$_SESSION['piece_color']}' LIMIT 1";
$result = mysqli_query($conn, $query);

$response = array();

if ($result && mysqli_num_rows($result) > 0) {
    $row = mysqli_fetch_assoc($result);
    $response['opponentUsername'] = $row['player_username'];
} else {
    $response['opponentUsername'] = "No opponent found"; // Adjust the message as needed
}

header('Content-Type: application/json');
echo json_encode($response);
?>
