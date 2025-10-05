
-- create database, switch to database
-- CREATE DATABASE board_game_cafe;
-- USE board_game_cafe;

-- Create tables 
-- customers / members 
CREATE TABLE members (
  member_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  phone VARCHAR(20),
  join_date DATE NOT NULL DEFAULT (CURRENT_DATE),
  points INT NOT NULL DEFAULT 0,
  membership_type ENUM('standard','premium') NOT NULL DEFAULT 'standard'
);

-- menu items (food and drinks)
CREATE TABLE menu_items (
  item_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description VARCHAR(255),
  price DECIMAL(6,2) NOT NULL CHECK (price > 0),
  is_food TINYINT(1) NOT NULL DEFAULT 1,
  calories INT DEFAULT NULL
);

-- purchases of menu items (links to membership) 
CREATE TABLE purchases (
  purchase_id INT AUTO_INCREMENT PRIMARY KEY,
  member_id INT NULL,
  item_id INT NOT NULL,
  quantity INT NOT NULL CHECK (quantity > 0),
  total_price DECIMAL(8,2) NOT NULL CHECK (total_price >= 0),
  purchase_time DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE SET NULL,
  FOREIGN KEY (item_id) REFERENCES menu_items(item_id) ON DELETE CASCADE
);

-- board games available for play/rental
CREATE TABLE games (
  game_id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(120) NOT NULL,
  min_players INT NOT NULL,
  max_players INT NOT NULL,
  genre VARCHAR(50),
  daily_rental_price DECIMAL(6,2) DEFAULT 0.00,
  status ENUM('available','rented','maintenance') NOT NULL DEFAULT 'available'
);

-- board game rentals for members
CREATE TABLE rentals (
  rental_id INT AUTO_INCREMENT PRIMARY KEY,
  member_id INT NOT NULL,
  game_id INT NOT NULL,
  rent_date DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  return_date DATETIME DEFAULT NULL,
  fee DECIMAL(8,2) DEFAULT 0.00,
  FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
  FOREIGN KEY (game_id) REFERENCES games(game_id) ON DELETE CASCADE
);


-- Insert data 
-- members data
INSERT INTO members (first_name, last_name, email, phone, membership_type) VALUES
('Alice','Johnson','alice.j@example.com','+44 20 7000 0001','premium'),
('Ben','Smith','ben.smith@example.com','+44 20 7000 0002','standard'),
('Chloe','Wang','chloe.w@example.com','+44 20 7000 0003','standard'),
('David','O''Neil','david.oneil@example.com','+44 20 7000 0004','standard'),
('Emma','Patel','emma.patel@example.com','+44 20 7000 0005','premium'),
('Faisal','Khan','faisal.k@example.com','+44 20 7000 0006','standard'),
('Gabriela','Ruiz','gabriela.r@example.com','+44 20 7000 0007','standard'),
('Hiro','Tanaka','hiro.t@example.com','+44 20 7000 0008','standard');

-- menu items data - food and drinks 
INSERT INTO menu_items (name, description, price, is_food) VALUES
('Espresso','Single shot black coffee',1.80,0),
('Latte','Espresso with steamed milk',3.20,0),
('Cappuccino','Espresso, steamed milk, foam',3.40,0),
('Earl Grey Tea','Loose leaf tea',2.00,0),
('Orange Juice', 'Freshly squeezed orange juice', 2.00,0), 
('Ham Sandwich','Toasted ham sandwich',4.50,1),
('Garden Salad','Mixed leaves and vegetables',4.00,1),
('Chocolate Cookie','Baked cookie',1.50,1),
('Berry Smoothie','Mixed berry & yogurt',3.80,1);

-- board games info data 
INSERT INTO games (title, min_players, max_players, genre, daily_rental_price, status) VALUES
('Catan',3,4,'Strategy',2.50,'available'),
('Ticket to Ride',2,5,'Strategy',2.00,'available'),
('Carcassonne',2,5,'Family',1.80,'available'),
('Pandemic',2,4,'Cooperative',2.50,'available'),
('Azul',2,4,'Abstract',1.50,'available'),
('Sushi Go',2,5,'Card',1.00,'available'),
('Dominion',2,4,'Deckbuilding',1.80,'available'),
('Splendor',2,4,'Strategy',1.90,'available');

-- purchases data 
INSERT INTO purchases (member_id, item_id, quantity, total_price, purchase_time) VALUES
(1, 2, 1, 3.20, '2025-10-02 11:05:00'),
(2, 5, 2, 9.00, '2025-10-02 12:15:00'),
(3, 1, 1, 1.80, '2025-10-03 09:30:00'),
(4, 3, 2, 6.80, '2025-10-03 14:20:00'),
(5, 8, 1, 3.80, '2025-10-04 16:00:00'),
(6, 7, 3, 4.50, '2025-10-04 17:10:00'),
(7, 4, 1, 2.00, '2025-10-04 17:30:00'),
(NULL, 1, 2, 3.60, '2025-10-05 10:00:00'); -- guest purchase (no member_id)

