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
        this.router.post("/biometric/enable", this.controller.verifyToken, this.controller.enable_biometric);
        this.router.post("/biometric/disable", this.controller.verifyToken, this.controller.disable_biometric)
    }
}

export default usersRoute;