import mysql from "mysql2/promise";
require("dotenv").config();

const pool = mysql.createPool({
  connectionLimit: process.env.DBCONNECTIONLIMIT,
  host: process.env.DBHOSTNAME,
  user: process.env.DBUSERNAME,
  password: process.env.DBPASSWORD,
  database: process.env.DBNAME,
});
export default pool;
