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
        this.router.post("/biometric/enable", this.controller.verifyToken, this.controller.enable_biometric);
        this.router.post("/biometric/disable", this.controller.verifyToken, this.controller.disable_biometric);
    }
}
exports.default = usersRoute;
