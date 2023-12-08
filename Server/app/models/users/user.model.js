import pool from "../../../configs/database/database.config";
class Users {
    static async signUpAction(param) {
        console.log(param);
        try {
            const query = "insert into users(name, phone_number, address, password, avatar_thumbnail) values(?,?,?,?,?)";
            const [result] = await pool.execute(query, [
                param.name,
                param.phone_number,
                param.address,
                param.password,
                param.avatar_thumbnail,
            ]);
        } catch (error) {
            console.error(error.message);
            return null;
        }
    }



    static async checkLogin({ phone_number, password }) {
        try {
            const query = "SELECT * FROM users WHERE phone_number = ? AND password = ?";
            const [result] = await pool.execute(query, [phone_number, password]);
            if (result.length > 0) {
                return result[0];
            } else {
                return false;
            }
        } catch (error) {
            console.error(error.message);
            return null;
        }
    }


    static async checkPhoneNumber(phone_number) {
        try {
            const query = "SELECT * FROM Users WHERE phone_number = ?";
            const [result] = await pool.execute(query, [phone_number]);

            if (result.length > 0) {
                return true;
            } else {

                return false;
            }
        } catch (error) {
            console.error(error.message);
            return null;
        }
    }

    static async findUserByID(id) {
        try {
            const query = "SELECT * FROM users WHERE id = ?";
            const [result] = await pool.execute(query, [id]);
            if (result.length > 0) {
                // Nếu có kết quả, trả về thông tin người dùng
                return result[0];
            } else {
                // Nếu không có kết quả, thông báo lỗi
                return false;
            }
        } catch (error) {
            console.error(error.message);
            return null;
        }
    }
}

module.exports = Users;
