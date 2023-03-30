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
            const { email, password, token } = req.body;
            this.model.login(email, password, token, (status, response) => {
                switch (status) {
                    case 1:
                        const token = jwt.sign({ email: email }, process.env.TOKEN_SECRET, { expiresIn: '7m', algorithm: "HS256" });
                        return res.header('auth-token', token).json({ error: null, data: { response, token } });
                    case 0:
                        return res.status(401).json({ error: true, message: 'Email, contraseña o token incorrecto!' });
                    case -1:
                        return res.status(500).json({ error: true, message: 'Algo ha salido mal al realizar el registro!' });
                }
            });
        };
        this.enable_biometric = (req, res) => {
            const { email, password } = req.body;
            let token = "";
            this.model.login(email, password, token, (status) => {
                switch (status) {
                    case 1:
                        const token = jwt.sign({ email: email }, process.env.TOKEN_SECRET, { expiresIn: '10y', algorithm: "HS256" });
                        this.model.biometric(email, token, (biometricStatus) => {
                            if (biometricStatus != -1) {
                                return res.json({ error: null, data: { email, token } });
                            }
                            else {
                                return res.status(500).json({ error: true, message: 'Algo ha salido mal al realizar la habilitación biométrica' });
                            }
                        });
                        break;
                    case 0:
                        return res.status(401).json({ error: true, message: 'Email o contraseña incorrecta!' });
                    case -1:
                        return res.status(500).json({ error: true, message: 'Algo ha salido mal al realizar el registro!' });
                }
            });
        };
        this.disable_biometric = (req, res) => {
            const { email } = req.body;
            const token = "";
            this.model.biometric(email, token, (biometricStatus) => {
                if (biometricStatus != -1) {
                    return res.status(200).json({ error: false, message: 'Deshabilitación biométrica exitósa!' });
                }
                else {
                    return res.status(500).json({ error: true, message: 'Algo ha salido mal al deshabilitar el acceso biométrico' });
                }
            });
        };
        this.verifyToken = (req, res, next) => {
            const { authorization } = req.headers;
            if (!authorization) {
                return res.status(401).json({ error: true, message: 'No se ha proporcionado un token de acceso. Acceso denegado!' });
            }
            const bearerToken = authorization.split(' ')[1];
            try {
                const decodedToken = jwt.verify(bearerToken, process.env.TOKEN_SECRET);
                req.body.user = decodedToken;
                next();
            }
            catch (error) {
                if (error instanceof jwt.TokenExpiredError) {
                    return res.status(200).json({ error: true, message: 'El token ha expirado!' });
                }
                return res.status(406).json({ error: true, message: 'EL token no es válido!' });
            }
        };
        this.model = new usersModel_1.default();
    }
}
exports.default = usersController;
