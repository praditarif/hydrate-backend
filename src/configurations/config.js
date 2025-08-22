// src/configurations/config.js
require('dotenv').config();

const config = {
  port: process.env.PORT || 3001,
  databaseUrl: process.env.DATABASE_URL,
  jwt: {
    secret: process.env.JWT_SECRET_KEY,
    expire: process.env.JWT_EXPIRE || '1h',
  },
};

module.exports = config;