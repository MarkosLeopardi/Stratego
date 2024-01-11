<?php

include_once('dbConnection.php');
session_start();

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$countt = 0;
$row1 = $_POST['row1'];
$col1 = $_POST['col1'];
$row = $_POST['row'];
$col = $_POST['col'];

if (isValidMove($row1, $col1, $row, $col, $conn, $countt)) {
    error_log($countt);
    $response = [
        'status' => 'success'
    ];
} else {
    $response = [
        'status' => 'error'
    ];
}

function isValidMove($startRow, $startCol, $destRow, $destCol, $conn, $countt)
{
    // Check if the move is vertical or horizontal
    if ($startRow !== $destRow && $startCol !== $destCol) {
        return false; // Not a straight-line move
    }

    // Check if the cells in a straight line are empty
    if ($startRow === $destRow) {
        // Horizontal move
        for ($col = min($startCol, $destCol) + 1; $col < max($startCol, $destCol); $col++) {
            if (!isCellEmpty($startRow, $col, $conn)) {
                $countt = $countt + 1; // Cell is not empty
            }
        }
    } else {
        // Vertical move
        for ($row = min($startRow, $destRow) + 1; $row < max($startRow, $destRow); $row++) {
            if (!isCellEmpty($row, $startCol, $conn)) {
                $countt = $countt + 1; // Cell is not empty
            }
        }
    }

    if ($countt > 0) {
        return false;
    } else {

        return true; // Move is valid
    }
}

function isCellEmpty($row, $col, $conn)
{
    // Check if the cell is empty based on your database structure
    $sql = "SELECT COUNT(*) AS num_rows FROM board WHERE position_x = $row AND position_y = $col AND piece_id IS NOT NULL";
    $result = $conn->query($sql);

    if ($result->num_rows = 0) {
        return true;
        
    }else{
        return false;
    }

}
