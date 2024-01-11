setInterval(checkGameReady, 5000);

const pieceData = [{
    type: 'Flag',
    color: '',
    id: 1,
    icon: 'Flag.png',
    rank: 'F',
    quantity: 1
},
{
    type: 'Bomb',
    color: '',
    id: 2,
    icon: 'Bomb.png',
    rank: 'B',
    quantity: 6
},
{
    type: 'Spy',
    color: '',
    id: 3,
    icon: 'Spy.png',
    rank: '1',
    quantity: 1
},
{
    type: 'Scout',
    color: '',
    id: 4,
    icon: 'Scout.png',
    rank: '2',
    quantity: 8
},
{
    type: 'Miner',
    color: '',
    id: 5,
    icon: 'Miner.png',
    rank: '3',
    quantity: 5
},
{
    type: 'Sergeant',
    color: '',
    id: 6,
    icon: 'Sergeant.png',
    rank: '4',
    quantity: 4
},
{
    type: 'Lieutenant',
    color: '',
    id: 7,
    icon: 'Lieutenant.png',
    rank: '5',
    quantity: 4
},
{
    type: 'Captain',
    color: '',
    id: 8,
    icon: 'Captain.png',
    rank: '6',
    quantity: 4
},
{
    type: 'Major',
    color: '',
    id: 9,
    icon: 'Major.png',
    rank: '7',
    quantity: 3
},
{
    type: 'Colonel',
    color: '',
    id: 10,
    icon: 'Colonel.png',
    rank: '8',
    quantity: 2
},
{
    type: 'General',
    color: '',
    id: 11,
    icon: 'General.png',
    rank: '9',
    quantity: 1
},
{
    type: 'Marshal',
    color: '',
    id: 12,
    icon: 'Marshal.png',
    rank: 'A',
    quantity: 1
}

];

function BoardCreation(pcolor) {
    // Create the board dynamically
    const gameBoard = document.getElementById('game-board');
    const numRows = 10;
    const numCols = 10;

    for (let row = 0; row < numRows; row++) {
        for (let col = 0; col < numCols; col++) {
            const slot = document.createElement('div');
            slot.className = 'slot';
            if (pcolor === 'B') {
                if (row >= 0 && row <= 3) {
                    slot.style.backgroundColor = 'gray';
                } else if (row === 4 || row === 5) {
                    if ((col === 2 || col === 3 || col === 6 || col === 7)) {
                        slot.style.backgroundColor = 'lightblue';
                    } else {
                        slot.style.backgroundColor = 'gray';
                    }
                } else {
                    slot.setAttribute('ondrop', 'drop(event)');
                    slot.setAttribute('ondragover', 'allowDrop(event)');

                    slot.id = `cell-${row}-${col}`;

                    // Add a dragover event listener to allow dropping on the board slots
                    slot.addEventListener('dragover', allowDrop);

                    // Add a drop event listener to handle the drop onto the board slots
                    slot.addEventListener('drop', drop);
                }
            } else {
                if (row >= 0 && row <= 3) {

                    slot.setAttribute('ondrop', 'drop(event)');
                    slot.setAttribute('ondragover', 'allowDrop(event)');

                    slot.id = `cell-${row}-${col}`;

                    // Add a dragover event listener to allow dropping on the board slots
                    slot.addEventListener('dragover', allowDrop);

                    // Add a drop event listener to handle the drop onto the board slots
                    slot.addEventListener('drop', drop);

                } else if (row === 4 || row === 5) {
                    if ((col === 2 || col === 3 || col === 6 || col === 7)) {
                        slot.style.backgroundColor = 'lightblue';
                    } else {
                        slot.style.backgroundColor = 'gray';
                    }
                } else {
                    slot.style.backgroundColor = 'gray';
                }
            }
            // Append the slot to the board
            gameBoard.appendChild(slot);
        }
    }

}

// Drag and drop functions
function allowDrop(event) {
    event.preventDefault();
}

