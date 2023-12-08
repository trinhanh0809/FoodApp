import { getAllFood, getFoodByID, getFoodBykeyword } from "../../controllers/foods/food.controller";
export default function FoodRouter(app) {
    app.get("/", getAllFood);
    app.get("/find/:idFood", getFoodByID);
    app.post("/search", getFoodBykeyword);
    return app;
}