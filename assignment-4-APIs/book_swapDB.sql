CREATE DATABASE IF NOT EXISTS Book_Swap; 

USE Book_Swap;

CREATE TABLE IF NOT EXISTS  users (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS books (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(150) NOT NULL,
  author VARCHAR(100),
  genre VARCHAR(50),
  available BOOLEAN DEFAULT TRUE,
  owner_id INT,
  FOREIGN KEY (owner_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS swaps (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    requester_id INT NOT NULL,
    swap_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'pending',
    FOREIGN KEY (book_id)
        REFERENCES books (id),
    FOREIGN KEY (requester_id)
        REFERENCES users (id)
);

INSERT INTO users (name, email) VALUES 
('Ben Jams', 'benjams@hotmail.com'),
('Isla Lolly', 'islalolly@hotmail.com'),
('Rita Bix', 'ritabix@hotmail.com');

INSERT INTO books (title, author, genre, owner_id) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 'Classic', 1),
('The Bell Jar', 'Sylvia Plath', 'Roman à clef', 3),
('1984', 'George Orwell', 'Dystopian', 2);

INSERT INTO swaps (book_id, requester_id, status) VALUES
(1, 2, 'pending'),
(2, 1, 'pending');




