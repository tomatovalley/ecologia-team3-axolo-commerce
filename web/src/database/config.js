const mysql = require("mysql");
const dotenv = require("dotenv");
const logger = require("../utils/logger");

dotenv.config();

/**
 * Connect to our MySQL Database
 */
const connection = mysql.createConnection({
  host: process.env.DB_HOST || "localhost",
  port: process.env.DB_PORT || 3306,
  user: process.env.DB_USER || "root",
  password: process.env.DB_PASSWORD || "",
  //socket   : '/Applications/MAMP/tmp/mysql/mysql.sock',
  database: process.env.DB_NAME || "axolotl",
});

connection.connect((err) => {
  if (err) {
    logger.error("Can't connect to database!");
    throw err;
  } else {
    logger.info("DB connected");
  }
});

module.exports = connection;
