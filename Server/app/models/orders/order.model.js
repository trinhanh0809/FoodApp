import pool from "../../../configs/database/database.config";
class Orders {
    static listOrder = async (id) => {
        try {
            const sql = "SELECT O.user_id, O.id as order_id,F.price , F.id as food_id, F.name, F.ingredients, F.img_thumbnail, O.order_datetime, O.quantity ,O.total_price FROM orders as O INNER JOIN food as F ON O.food_id = F.id WHERE O.user_id = ? ORDER BY O.order_datetime DESC";
            const [result] = await pool.query(sql, [id]);
            if (result.length > 0) {
                return result;
            } else {
                return false;
            }
        } catch (error) {
            return false;
        }
    }

    static uploadOrder = async (params) => {
        try {
            const sql = "INSERT INTO orders (food_id, user_id, quantity, total_price) VALUES (?,?,?,?);";
            await pool.query(sql, [params.food_id, params.user_id, params.quantity, params.total_price]);

            const updateSql = "UPDATE food SET total_orders = total_orders + ? WHERE id = ?;";
            await pool.query(updateSql, [params.quantity, params.food_id]);

            return true;

        } catch (error) {
            return false;
        }
    }

    

}
export default Orders;