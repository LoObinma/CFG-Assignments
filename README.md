# 📚 Book Swap API

This API built with Node.js, Express and MySQL2, allows users to manage books, swaps, and user information in a book-swapping application.

---

## 💡 Features

- Fetch all books and users
- Create new swap requests
- Update existing user details
- Delete users
- Uses **environment variables** for secure configuration
- Includes **error handling** with proper HTTP status codes
- Uses a **run function** (`runServer()`) to test the database connection before starting the server
---

## ⚙️ Installation & Setup

###  Clone the repository 

```bash
git clone <your-repository-url>
cd <your-project-folder>
```


### Install dependencies

Install the required packages with npm:
```bash
npm install express
npm install mysql2
npm install dotenv
```


### Create a .env file 

In the root directory, create a .env file to store your credentials. Example contents:
```ini
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_DATABASE=Book_Swap
PORT=3000
```
add .env file to a .gitignore to prevent committing sensitive information.


### Set up database 

Your MySQL database must be named **Book_Swap** and include the following tables:
- users
- books
- swaps

**Option 1: Using MySQL Workbench**

1. Open MySQL Workbench and connect to your MySQL server.
2. Create a new schema/database named Book_Swap.
3. Use the SQL editor to run the SQL statements to create the tables (users, books, swaps).
4. Ensure the tables have the correct columns and foreign keys.

**Option 2: Using a SQL script (optional)**

If you have a SQL file (e.g., sql/schema.sql), you can run it from the terminal:
```bash
mysql -u root -p < sql/schema.sql
```

### Start the server 

The server uses a run function (runServer()) that tests the database connection before starting.
```bash
node index.js
```
You should see:
```
Database connected successfully.
Server running on http://localhost:3000
```

---

## 🛜 API Endpoints 

- **GET** `/books` – Fetch all books
- **GET** `/users` – Fetch all users
- **POST** `/swaps` – Create a swap request
- **PUT** `/update-user/:id` – Update user details
- **DELETE** `/delete-user/:id` – Delete a user

### Example Request: Create a Swap

**Endpoint:** `POST /swaps`  

**Request Body:**

```json
{
  "book_id": 1,
  "requester_id": 2
}
```

**Response:**
```json
{
  "message": "Swap requested",
  "id": 5
}
```

## Notes 

- Ensure .env is correctly configured before running the server.
- Set up the Book_Swap database and tables before starting the API.
- The server must be running to test any endpoints.
- All SQL operations are handled asynchronously using a MySQL connection pool.
