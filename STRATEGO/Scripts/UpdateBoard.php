<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
include('dbConnection.php');
session_start();

// Get the parameters from the request
$data = json_decode(file_get_contents("php://input"), true);


if (isset($data['bodyData']['frow'], $data['bodyData']['fcol'], $data['bodyData']['irow'], $data['bodyData']['icol'], $data['bodyData']['peri'])) {
    // Assuming the required parameters are present in the nested 'bodyData'
    $frow = $data['bodyData']['frow'];
    $fcol = $data['bodyData']['fcol'];
    $irow = $data['bodyData']['irow'];
    $icol = $data['bodyData']['icol'];
    $peri = $data['bodyData']['peri'];

    if ($peri == 0) {
        $sql = "CALL moves($frow, $fcol, $irow, $icol)";
    } else if ($peri == 1) {
        $sql = "CALL Tie($frow, $fcol, $irow, $icol)";
    } else if ($peri == 2) {
        $sql = "CALL Lose($irow, $icol)";
    }else{
        $sql = "CALL Win($irow, $icol)";
    }

    $result = $conn->query($sql);

    if ($result) {
        
        $togglePlayerTurnSql = "CALL TogglePlayerTurn(1)";
        if ($conn->query($togglePlayerTurnSql)) {
            $response = ['status' => 'success', 'message' => 'Procedure executed successfully'];
        } else {
            $response = ['status' => 'error', 'message' => 'Error calling TogglePlayerTurn procedure: ' . $conn->error];
            echo json_encode($response);
            exit(); // Stop further execution if an error occurs}
        }
    } else {
        $response = [
            'status' => 'error',
            'message' => 'Invalid or missing parameters',
        ];
    }
}
// Return the response as JSON
header('Content-Type: application/json');
echo json_encode($response);
