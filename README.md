# Board Game Café Database 🎲

A relational MySQL database designed to model the operations of a board game
café, including members, menu purchases and game rentals.

## Database Structure 👩🏾‍💻

The database contains five related tables:

- `members`
- `menu_items`
- `purchases`
- `games`
- `rentals`

## Features

The project demonstrates relational database design, primary and foreign key
relationships, data manipulation, joins, aggregate queries and stored procedures.

The `record_purchase` stored procedure records a transaction and updates a
member's loyalty points based on their purchase.

## Technologies

- MySQL
- MySQL Workbench

## Running the Project ▶️

Run `board_game_cafe.sql` in MySQL Workbench to create the database, populate
the tables with sample data and run the included queries.
