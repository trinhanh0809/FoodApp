import Orders from "../../models/orders/order.model";
export async function getOrder(req, res) {
    const idUser = req.params.user_id;
    try {
        const data = await Orders.listOrder(idUser);
        if (data.length > 0) {
            res.status(200).json({ "status": true, "data": data });
        } else {
            res.status(404).json({ "status": false, "message": "Không tìm thấy đơn hàng nào" });
        }
    } catch (error) {
        res.status(404).json({ "status": false, "message": "Lỗi server" });
    }

}

export async function postOrder(req, res) {
    const order = {
        food_id: req.body.food_id,
        user_id: req.body.user_id,
        quantity: req.body.quantity,
        total_price: req.body.total_price
    };

    try {
        const data = await Orders.uploadOrder(order);
        console.log(data);
        if (data) {
            res.status(200).json({ "status": true, "message": "Đơn hàng đã đặt thành công! Vui lòng sẵn điện thoại để nhận cuộc gọi từ người vận chuyển" });
        } else {
            res.status(404).json({ "status": false, "message": "Lỗi bất định !" });
        }
    } catch (error) {
        res.status(404).json({ "status": false, "message": "Lỗi server" });
    }

}

