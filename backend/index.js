require('dotenv').config();
const express = require('express');
const mysql = require('mysql2');
const taskRoutes = require("./routers/tasksRouter");

const app = express();
const port = 3000;
const prisma = require('./prismaClient');

app.use(express.json());

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

app.use('/tasks',taskRoutes);

app.get('/', (req, res) => {
    console.log('start getmethod');
    res.send('Hello, Backend is running!');
});

app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});

app.get('/users', async (req, res) => {
    console.log('get users start');
    const users = await prisma.user.findMany();
    res.json({ status: 'success', data: users });
});