function PieceLoad() {
    // Create the piece pool dynamically
    const piecePool = document.getElementById('piece-pool');
    const imagesPath = '../images/';
    pieceData.forEach(piece => {
        for (let i = 1; i <= piece.quantity; i++) {
            const pieceElement = document.createElement('div');
            pieceElement.className = 'piece';
            piece.icon = imagesPath + piece.icon;
            pieceElement.style.backgroundColor = piece.color;
            pieceElement.innerHTML = `<b>${piece.rank}</b><img src="${piece.icon}" style="max-width: 65%; max-height: 65%;" draggable="false"/>`;
            pieceElement.draggable = true;
            pieceElement.id = `piece-${piece.id}-${i}`; // Unique identifier for each piece

            // Set tooltip (title) with piece type
            pieceElement.title = piece.type;

            // Set the data-piece-data attribute
            const pieceDataAttr = JSON.stringify({
                id: piece.id,
                color: pcolor
            });
            pieceElement.dataset.pieceData = pieceDataAttr;

            // Add a dragstart event listener to store data about the dragged piece
            pieceElement.addEventListener('dragstart', dragStart);

            // Append the piece to the pool
            piecePool.appendChild(pieceElement);
        }
    });
}

window.onload = function () {
    pieceData.forEach(piece => {
        if (pcolor === 'R') {
            piece.color = '#990000';
        } else {
            piece.color = '#003366';
        }
    });
    // Call PieceLoad function after updating pieceData
    PieceLoad();
};


function dragStart(event) {
    // Store the dragged piece's ID in the data transfer object
    event.dataTransfer.setData('text', event.target.id);
}

function drop(event) {
    event.preventDefault();
    // Only allow dropping if the board is not locked

    const data = event.dataTransfer.getData('text');
    const draggedElement = document.getElementById(data);

    // Check if the drop target is a board slot or a pool slot
    const dropTarget = event.target;
    if (dropTarget.classList.contains('slot') || dropTarget.classList.contains('pool')) {
        // Append the dragged piece to the drop target
        dropTarget.appendChild(draggedElement);
        checkAllPiecesPlaced();
    }

}

function checkAllPiecesPlaced() {
    const totalPieces = pieceData.reduce((count, piece) => count + piece.quantity, 0);
    const placedPieces = document.getElementById('game-board').querySelectorAll('.piece').length;

    // If all pieces are placed on the board, enable the Ready button
    if (placedPieces === totalPieces) {
        document.getElementById('readyButton').disabled = false;
    }
}


function initializeBoard() {
    document.getElementById('piece-pool').style.display = 'none';
    document.getElementById('piece-pool').setAttribute('disabled', 'true');
    document.getElementById('readyButton').style.display = 'none';
    document.getElementById('randomize').style.display = 'none';
    document.getElementById('clear').style.display = 'none';
    const initialBoardState = collectBoardState();

    //show the array board
    console.log('Initial board state:', initialBoardState);

    //now i can send the array 
    saveBoardState(initialBoardState);


    updatePlayerStatus();
}

document.addEventListener('DOMContentLoaded', function () {
    // Add an event listener for when the DOM is fully loaded
    checkAllPiecesPlaced(); // Check the initial state of the board
});

function collectBoardState() {
    const boardState = [];

    // Iterate through each slot on the board
    const slots = document.querySelectorAll('.slot');
    slots.forEach(slot => {
        // Look for the piece element within the slot
        const piece = slot.querySelector('.piece');

        if (piece) {
            const pieceDataAttr = piece.dataset.pieceData;
            if (pieceDataAttr) {
                const pieceData = JSON.parse(pieceDataAttr);

                // Extract the relevant information
                const {
                    id,
                    color
                } = pieceData;

                // Extract position from slot id
                const [positionX, positionY] = slot.id.split('-').slice(1).map(Number);

                boardState.push({
                    id: id,
                    color: color,
                    position_x: positionX + 1,
                    position_y: positionY + 1,
                });
            }
        }
    });
    return boardState;
}

