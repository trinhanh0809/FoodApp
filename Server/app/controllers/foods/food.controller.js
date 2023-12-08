import Food from "../../models/foods/food.model";
export async function getAllFood(req, res) {
    try {
        const listFood = await Food.listAllFood();
        if (listFood.length > 0) {
            res.status(200).json({ status: true, data: listFood });
        } else{
            console.log(error.message);
            res.status(400).json({ status: false, message: "Món ăn không có sẵn" });
        }
    } catch (error) {
        console.log(error.message);
        res.status(400).json({ status: false, message: "Món ăn không có sẵn" });
    }
}

export async function getFoodByID(req, res) {
    try {
        const foodInfo = await Food.findFoodByID(req.params.idFood);
        if (foodInfo) {
            res.status(200).json({ status: true, data: foodInfo });
        } else{
            console.log(error.message);
            res.status(400).json({ status: false, message: "Món ăn không có sẵn" });
        }
    } catch (error) {
        console.log(error.message);
        res.status(400).json({ status: false, message: "Món ăn không có sẵn" });
    }
}

export async function getFoodBykeyword(req, res) {
    try {
        const foodInfo = await Food.findFoodByKeyword(req.body.keyword);
        if (foodInfo.length > 0) {
            res.status(200).json({ status: true, data: foodInfo });
        } else{
            console.log(error.message);
            res.status(400).json({ status: false, message: "Món ăn không có sẵn" });
        }
    } catch (error) {
        console.log(error.message);
        res.status(400).json({ status: false, message: "Món ăn không có sẵn" });
    }
}


