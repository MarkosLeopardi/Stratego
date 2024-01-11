<?php
include('dbConnection.php');

$sql = "SELECT * FROM board WHERE piece_id IS NOT NULL";
$result = $conn->query($sql);

if (!$result) {
    // Error in SQL query execution
    http_response_code(500); // Internal Server Error
    echo json_encode(['error' => 'Error executing SQL query']);
    exit;
}

$data = array();
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
}


// Return data as JSON
header('Content-Type: application/json');
echo json_encode($data);