-- 
INSERT INTO rentals (member_id, game_id, rent_date, return_date, fee) VALUES
(1, 1, '2025-10-01 18:00:00', '2025-10-01 21:30:00', 2.50),
(2, 2, '2025-10-02 19:00:00', NULL, 2.00),
(3, 3, '2025-10-02 17:00:00', '2025-10-02 18:30:00', 1.80),
(4, 4, '2025-10-03 20:00:00', '2025-10-04 01:00:00', 2.50),
(5, 5, '2025-10-03 15:00:00', NULL, 1.50),
(6, 6, '2025-10-04 13:00:00', '2025-10-04 15:00:00', 1.00),
(7, 7, '2025-10-04 16:00:00', NULL, 1.80),
(8, 8, '2025-10-05 11:00:00', NULL, 1.90);

-- ---------------------------------------

-- Stored Procedure: records purchase and updates member loyalty points (1 point per £1 spent) -- 
DELIMITER //
CREATE PROCEDURE record_purchase(
  IN p_member_id INT,
  IN p_item_id INT,
  IN p_quantity INT
)
BEGIN
  DECLARE v_price DECIMAL(6,2);
  DECLARE v_total DECIMAL(8,2);

  START TRANSACTION;
    -- Get the price of the item
    SELECT price INTO v_price
    FROM menu_items
    WHERE item_id = p_item_id;

    IF v_price IS NULL THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Error: Menu item not found.';
    END IF;

    -- Calculate total
    SET v_total = v_price * p_quantity;

    -- Insert new purchase record
    INSERT INTO purchases (member_id, item_id, quantity, total_price)
    VALUES (p_member_id, p_item_id, p_quantity, v_total);

    -- Update member points (1 point per £1 spent)
    IF p_member_id IS NOT NULL THEN
      UPDATE members
      SET points = points + FLOOR(v_total)
      WHERE member_id = p_member_id;
    END IF;
  COMMIT;
END //
DELIMITER ;


-- Ben Smith bought orange juice x 1:
-- CALL record_purchase(2, 3, 1);

-- ----------------------------------
-- Queries --
-- aggregate function: calculate total revenue of purchases
SELECT COUNT(*) AS total_purchases,
       SUM(total_price) AS total_revenue
FROM purchases;

-- aggregate function + GROUP BY + ORDER BY: calculate revenue per menu item 
SELECT mi.name AS item_name,
       COUNT(p.purchase_id) AS times_sold,
       SUM(p.total_price) AS total_revenue
FROM purchases p
JOIN menu_items mi ON p.item_id = mi.item_id
GROUP BY mi.name
ORDER BY total_revenue DESC;

-- Aggregate function: average item price
SELECT ROUND(AVG(price), 2) AS avg_menu_price
FROM menu_items;

-- joins + built-in functions: show formatted purchase details
SELECT p.purchase_id,
       CONCAT(m.first_name, ' ', m.last_name) AS member_name,
       mi.name AS item_name,
       p.quantity,
       ROUND(p.total_price, 2) AS total_spent,
       DATE_FORMAT(p.purchase_time, '%Y-%m-%d %H:%i') AS purchase_time
FROM purchases p
LEFT JOIN members m ON p.member_id = m.member_id
JOIN menu_items mi ON p.item_id = mi.item_id
ORDER BY p.purchase_time DESC;

-- join 2: show all rentals and info with member names 
SELECT r.rental_id,
       CONCAT(m.first_name, ' ', m.last_name) AS member_name,
       g.title AS game_title,
       r.rent_date,
       r.return_date,
       r.fee
FROM rentals r
JOIN members m ON r.member_id = m.member_id
JOIN games g ON r.game_id = g.game_id
ORDER BY r.rent_date DESC;

-- Built-in function: show menu items in uppercase
SELECT UPPER(name) AS item_name_uppercase
FROM menu_items
ORDER BY name;

-- UPDATE: add loyalty points manually
UPDATE members
SET points = points + 10
WHERE membership_type = 'premium';

-- Built-in + ORDER BY: top 5 spending members
SELECT CONCAT(m.first_name, ' ', m.last_name) AS member_name,
       SUM(p.total_price) AS total_spent
FROM purchases p
JOIN members m ON p.member_id = m.member_id
GROUP BY m.member_id
ORDER BY total_spent DESC
LIMIT 5;

-- Delete purchases made by guest (no member_id)
DELETE FROM purchases
WHERE member_id IS NULL;


