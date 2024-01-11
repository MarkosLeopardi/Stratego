<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
include('dbConnection.php');
session_start();

function getPlayersState($conn)
{
    $sql = "SELECT player_id FROM players WHERE (logged_in = 1 AND piece_color = 'B' AND ready_to_play = 1) OR (logged_in = 1 AND piece_color = 'R' AND ready_to_play = 1)";
    $stmt = mysqli_prepare($conn, $sql);

    if ($stmt) {
        mysqli_stmt_execute($stmt);
        mysqli_stmt_store_result($stmt);

        // Check the number of rows returned
        $rowCount = mysqli_stmt_num_rows($stmt);
        //echo ('vrike '.$rowCount.' grammes');
        mysqli_stmt_close($stmt);

        // Check if there is exactly one row
        return $rowCount;
    } else {
        return null;
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $ready = getPlayersState($conn);
    if ($ready === 0) {
        $response = ['status' => 'error', 'message' => '0 players are ready'];
        echo json_encode($response);
        exit();
    }

    if ($ready == 1) {
        // If one player is ready, insert a new game
        $sqlInsertGame = "CALL InsertGame(@gameId)";
        $stmtInsertGame = mysqli_prepare($conn, $sqlInsertGame);

        if ($stmtInsertGame) {
            mysqli_stmt_execute($stmtInsertGame);
            // Retrieve the value of @gameId
            $sqlGetGameId = "SELECT @gameId as game_id";
            $resultGetGameId = $conn->query($sqlGetGameId);

            if ($resultGetGameId) {
                $row = $resultGetGameId->fetch_assoc();
                $gameId = $row['game_id'];

                // Include gameId in the response
                $response = ['status' => 'not_ready', 'gameId' => $gameId, 'message' => 'Player1 ready! Game initialized'];
                echo json_encode($response);
            } else {
                $response = ['status' => 'error', 'message' => 'no game ID found'];
                echo json_encode($response);
            }
        } else {
            $response = ['status' => 'error', 'message' => 'Error with procedure InsertGame'];
            echo json_encode($response);
        }

        mysqli_stmt_close($stmtInsertGame);
    } else if ($ready == 2) {
        // If more than one player is ready, update game_state to state=started
        $sqlUpdateGameState = "UPDATE game_status SET status = 'Started' WHERE status = 'Initialized' AND game_id = 1;";
        $resultUpdateGameState = $conn->query($sqlUpdateGameState);

        if ($resultUpdateGameState) {

            $stmtGetPlayerTurn = "Select player_turn from game_status WHERE game_id=1";
            $result = $conn->query($stmtGetPlayerTurn);

            // Check if the query was successful
            if ($result) {
                // Fetch the player_turn value
                $row = $result->fetch_assoc();

                if ($row) {
                    $_SESSION['lastPlayerTurn'] = $row['player_turn'];
                } else {
                    //echo "No rows returned from the query.";
                }
            } else {
                //echo "error with getting player turn";
            }

            $response = ['status' => 'success', 'action' => 'update', 'message' => 'Game state updated to started'];
            echo json_encode($response);
        } else {
            $response = ['status' => 'error', 'message' => 'Error updating game state'];
            echo json_encode($response);
        }
    } else {
        $response = ['status' => 'success', 'message' => 'more Than 3 users are logged in'];
        echo json_encode($response);
    }
} else {
    $response = ['status' => 'error', 'message' => 'Invalid request method'];
    echo json_encode($response);
}
