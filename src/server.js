require('dotenv').config();
const express = require('express');
const { PrismaClient } = require('@prisma/client');

const app = express();
const prisma = new PrismaClient();
const port = process.env.PORT || 3001;

// Middleware untuk parsing JSON
app.use(express.json());

// === ROUTES ===
app.get('/', (req, res) => {
  res.send('Backend Hydrate API is running with Prisma');
});

// Endpoint untuk mengetes koneksi database
app.get('/health', async (req, res) => {
  try {
    await prisma.$queryRaw`SELECT 1`;
    res.status(200).json({ status: 'OK', database: 'Connected' });
  } catch (err) {
    console.error("Database connection failed:", err);
    res.status(500).json({ status: 'Error', database: 'Connection Failed', details: err.message });
  }
});

// (Di sini nanti Anda akan menghubungkan semua router Anda)

// === SERVER LISTENER ===
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});