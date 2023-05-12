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
        this.router.post("/message", this.controller.verifyToken, this.controller.sendMessage);
        this.router.get("/users", this.controller.verifyToken, this.controller.getUsers);
        this.router.get("/sent/messages/:to", this.controller.verifyToken, this.controller.getSentMessages);
        this.router.get("/received/messages/:from", this.controller.verifyToken, this.controller.getReceivedMessages);
    }
}
exports.default = usersRoute;
