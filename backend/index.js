require('dotenv').config();
const express = require('express');
const mysql = require('mysql2');

const app = express();
const port = 3000;

const db = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
});

db.connect(err => {
    if (err) {
        console.error('DB connection failed:', err);
    } else {
        console.log('Connected to MySQL');
    }
});

app.get('/', (req, res) => {
    res.send('Hello, Backend is running!');
});

app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
