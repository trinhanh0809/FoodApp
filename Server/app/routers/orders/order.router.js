import { getOrder, postOrder } from "../../controllers/orders/order.controller";
export default function OrderRouter(app) {
    app.get("/list/:user_id", getOrder);
    app.post("/post_orders", postOrder);
    return app;
}