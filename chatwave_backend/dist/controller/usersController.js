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
            const { email, password, fcmToken } = req.body;
            this.model.login(email, password, fcmToken, (status) => {
                switch (status) {
                    case 1:
                        const token = jwt.sign({ email: email }, process.env.TOKEN_SECRET, { expiresIn: '7d', algorithm: "HS256" });
                        return res.status(200).header('auth-token', token).json({ error: false, message: 'Inicio de sesión exitóso!' });
                    case 0:
                        return res.status(401).json({ error: true, message: 'Email o contraseña incorrecta!' });
                    case -1:
                        return res.status(500).json({ error: true, message: 'Algo ha salido mal al realizar al iniciar sesión!' });
                }
            });
        };
        this.register = (req, res) => {
            const { name, email, password, phone, position, photo, fcmToken } = req.body;
            this.model.register(name, email, password, phone, position, photo, fcmToken, (status) => {
                switch (status) {
                    case 1:
                        return res.status(200).json({ error: false, message: 'Registro exitóso!' });
                    case 0:
                        return res.status(409).json({ error: true, message: 'El correo ya se encuentra en uso!' });
                    case -1:
                        return res.status(500).json({ error: true, message: 'Algo ha salido mal al realizar el registro!' });
                }
            });
        };
        this.sendMessage = (req, res) => {
            const from = req.body.user['email'];
            const { to, subject, message } = req.body;
            if (from != to) {
                this.model.sendMessage(from, to, subject, message, (status) => {
                    switch (status) {
                        case 1:
                            return res.status(200).json({ error: false, message: 'Mensaje enviado exitosamente!' });
                        case 0:
                            return res.status(500).json({ error: true, message: 'Algo ha salido mal al obtener los dispositivos del destinatario. Es probable que el usuario destinatario no exista!' });
                        case -1:
                            return res.status(500).json({ error: true, message: 'Algo ha salido mal al enviar el mensaje!' });
                    }
                });
            }
            else {
                return res.status(405).json({ error: true, message: 'El mensaje no ha podido ser enviado debido a que el remitente y el receptor corresponden al mismo usuario!' });
            }
        };
        this.getUsers = (req, res) => {
            const from = req.body.user['email'];
            this.model.getUsers(from, (row, error) => {
                if (error) {
                    return res.status(500).json({ error: true, message: 'Algo ha salido mal al realizar la consulta de usuarios!' });
                }
                if (Object.keys(row).length != 0) {
                    return res.status(200).json(row);
                }
                return res.status(200).json({ error: false, message: 'No hay usuarios en el sistema por el momento!' });
            });
        };
        this.getSentMessages = (req, res) => {
            const from = req.body.user['email'];
            const { to } = req.params;
            this.model.getSentMessages(from, to, (row, error) => {
                if (error) {
                    return res.status(500).json({ error: true, message: 'Algo ha salido mal al obtener los mensajes!' });
                }
                if (Object.keys(row).length != 0) {
                    return res.status(200).json(row);
                }
                return res.status(200).json({ error: false, message: 'No hay mensajes enviados a ese usuario!' });
            });
        };
        this.getReceivedMessages = (req, res) => {
            const { from } = req.params;
            const to = req.body.user['email'];
            this.model.getSentMessages(from, to, (row, error) => {
                if (error) {
                    return res.status(500).json({ error: true, message: 'Algo ha salido mal al obtener los mensajes!' });
                }
                if (Object.keys(row).length != 0) {
                    return res.status(200).json(row);
                }
                return res.status(200).json({ error: false, message: 'No hay mensajes enviados por ese usuario!' });
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
                    res.status(200).json({ error: true, message: 'El token ha expirado!' });
                }
                res.status(406).json({ error: true, message: 'EL token no es válido!' });
            }
        };
        this.model = new usersModel_1.default();
    }
}
exports.default = usersController;
