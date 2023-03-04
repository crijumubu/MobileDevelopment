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
            this.model.login(email, password, (row) => {
                if (Object.keys(row).length != 0) {
                    const username = JSON.parse(JSON.stringify(row))[0]['name'];
                    const token = jwt.sign({ name: username, email: email, password: password }, process.env.TOKEN_SECRET, { expiresIn: '7d', algorithm: "HS256" });
                    res.header('auth-token', token).json({ error: null, data: { token } });
                }
                else if (Object.keys(row).length == 0) {
                    return res.status(404).json({ message: 'Email o contraseña incorrecta!' });
                }
            });
        };
        this.verifyToken = (req, res, next) => {
            const { authorization } = req.headers;
            if (!authorization) {
                return res.status(401).json({ error: 'No se ha proporcionado un token de acceso. Acceso denegado!' });
            }
            const bearerToken = authorization.split(' ')[1];
            try {
                const decodedToken = jwt.verify(bearerToken, process.env.TOKEN_SECRET);
                req.body.user = decodedToken;
                next();
            }
            catch (error) {
                if (error instanceof jwt.TokenExpiredError) {
                    res.status(200).json({ message: 'El token ha expirado!' });
                }
                else {
                    res.status(406).json({ error: 'EL token no es válido!' });
                }
            }
        };
        this.getProducts = (req, res) => {
            this.model.getProducts((row) => {
                if (Object.keys(row).length != 0) {
                    res.status(200).json(row);
                }
                else {
                    return res.status(404).json({ error: false, message: 'No hay disponibles para mostrar!' });
                }
            });
        };
        this.model = new usersModel_1.default();
    }
}
exports.default = usersController;
