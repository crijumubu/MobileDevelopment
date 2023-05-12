import { Router } from "express";
import userController from "../controller/usersController";

class usersRoute{

    public router: Router;
    public controller: userController;

    constructor(){

        this.router = Router();
        this.controller = new userController();
        this.config();
    }

    public config(){

        this.router.post("/login", this.controller.login);
        this.router.post("/register", this.controller.register);
        this.router.post("/message", this.controller.verifyToken, this.controller.sendMessage);
        this.router.get("/users", this.controller.verifyToken, this.controller.getUsers);
        this.router.get("/sent/messages/:to", this.controller.verifyToken, this.controller.getSentMessages);
        this.router.get("/received/messages/:from", this.controller.verifyToken, this.controller.getReceivedMessages);
    }
}

export default usersRoute;