//check if update happen
setInterval(checkForTurnUpdates, 1500);
setInterval(GameUpdate, 2000);

var confirmation;

function fetchBoard(pcolor, playerturn) {
    let pieceData = [];

    fetch('../Scripts/getBoard.php')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            data.forEach(item => {

                const formattedItem = {
                    pos_x: item.position_x,
                    pos_y: item.position_y,
                    color: item.piece_color,
                    id: item.piece_id
                };

                pieceData.push(formattedItem);
            });

            Main_Board(pieceData, pcolor, playerturn);
        })
        .catch(error => {
            console.error('There was a problem with the fetch operation:', error);
        });
}

function fetchOpponentUsername() {
    fetch('../Scripts/fetch_opponent_username.php')
        .then(response => response.json())
        .then(data => {
            // Update the legend content with the opponent's username
            document.getElementById('opponent-legend').innerText = "Username: " + data.opponentUsername;
        })
        .catch(error => {
            console.error('Error fetching opponent username:', error);
        });
}

function Main_Board(pieceData, pcolor, pturn) {
    const gameBoard = document.getElementById('game-board');
    const numRows = 10;
    const numCols = 10;

    if (pturn == pcolor) {
        alert('YOUR TURN');
    }

    for (let row = 0; row < numRows; row++) {
        for (let col = 0; col < numCols; col++) {
            const slot = document.createElement('div');
            slot.className = 'slot';
            slot.style.width = '50px';
            slot.style.height = '50px';
            slot.id = `slot-${row}-${col}`;
            const matchingPiece = pieceData.find(piece => parseInt(piece.pos_x) === row + 1 && parseInt(piece.pos_y) === col + 1);

            if (matchingPiece) {
                if (matchingPiece.color === pcolor) {
                    slot.style.backgroundColor = matchingPiece.color === 'R' ? '#990000' : '#003366';
                    if (parseInt(matchingPiece.id) === 1) {
                        slot.innerHTML = `<b style="font-size: 25px; color: white;">F</b>`;
                    } else if (parseInt(matchingPiece.id) === 2) {
                        slot.innerHTML = `<b style="font-size: 25px; color: white;">B</b>`;
                    } else {
                        slot.innerHTML = `<b style="font-size: 25px; color: white;">${parseInt(matchingPiece.id) - 2}</b>`;
                    }

                    if (pturn == pcolor) {
                        slot.draggable = true;
                        slot.addEventListener('dragstart', dragStart);
                    } else {
                        slot.draggable = false;
                    }

                    slot.addEventListener('dragover', allowDrop);
                    slot.addEventListener('drop', function (event) {
                        drop(event, pieceData);
                    });
                } else {
                    slot.addEventListener('dragover', allowDrop);
                    slot.addEventListener('drop', function (event) {
                        drop(event, pieceData);
                    });
                    if (pcolor === 'B') {
                        slot.style.backgroundColor = '#990000';
                    } else {
                        slot.style.backgroundColor = '#003366';
                    }
                }
            } else if ((row === 4 || row === 5) && (col === 2 || col === 3 || col === 6 || col === 7)) {
                slot.style.backgroundColor = 'lightblue';
            } else {
                slot.addEventListener('dragover', allowDrop);
                slot.addEventListener('drop', function (event) {
                    drop(event, pieceData);
                });
            }

            gameBoard.appendChild(slot);
        }
    }
}

// Drag and drop functions
function allowDrop(event) {
    event.preventDefault();
    // No return statement here or returning any value
}

function dragStart(event) {
    // Store the dragged piece's ID in the data transfer object
    const elementId = event.target.id;
    event.dataTransfer.setData('slot', elementId);
}

let turn = 1;

