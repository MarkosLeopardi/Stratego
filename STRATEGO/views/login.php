<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>LOGIN</title>
    <style>
        body {
            background-color: #f0f8ff;
            font-family: Arial, sans-serif;
        }

        h2 {
            text-align: center;
        }

        form {
            max-width: 400px;
            margin: 0 auto;
            background-color: #add8e6;
            padding: 20px;
            border-radius: 10px;
        }

        label {
            display: block;
            margin-bottom: 8px;
        }

        input {
            width: 100%;
            padding: 8px;
            margin-bottom: 16px;
            box-sizing: border-box;
        }

        .error {
            color: red;
        }

        input[type="submit"] {
            background-color: #0a7af2;
            color: white;
            cursor: pointer;
            border: none;
            border-radius: 5px;
            font-size: 20px;
        }

        input[type="submit"]:hover {
            background-color: #0a66f1;
        }



        button {
            background-color: #0a7af2;
            color: white;
            padding: 12px 20px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #0a66f1;
        }
    </style>
</head>

<body>

    <?php
    error_reporting(E_ALL);
    ini_set('display_errors', 'On');

    session_start();
    require_once('../Scripts/dbConnection.php');

    $username = $password = "";
    $usernameErr = $passwordErr = "";

    if ($_SERVER["REQUEST_METHOD"] == "POST") {

        if (empty($_POST["username"])) {
            $usernameErr = "Username is required";
        } else {
            $username = test_input($_POST["username"]);
        }


        if (empty($_POST["password"])) {
            $passwordErr = "Password is required";
        } else {
            $password = test_input($_POST["password"]);
        }


        if (empty($usernameErr) && empty($passwordErr)) {
            $sql = "SELECT * FROM players WHERE player_username='$username' AND player_password='$password'";
            $result = $conn->query($sql);

            if ($result->num_rows == 1) {
                $row = $result->fetch_assoc();
                $userid = $row['player_id'];
                $userName = $row['player_username'];
                $currentColor = $row['piece_color'];

                // Update the 'logged_in' status to 1 (assuming 'logged_in' is a TINYINT field)
                $updateLoggedInSql = "UPDATE players SET logged_in=1 WHERE player_id='$userid'";
                $conn->query($updateLoggedInSql);



                // Generate a session token (you can use a more sophisticated method)
                $session_token = bin2hex(random_bytes(32));

                $_SESSION['user_id'] = $userid;
                $_SESSION['player_username'] = $userName;
                $_SESSION['session_token'] = $session_token;
                session_regenerate_id(true);
                error_log('Session Data: ' . print_r($_SESSION, true));
                error_log('Session ID: ' . session_id());
                $currentColor = $row['piece_color'];

                if ($currentColor === null) {
                    $sqlOtherPlayers = "SELECT piece_color FROM players WHERE player_id != '$userid' LIMIT 1";
                    $resultOtherPlayers = $conn->query($sqlOtherPlayers);

                    if ($resultOtherPlayers->num_rows > 0) {
                        $rowOtherPlayers = $resultOtherPlayers->fetch_assoc();
                        $otherPlayerColor = $rowOtherPlayers['piece_color'];

                        // Check if the other player's color is null
                        if ($otherPlayerColor === null) {
                            // If it is null, randomly assign red or blue
                            $pcolor = (rand(0, 1) == 0) ? 'B' : 'R';
                        } else {
                            // If it is not null, assign the opposite color
                            $pcolor = ($otherPlayerColor === 'B') ? 'R' : 'B';
                        }
                    } else {
                        // If no other players have a color assigned, randomly assign red or blue
                        $pcolor = (rand(0, 1) == 0) ? 'B' : 'R';
                    }
                    // error_log('pcolor: ' . $pcolor); // Add this line for debugging
                    // Update the piece_color in the database
                    $updateColorSql = "UPDATE players SET piece_color='$pcolor' WHERE player_id='$userid'";
                    $conn->query($updateColorSql);
                } else {

                    $pcolor = $currentColor;
                }

                $_SESSION['piece_color'] = $pcolor;
                header("Location: BoardSetup.php");
                exit();
            } else {
                echo "Invalid username or password";
            }
        }
    }

    function test_input($data)
    {
        $data = trim($data);
        $data = stripslashes($data);
        $data = htmlspecialchars($data);
        return $data;
    }
    ?>

    <h2>LOGIN</h2>
    <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
        <label for="username">Username:</label>
        <input type="text" name="username" value="<?php echo $username; ?>" />
        <span class="error"><?php echo $usernameErr; ?></span>

        <label for="password">Password:</label>
        <input type="password" name="password" value="<?php echo $password; ?>" />
        <span class="error"><?php echo $passwordErr; ?></span>

        <input type="submit" name="submit" value="Login" />
        <button type="button" onclick="window.location.href='register.php'">Register here</button>
    </form>

</body>

</html>