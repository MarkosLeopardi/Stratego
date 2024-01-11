<!DOCTYPE html>

<head>
    <title>Stratego</title>
    <link rel="stylesheet" href="../css/Main.css" type="text/css" />
    <script src="../Scripts/GameBoard.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

        .container {
            display: flex;
            justify-content: space-between;
        }

        .board {
            width: 50%;
        }

        .board {
            display: grid;
            grid-template-columns: repeat(10, 50px);
            gap: 2px;
        }


        .slot {
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
                    echo '<button id="logout" onclick="logout()">Logout</button>';
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
            <ul id="navs"><br>
                <li onclick="">New Game</li>
                <li onclick="Surrender(pcolor)">Surrender</li>
                <li class="rules" onclick="window.open('Rules.html')">Rules</li>
            </ul>
        </div>

        <!--Opponent Info-->
        <fieldset>
            <legend style="text-align: center; border:2px solid black; background-color:red; font-weight: bolder; color: white;">Opponent</legend>
            <span id="opponent-legend">
                <script>
                    document.addEventListener('DOMContentLoaded', function() {
                        fetchOpponentUsername();
                        //updateOpponentUsername();
                    });
                </script>
            </span>
        </fieldset>

        <!--Board Creation-->
        <div class="container">
            <div class="board" id="game-board">
                <script>
                    var pcolor = "<?php echo $_SESSION['piece_color']; ?>";
                    var playerturn = 'R';
                    document.addEventListener('DOMContentLoaded', function() {
                        fetchBoard(pcolor, playerturn);
                    });
                </script>
            </div>

            <!--Past Moves Area-->
            <fieldset>
                <legend style="text-align: center; border:2px solid black; background-color:cyan; font-weight: bolder;">Past Moves</legend>
                <textarea rows="35" cols="100" style="float:right; width:inherit" id="prevmoves" readonly></textarea>
            </fieldset>

        </div>
    </div>


</body>

</html>