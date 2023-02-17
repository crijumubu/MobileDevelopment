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
            this.model.login(email, password, (error, status, row) => {
                if (error) {
                    return res.json({ error: true, message: 'Upss, algo ha salido mal!' });
                }
                if (status == 1) {
                    return res.json({ message: 'Inicio de sesion exitoso!', row });
                }
                else if (status == 0) {
                    return res.json({ message: 'Contraseña incorrecta!' });
                }
                else {
                    return res.status(404).json({ error: false, message: 'Upss, no pudimos encontrar tu cuenta!' });
                }
            });
        };
        this.model = new usersModel_1.default();
    }
}
exports.default = usersController;
