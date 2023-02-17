"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const usersModel_1 = __importDefault(require("../model/usersModel"));
class usersController {
    constructor() {
        this.login = (req, res) => {
            const { email, password } = req.body;
            this.model.login(email, password, (validation) => {
                if (validation == 1) {
                    return res.json({ message: 'Inicio de sesion exitoso!' });
                }
                else if (validation == 0) {
                    return res.json({ message: 'Email o contraseña incorrecta!' });
                }
                else {
                    return res.status(404).json({ error: false, message: 'Upss, algo ha salido mal!' });
                }
            });
        };
        this.model = new usersModel_1.default();
    }
}
exports.default = usersController;
