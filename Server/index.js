import RouterMain from './app/routers/router';
import express, { Router } from 'express';
const logger = require('morgan');
const app = express();
require('dotenv').config();
const port = process.env.PORT || 8080;
app.get('/', (req, res) => {
    res.send("Máy chủ FoodApp đang hoạt động!");
})
const cors = require('cors');
app.use(cors());



app.use(logger('dev'));
// xử lý file, json, url, cookies
app.use(express.json());
app.use(express.urlencoded({ extended: false }));


RouterMain(app);


app.listen(port,function () {
    console.log("Máy chủ FoodApp đang chạy trên cổng: " + port);
})