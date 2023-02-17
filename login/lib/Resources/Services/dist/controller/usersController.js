"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const usersModel_1 = __importDefault(require("../model/usersModel"));
const jwt = require('jsonwebtoken');
class usersController {
    constructor() {
        this.login = (req, res) => {
            const { email, password } = req.body;
            this.model.login(email, password, (validation) => {
                if (validation == 1) {
                    const token = jwt.sign({
                        email: email,
                        password: password
                    }, process.env.TOKEN_SECRET);
                    res.header('auth-token', token).json({
                        error: null,
                        data: { token }
                    });
                }
                else if (validation == 0) {
                    return res.status(404).json({ message: 'Email o contraseña incorrecta!' });
                }
                else {
                    return res.status(404).json({ error: false, message: 'Upss, algo ha salido mal!' });
                }
            });
        };
        this.verifyToken = (req, res) => {
            const { token } = req.body;
            if (!token) {
                return res.status(401).json({ error: 'Acceso denegado!' });
            }
            try {
                const verified = jwt.verify(token, process.env.TOKEN_SECRET);
                if (verified) {
                    res.status(200).json({ message: 'Inicio de sesion exitoso!' });
                }
            }
            catch (error) {
                res.status(406).json({ error: 'EL token no es válido!' });
            }
        };
        this.model = new usersModel_1.default();
    }
}
exports.default = usersController;
