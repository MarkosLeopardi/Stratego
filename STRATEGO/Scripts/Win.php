<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
include('dbConnection.php');
session_start();

$tableName = $_GET['table'];
$pid = $_SESSION['user_id'];

if (isset($tableName) && $tableName === 'game_status') {

    $sql = "SELECT winner FROM game_status";
    $result = $conn->query($sql);

    $winnerData = array();
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $winnerData[] = $row;
        }
    }

    if (!empty($winnerData) && $winnerData[0]['winner'] !== null) {
        echo json_encode(array('winnerData' => $winnerData, 'pid' => $pid));
    } else {
        echo json_encode($pid);
    }
}
