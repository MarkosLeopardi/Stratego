# Stratego – Web-Based Turn-Based Strategy Game

## Overview

This project is a **web-based implementation of the classic board game Stratego**, developed as part of a **university team project**.

The goal of the project was to create a playable multiplayer strategy game where two players can log in, set up their pieces, and play against each other through a browser-based interface.

The application includes both **front-end gameplay interaction** and a **backend API/database structure** to manage the game state, board, players, and piece movement.

---

## Live Demo

[Play the game here](https://users.iee.ihu.gr/~it175128/ADISE23_Stratego/STRATEGO/views/login.php)

---

## Game Description

Stratego is a classic **two-player strategy board game** where each player controls an army of 40 pieces with different ranks and roles.

The objective is to **capture the opponent’s flag** while protecting your own.

Each piece has different movement and attack rules, and the game requires both tactical positioning and strategic decision-making.

---

## Purpose

The main purpose of this project was to:

- Build a more complete **interactive web application**
- Practice implementing **turn-based game logic**
- Work with **PHP APIs**, **JavaScript**, **AJAX**, and **MySQL**
- Simulate a more complex system involving **authentication, state management, and gameplay rules**

---

## Tech Stack

- **PHP**
- **JavaScript**
- **AJAX**
- **MySQL**
- **HTML5**
- **CSS3**

---

## Features

- User **register / login**
- Two-player game setup
- Piece placement on the board
- **Drag and drop** interaction for game pieces
- Turn-based gameplay
- Movement validation
- Game state management
- Board state persistence through the database
- Tracking of removed pieces

---

## Database Structure

The database includes the following main tables:

- **board** → stores the game board state
- **players** → stores player information and login state
- **pieces** → stores all Stratego piece definitions
- **game_status** → tracks game progression and turn state
- **moves** → stores move history
- **RemovedPiecesPool** → tracks pieces removed from the game

---

## API Overview

The application includes a backend API for managing:

### Board
- Reading board data
- Initializing/resetting the game
- Updating the board state

### Piece
- Reading piece position and information
- Updating piece movement

### Player
- Retrieving player information
- Assigning player details and tokens

### Status
- Checking turn changes and game status

---

## What I Practiced

Through this project, I worked on:

- Implementing **game logic and rule validation**
- Building functionality around **turn-based interactions**
- Working with **AJAX requests** and PHP backend communication
- Understanding how to manage **game state** through a database
- Structuring a project with both **front-end and backend logic**
- Thinking more in terms of **systems and gameplay flow**

---

## My Contribution

This project was developed as part of a university team project.

My contribution focused mainly on:

- **PHP API development**
- **JavaScript gameplay logic**
- **AJAX communication**
- Supporting the overall interaction between the front-end and backend

---

## Current Limitations

Due to time constraints, some features were not fully completed:

- Multiple game sessions
- Full implementation of the **Scout’s special movement**
- Persistent gameplay continuation if a player logs out and returns

---

## Future Improvements

Possible future improvements include:

- Support for multiple simultaneous games
- Better session persistence
- Full implementation of all special Stratego rules
- Improved UI/UX and responsiveness
- Cleaner architecture and code refactoring

---

## Run Locally

(Adjust this section depending on your local setup)

- Import the MySQL database
- Run the project through a local PHP server (e.g. XAMPP / Laragon / Apache)
- Configure database connection settings
- Open the application in your browser

---

## Team

- **Dimitrios Toumpas** – MySQL database design, PHP API, AJAX
- **Markos Leopardi** – PHP API, JavaScript, AJAX
- **Galle Michailia** – HTML, JavaScript, PHP API, SQL

---

## Author

Developed as part of a university project.

