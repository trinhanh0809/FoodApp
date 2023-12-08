import Users from "../../models/users/user.model";

// Chú ý: không sử dụng từ khóa "async" trực tiếp trước từ khóa "export"
export const userLogin = async (req, res) => {
    try {
        const result = await Users.checkLogin({
            phone_number: req.body.phone_number,
            password: req.body.password
        });
        // Xử lý kết quả ở đây, ví dụ trả về response JSON
        if (result) {
            console.log(result["id"]);
            res.status(200).json({ success: true, data: result["id"] });

        } else {
            res.status(401).json({ success: false, message: "Phone number or password is incorrect" });
        }
    } catch (error) {
        console.error(error.message);
        res.status(500).json({ success: false, message: "Lỗi server." });
    }
};


export const userSignup = async (req, res) => {
    try {
        const checkPhoneNumber = await Users.checkPhoneNumber(req.body.phone_number);

        if (checkPhoneNumber) {
            res.status(400).json({ success: false, message: "Phone number is already used by another account" });
        } else {
            const newUser = await Users.signUpAction({
                name: req.body.name,
                phone_number: req.body.phone_number,
                address: req.body.address,
                password: req.body.password,
                avatar_thumbnail: "https://cdn-icons-png.flaticon.com/512/186/186313.png",
            });

            res.status(200).json({ success: true, message: "Đăng ký thành công" });
        }
    } catch (error) {
        console.error(error.message);
        res.status(500).json({ success: false, message: "Lỗi server." });
    }
};



export const getUserByID = async (req, res) => {
    try {
        const infoUser = await Users.findUserByID(req.params.id);

        if (infoUser) {
            res.status(200).json({ success: true, data: infoUser});
        } else {
            
            res.status(400).json({ success: false, data: "Không tìm thấy người dùng nào phù hợp" });
        }
    } catch (error) {
        console.error(error.message);
        res.status(500).json({ success: false, message: "Lỗi server." });
    }
};
