<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>REGISTER</title>
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
            margin-bottom: 5px;
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
    session_start();
    require_once('../Scripts/dbConnection.php');
    $name = $username = $password = $confirm_password = "";
    $nameErr = $usernameErr = $passwordErr = $confirmPasswordErr = "";


    if ($_SERVER["REQUEST_METHOD"] == "POST") {

        if (empty($_POST["name"])) {
            $nameErr = "Name is required";
        } else {
            $name = test_input($_POST["name"]);

            if (!preg_match("/^[a-zA-Z ]*$/", $name)) {
                $nameErr = "Only letters and white space allowed";
            }
        }


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


        if (empty($_POST["confirm_password"])) {
            $confirmPasswordErr = "Please confirm the password";
        } else {
            $confirm_password = test_input($_POST["confirm_password"]);

            if ($password != $confirm_password) {
                $confirmPasswordErr = "Passwords do not match";
            }
        }


        if (empty($nameErr) && empty($usernameErr) && empty($passwordErr) && empty($confirmPasswordErr)) {
            $checkUsernameQuery = "SELECT * FROM players WHERE player_username='$username'";
            $result = $conn->query($checkUsernameQuery);

            if ($result->num_rows > 0) {
                $usernameErr = "Username already exists. Choose a different username.";
            } else {
                $sql = "INSERT INTO players (player_name, player_username, player_password) VALUES ('$name', '$username', '$password')";
                if ($conn->query($sql) === TRUE) {
                    $userid = $conn->insert_id;
                    $_SESSION['player_username'] = $userid;
                    if ($pcolor === 'blue') {
                        header("Location: blueBoardSetup.php");
                        exit();
                    } else {
                        header("Location: redBoardSetup.php");
                        exit();
                    }
                } else {
                    echo "Error: " . $sql . "<br>" . $conn->error;
                }
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

    <h2>REGISTER</h2>
    <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
        <label for="name">Name:</label>
        <input type="text" name="name" value="<?php echo $name; ?>" />
        <span class="error"><?php echo $nameErr; ?></span>

        <label for="username">Username:</label>
        <input type="text" name="username" value="<?php echo $username; ?>" />
        <span class="error"><?php echo $usernameErr; ?></span>

        <label for="password">Password:</label>
        <input type="password" name="password" value="<?php echo $password; ?>" />
        <span class="error"><?php echo $passwordErr; ?></span>

        <label for="confirm_password">Confirm Password:</label>
        <input type="password" name="confirm_password" value="<?php echo $confirm_password; ?>" />
        <span class="error"><?php echo $confirmPasswordErr; ?></span>

        <input type="submit" name="submit" value="Register" />
        <button type="button" onclick="window.location.href='login.php'">Login here</button>
    </form>

</body>

</html>