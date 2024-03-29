"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const usersController_1 = __importDefault(require("../controller/usersController"));
class usersRoute {
    constructor() {
        this.router = (0, express_1.Router)();
        this.controller = new usersController_1.default();
        this.config();
    }
    config() {
        this.router.post("/login", this.controller.login);
        this.router.post("/register", this.controller.register);
        this.router.post("/favorite", this.controller.verifyToken, this.controller.addFavorites);
        this.router.get("/products", this.controller.verifyToken, this.controller.getProducts);
        this.router.get("/favorites", this.controller.verifyToken, this.controller.getFavorites);
        this.router.get("/image/:id", this.controller.verifyToken, this.controller.getProductImage);
    }
}
exports.default = usersRoute;