function saveBoardState(boardState) {
    const saveBoardStateURL = '../Scripts/save_board_state.php';

    fetch(saveBoardStateURL, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            boardState
        }),
    })
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! Status: ${response.status}`);
            }
            return response.text(); // Read the response as text
        })
        .then(data => {
            const jsonData = data.substring(data.indexOf('{')); // Extract JSON part
            const parsedData = JSON.parse(jsonData);
            if (parsedData.status === 'success') {

            }
        })
        .catch(error => {
            console.error('Fetch error:', error);
        });
}

// Random TRY Place Pieces!

// Function to randomly place pieces on the board
function clearBoard() {
    document.getElementById('readyButton').disabled = true;
    const boardSlots = document.querySelectorAll('.slot');
    let isEmpty = true;

    boardSlots.forEach(slot => {
        if (slot.firstChild) {
            isEmpty = false;
            return;
        }
    });

    if (!isEmpty) {
        PieceLoad();
        boardSlots.forEach(slot => {
            while (slot.firstChild) {
                slot.removeChild(slot.firstChild);
            }
        });
    }
}

// Function to randomly place pieces on the board
function randomizePieces() {
    const shuffledPieces = shuffleArray([...document.querySelectorAll('.piece')]);
    const boardSlots = [...document.querySelectorAll('.slot')];

    let placedPieces = 0;

    if (pcolor === 'B') {
        shuffledPieces.forEach((piece, index) => {
            const emptySlot = getRandomEmptySlot(boardSlots.filter(slot => {
                const [row] = slot.id.split('-').slice(1).map(Number);
                return [6, 7, 8, 9].includes(row);
            }));

            if (emptySlot !== null) {
                emptySlot.appendChild(piece);
                placedPieces++;

                const filledSlotIndex = boardSlots.findIndex(slot => slot === emptySlot);
                if (filledSlotIndex !== -1) {
                    boardSlots.splice(filledSlotIndex, 1);
                }
            }
        });
    } else {
        shuffledPieces.forEach((piece, index) => {
            const emptySlot = getRandomEmptySlot(boardSlots.filter(slot => {
                const [row] = slot.id.split('-').slice(1).map(Number);
                return [0, 1, 2, 3].includes(row);
            }));

            if (emptySlot !== null) {
                emptySlot.appendChild(piece);
                placedPieces++;

                const filledSlotIndex = boardSlots.findIndex(slot => slot === emptySlot);
                if (filledSlotIndex !== -1) {
                    boardSlots.splice(filledSlotIndex, 1);
                }
            }
        });
    }

    if (placedPieces < shuffledPieces.length) {
        clearBoard();
        randomizePieces();
    } else {
        checkAllPiecesPlaced();
    }
}

// Function to shuffle an array using Fisher-Yates algorithm
function shuffleArray(array) {
    for (let i = array.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [array[i], array[j]] = [array[j], array[i]];
    }
    return array;
}

// Function to get a random empty slot
function getRandomEmptySlot(slots) {
    const emptySlots = slots.filter(slot => slot.childElementCount === 0);
    if (emptySlots.length === 0) {
        return null; // Return null if no empty slots are available
    }


    const randomIndex = Math.floor(Math.random() * emptySlots.length);
    return emptySlots[randomIndex];
}

function checkGameReady() {
    const checkPlayersReadyURL = '../Scripts/checkGameReady.php';

    fetch(checkPlayersReadyURL, {
        method: 'GET',
    })
        .then(response => response.json())
        .then(data => {

            if (data.status === 'success') {
                if (data.action === 'update') {
                    window.location.href = '../views/Main.php';
                }
            } else if (data.status === 'not_ready') {

            } else {
                // Handle error, if needed
            }
        })
        .catch(error => {
            console.error('Fetch error:', error);
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

function updatePlayerStatus() {
    const updatePlayerStatusURL = '../Scripts/playerSetReady.php';

    fetch(updatePlayerStatusURL, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
    })
        .then(response => response.json())
        .then(data => {
            console.log('Server response:', data);

            if (data.status === 'success') {
                // Handle success, if needed
            } else {
                // Handle error, if needed
            }
        })
        .catch(error => {
            console.error('Fetch error:', error);
        });
}
