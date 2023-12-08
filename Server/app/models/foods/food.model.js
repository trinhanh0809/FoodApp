import pool from "../../../configs/database/database.config";

class Food {
    static async listAllFood() {
        try {
            const query = "SELECT * FROM food";
            var [result] = await pool.query(query);
            if (result.length > 0) {
                return result;
            } else {
                return false;
            }
        } catch (error) {
            console.log("Failed: " + error.message);
            return false;
        }
    }

    
    static async findFoodByKeyword(keyword) {
        try {
            const query = "SELECT * FROM food WHERE CONCAT(name, description, ingredients) LIKE ?";
            var [result] = await pool.query(query, [`%${keyword}%`]);
            if (result.length > 0) {
                return result;
            } else {
                return false;
            }
        } catch (error) {
            console.log("Failed: " + error.message);
            return false;
        }
    }

    static async findFoodByID(id) {
        try {
            const query = "SELECT * FROM food WHERE id = ?";
            var [result] = await pool.query(query, [id]);
            if (result.length > 0) {
                return result[0];
            } else {
                return false;
            }
        } catch (error) {
            console.log("Failed: " + error.message);
            return false;
        }
    }
}

module.exports = Food;
