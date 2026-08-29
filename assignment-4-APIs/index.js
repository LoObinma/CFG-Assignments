require('dotenv').config();
const express = require("express");
const mysql = require("mysql2/promise");

const app = express();

// JSON middleware
app.use(express.json());


// Create a MySql connection pool
const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_DATABASE,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

const PORT = process.env.PORT || 3000;

// test
app.get("/", (req, res) => {
  res.send("Express is working!");
});

// GET all books
app.get("/books", async (req, res) => {
    try {
        const [books] = await pool.query("SELECT * FROM books");
        res.status(200).json(books);
    } catch (err) {
        console.error("Error fetching books:", err.message);
        res.status(500).json({ error: "Database error"})
    }
});

// GET all users 
app.get("/users", async (req, res) => {
    try {
        const [users] = await pool.query("SELECT * FROM users");
        res.status(200).json(users);
    } catch (err) {
        console.error("Error fetching users:", err.message);
        res.status(500).json({ error: "Database error" })
    }
});

// POST swap request
app.post("/swaps", async (req, res) => {
    try {
        const { book_id, requester_id } = req.body;
        // validate input
        if (!book_id || !requester_id) {
            return res.status(400).json({ error: "book id and requester id are required"});
        }

        // insert swap request into database 
        const [newSwap] = await pool.query(
            "INSERT INTO swaps (book_id, requester_id) VALUES (?, ?)",
            [book_id, requester_id]
        );
        res.status(201).json({ message: "Swap requested", id: newSwap.insertId });
    } catch (err) {
        console.error("Error creating swap:", err.message);
        res.status(500).json({ error: "Database error"})

    }
});

// PUT update user 
app.put("/update-user/:id", async (req, res) => {
    try {
         const { name, email } = req.body;
         
         if (!name || !email) {
            return res.status(400).json({ error: "Name and email are required"});
         }
         const [updateUserResult] = await pool.query(
            "UPDATE users SET name = ?, email = ? WHERE id = ?",
            [name, email, req.params.id]
         );

         if (updateUserResult.affectedRows === 0) {
            return res.status(404).json({ message: "User not found "});
         }

         res.status(200).json({ message: "User updated successfully", affectedRows: updateUserResult.affectedRows });

    } catch (err) {
        console.error("Error updating user:", err.message);
        res.status(500).json({ error: "Database error"})
    }
});

// DELETE user 
app.delete("/delete-user/:id", async (req, res) => {
    try {
        if (!req.params.id) {
            return res.status(400).json({ error: "User ID is required"});
        }
        const [deleteUserResult] = await pool.query(
            "DELETE FROM users WHERE id =?",
            [req.params.id]
        );

        if (deleteUserResult.affectedRows === 0) {
            return res.status(404).json({ message: "User not found"});
        }

        res.status(200).json({ message: "User deleted successfully", affectedRows: deleteUserResult.affectedRows});
    } catch (err) {
        console.error("Error deleting user:", err.message);
        res.status(500).json({ error: "Database error" })
    }
})

// Run function 
async function runServer() {
  try {
    await pool.query("SELECT 1");
    console.log("Database connected successfully.");

    app.listen(PORT, () => {
      console.log(`Server running on http://localhost:${PORT}`);
    });
  } catch (err) {
    console.error("Failed to start server:", err.message);
    process.exit(1); 
  }
}

// call the function to start server
runServer();


