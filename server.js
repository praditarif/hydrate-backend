const express = require('express');
const { Pool} = require('pg');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 3001;

const pool = new Pool({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_NAME,
    password: process.env.DB_PASSWORD,
    port: process.env.DB_PORT,
});

app.get('/', (req, res) => {
    res.send('Backend Hydrate API is running');
});

app.get('/health', async (req, res) => {
    try {
        await pool.query('SELECT NOW()');
        res.status(200).send('Database connection is healthy');
    }catch (err) {
        res.status(500).send('Database connection failed');
    }
});

app.listen(port, () =>{
    console.log(`Server is running on http://localhost:${port}`);
});