function drop(event, pieceData) {
    event.preventDefault();
    const data = event.dataTransfer.getData('slot');
    const draggedElement = document.getElementById(data);
    const pastmoves = document.getElementById('prevmoves');

    if (!draggedElement) {
        return;
    }

    //Getting the initial and final moves position
    const dropTarget = event.target;
    const dropTargetId = dropTarget.id;
    const [row, col] = dropTargetId.split('-').slice(1).map(Number);//row kai col se poio slot(board block) 8a paei, (destination!)
    const [row1, col1] = draggedElement.id.split('-').slice(1).map(Number);//row1 kai col1 se poio slot(board block) itan, (origin!)
    const AttackPiece = Array.isArray(pieceData) ? pieceData.find(piece => parseInt(piece.pos_x) === row1 + 1 && parseInt(piece.pos_y) === col1 + 1) : null;
    const DefencePiece = Array.isArray(pieceData) ? pieceData.find(piece => parseInt(piece.pos_x) === row + 1 && parseInt(piece.pos_y) === col + 1) : null;


    if (parseInt(AttackPiece.id) === 2 || parseInt(AttackPiece.id) === 1) { // if for possible bomb or flag movement
        alert("Illegal Move. Bombs and Flag can't move");
    } else if (draggedElement.style.backgroundColor == dropTarget.style.backgroundColor) {
        alert("Illegal Move. Can't move to a space already owned by you");
    } else if (Math.abs(row - row1) >= 1 && Math.abs(col - col1) >= 1) {
        alert("Illegal Move. Pieces may not move diagonally");
    } else if (Math.abs(row - row1) >= 2 || Math.abs(col - col1) >= 2) {// if for piece moving more than 2 spaces 
        alert("Illegal Move. Pieces cannot move more than 1 space hotizontally or vertically.");
    } else if (dropTarget.style.backgroundColor === '') {// if for moving to empty space
        correctMoveorAttack(row + 1, col + 1, row1 + 1, col1 + 1, 0);
        pastmoves.innerHTML += 'Turn ' + turn + ': ' + draggedElement.id + ' ---> ' + dropTargetId + '\n';
        turn += 1;
        pastmoves.scrollTop = pastmoves.scrollHeight;
    } else {// if for attack possibilities
        if (parseInt(AttackPiece.id) === 5 && parseInt(DefencePiece.id) === 2) { //Miner attacks Bomb
            correctMoveorAttack(row + 1, col + 1, row1 + 1, col1 + 1, 0);
            pastmoves.innerHTML += 'Turn ' + turn + ':' + draggedElement.id + '--->' + dropTargetId + ' Miner attacked Bomb' + '\n';
            turn += 1;
            pastmoves.scrollTop = pastmoves.scrollHeight;
        } else if (parseInt(AttackPiece.id) === 3 && parseInt(DefencePiece.id) === 12) { // Spy attacks Marshal
            correctMoveorAttack(row + 1, col + 1, row1 + 1, col1 + 1, 0);
            pastmoves.innerHTML += 'Turn ' + turn + ':' + draggedElement.id + '--->' + dropTargetId + ' Spy attacked Marshal' + '\n';
            turn += 1;
            pastmoves.scrollTop = pastmoves.scrollHeight;
        } else if (parseInt(DefencePiece.id) === 1) { // if for attacking the flag
            setWinner();
        } else if (parseInt(DefencePiece.id) === 2) {
            correctMoveorAttack(row + 1, col + 1, row1 + 1, col1 + 1, 2);
            pastmoves.innerHTML += 'Turn ' + turn + ':' + draggedElement.id + '--->' + dropTargetId + ' Piece attacked Bomb' + '\n';
            turn += 1;
            pastmoves.scrollTop = pastmoves.scrollHeight;
        }
        else if (parseInt(DefencePiece.id) === parseInt(AttackPiece.id)) { // if for ranks are tie
            correctMoveorAttack(row + 1, col + 1, row1 + 1, col1 + 1, 1);
            pastmoves.innerHTML += 'Turn ' + turn + ':' + draggedElement.id + '--->' + dropTargetId + ' Pieces are Tied' + '\n';
            turn += 1;
            pastmoves.scrollTop = pastmoves.scrollHeight;
        } else if (parseInt(AttackPiece.id) > parseInt(DefencePiece.id)) {// if for successfull attack
            correctMoveorAttack(row + 1, col + 1, row1 + 1, col1 + 1, 0);
            pastmoves.innerHTML += 'Turn ' + turn + ':' + draggedElement.id + '--->' + dropTargetId + '   ' + (parseInt(AttackPiece.id) - 2) + '  successfully attacked ' + (parseInt(DefencePiece.id) - 2) + '\n';
            turn += 1;
            pastmoves.scrollTop = pastmoves.scrollHeight;
        } else {// if for failed attack
            correctMoveorAttack(row + 1, col + 1, row1 + 1, col1 + 1, 2);
            pastmoves.innerHTML += 'Turn ' + turn + ':' + draggedElement.id + '--->' + dropTargetId + '   ' + (parseInt(AttackPiece.id) - 2) + '  failed attacked ' + (parseInt(DefencePiece.id) - 2) + '\n';
            turn += 1;
            pastmoves.scrollTop = pastmoves.scrollHeight;
        }
    }
}

