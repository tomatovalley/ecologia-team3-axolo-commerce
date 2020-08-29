var mysql = require("mysql");
var dotenv = require("dotenv");

dotenv.config();

var connection = mysql.createConnection({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  //socket   : '/Applications/MAMP/tmp/mysql/mysql.sock',
  database: process.env.DB_NAME,
});

connection.connect(function (err) {
  if (err) {
    console.log(err);
    //throw err;
  } else {
    console.log("DB connected :)");
  }
});

module.exports = connection;
