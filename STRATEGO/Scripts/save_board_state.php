<?php
include('dbConnection.php');

// Handle the incoming JSON data
$jsonData = file_get_contents('php://input');
$data = json_decode($jsonData);

//error_log($jsonData); // Log the JSON data to the server's error log
//echo $jsonData; // Send the JSON data back to the client for inspection
// Initialize response array
$response = array();

if ($data !== null) {
    // Assuming $conn is the database connection object from db_connection.php

    // Check if 'pieces' property exists and is an array or object
    if (isset($data->boardState) && (is_array($data->boardState) || is_object($data->boardState))) {
        // Pass and update table 'board'
        $stmt = $conn->prepare("UPDATE board SET piece_color = ?, piece_id = ? WHERE position_x = ? AND position_y = ?");

        if ($stmt) {
            // Begin transaction
            $conn->begin_transaction();

            // Bind parameters
            $stmt->bind_param("siii", $pieceColor, $pieceId, $positionX, $positionY);

            // Iterate through pieces and update the database
            foreach ($data->boardState as $piece) {
                $pieceColor = ($piece->color === 'B') ? 'B' : 'R';
                $pieceId = $piece->id;
                $positionX = $piece->position_x;
                $positionY = $piece->position_y;

                $stmt->execute();
            }

            // Commit transaction
            $conn->commit();

            // Close statement
            $stmt->close();
            $response['status'] = 'success';
        } else {
            // Rollback transaction on failure
            $conn->rollback();

            $response['status'] = 'error';
            $response['message'] = 'Failed to prepare statement: ' . $conn->error;
        }
    } else {
        // Set error response for invalid 'pieces' property
        $response['status'] = 'error';
        $response['message'] = 'Invalid or missing "pieces" property';
    }
} else {
    // Set error response for invalid JSON data
    $response['status'] = 'error';
    $response['message'] = 'Invalid JSON data';
}

// Send a response back to the client
echo json_encode($response);