//Updates board with correct movement or if attack is successfull
function correctMoveorAttack(frow, fcol, irow, icol, peri) {
    const bodyData = {
        frow: frow,
        fcol: fcol,
        irow: irow,
        icol: icol,
        peri: peri,
    };

    const options = {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ bodyData }),
    };

    fetch('../Scripts/UpdateBoard.php', options)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .catch(error => {
            console.error('Fetch error:', error);
        });
}

function checkForTurnUpdates() {
    // Fetch data from the PHP script using the Fetch API
    fetch('../Scripts/checkTurnChange.php')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            // You can perform actions based on the data, such as updating the UI
            if (data.status === 'turn_changed') {

                document.getElementById('game-board').innerHTML = '';
                var playerturn = String(data.current_turn);
                fetchBoard(pcolor, playerturn);
            } else {
            }
        })
        .catch(error => {
            console.error('Fetch error:', error);
        });
}

// Update page on Server Update
function GameUpdate() {
        $.ajax({
            url: '../Scripts/Win.php?table=game_status',
            method: 'GET',
            dataType: 'json',
            success: function (response) {
                if (response.winnerData == response.pid) {
                    alert('Congratulations. You Win.');
                } else {
                    alert('Too Bad! You Lost.');
                }

                var confirmation = window.confirm('Do you want to play again? (If no, you will be logged out.)');
                if (confirmation) {
                    window.location.href = '../views/BoardSetup.php';
                } else {
                    alert('Thank you for playing.');
                    logout();
                }
            },
            error: function (xhr, status, error) {
                console.error(status, error);
            }
        });
}

function logout() {
    // Send an AJAX request to your logout script
    fetch('logout.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            logout: true
        }),
    })
        .then(response => response.json())
        .then(data => {
            // Redirect to the login page after successful logout
            if (data.status === 'success') {
                window.location.href = 'login.php';
            }
        })
        .catch(error => {
            console.error('Fetch error:', error);
        });
}

function Surrender() {
    confirmation = window.confirm('Are you sure you want to surrender?');

    if (confirmation) {
        fetch('../Scripts/Surrender.php', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
        })
            .then(response => response.json())
            .then(data => {
                if (data.status === 'success') {
                    //GameUpdate();
                }
            })
            .catch(error => {
                console.error('Fetch error:', error);
            });
    } else {
    }
}

function setWinner() {
    fetch('../Scripts/setWinner.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
    })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                //GameUpdate();
            }
        })
        .catch(error => {
            console.error('Fetch error:', error);
        });
}

//Reset Board and Game Status
function resetfunc() {
    fetch('../Scripts/Reset.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
    })
        .catch(error => {
            console.error('Fetch error:', error);
        });
}


