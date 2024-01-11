<html>

<head>
    <title>Stratego</title>
    <link rel="stylesheet" href="../css/Main.css" type="text/css" />
    <link rel="stylesheet" href="../css/pieces.css" type="text/css">
    <script src="../Scripts/BPSetup.js"></script>
    <style>
        .readybutton {
            width: 100px;
            height: 100px;
            margin-top: 20px;
            padding: 20px 30px;
        }

        .randomize {
            padding: 20px 30px;
            /* Adjust padding to make the button bigger */
            margin-top: 20px;
            /* Adjust margin to position the button below the board */
        }

        .clear {
            padding: 20px 30px;
            /* Adjust padding to make the button bigger */
            margin-top: 20px;
            /* Adjust margin to position the button below the board */
        }

        .container {
            display: flex;
            justify-content: space-between;
        }

        .board,
        .pool {
            width: 50%;
        }

        .board {
            display: grid;
            grid-template-columns: repeat(10, 50px);
            gap: 2px;
        }

        .pool {
            display: flex;
            flex-wrap: wrap;
            gap: 2px;
            border: 1px solid #000;
            /* Add a border here */
            padding: 5px;
            /* Optional padding for better visual appearance */
        }

        .slot,
        .pool-slot {
            width: 50px;
            height: 50px;
            border: 1px solid #000;
            position: relative;
        }
    </style>
</head>

<body>
    <nav>
        <div id="header">
            <span id="title">Stratego</span>
            <div id="wrapper" style="float: right;">
                <?php
                session_start();
                if (isset($_SESSION['player_username'])) {
                    $username = $_SESSION['player_username'];
                    echo '<span id="user" style="color:blue; font: 200px;">' . $username . '</span>';
                    echo '<button id="logout" onclick="logout()" >Logout</button>';
                } else {
                    // Redirect to login page or handle not logged in case
                    header("Location: login.php");
                    exit();
                }
                ?>
            </div>
            <div>
    </nav>
    <div id="container">
        <div id="navigation">
            <p class="rules" onclick="window.open('Rules.html')">Rules</p>
        </div>

        <!--Opponent Info-->
        <fieldset>
            <legend style="text-align: center; border:2px solid black; background-color:red">Opponent</legend>
            <span id="opponent">
                Username:
            </span>
        </fieldset>

        <!--Board Creation-->
        <div class="container">
            <div class="bb">
                <div class="board" id="game-board">
                    <script>
                        var pcolor = "<?php echo $_SESSION['piece_color']; ?>";
                        BoardCreation(pcolor);
                    </script>
                </div>
                <button onclick="initializeBoard()" id="readyButton" disabled>Ready</button>
                <button onclick="randomizePieces()" id="randomize">Randomize</button>
                <button onclick="clearBoard()" id="clear">Clear</button>
            </div>

            <div class="pool" id="piece-pool" ondrop="drop(event)" ondragover="allowDrop(event)">
                <!-- Pieces in the pool will be appended here using JavaScript -->
            </div>
        </div>
    </div>

</body>

</html>