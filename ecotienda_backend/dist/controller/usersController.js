"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
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
            this.model.login(email, password, (status) => {
                switch (status) {
                    case 1:
                        console.log('Entre 1');
                        const token = jwt.sign({ email: email }, process.env.TOKEN_SECRET, { expiresIn: '7d', algorithm: "HS256" });
                        res.header('auth-token', token).json({ error: null, data: { email, token } });
                        break;
                    case 0:
                        console.log('Entre 0');
                        return res.status(401).json({ error: true, message: 'Email o contraseña incorrecta!' });
                    case -1:
                        console.log('Entre -1');
                        return res.status(500).json({ error: true, message: 'Algo ha salido mal al realizar el registro!' });
                }
            });
        };
        this.register = (req, res) => {
            const { email, password } = req.body;
            this.model.register(email, password, (error) => {
                if (!error) {
                    return res.status(200).json({ error: false, message: 'Registro exitóso!' });
                }
                else {
                    const usedEmailError = error.keyPattern['email'];
                    if (usedEmailError) {
                        return res.status(409).json({ error: true, message: 'El correo ya se encuentra en uso!' });
                    }
                    return res.status(500).json({ error: true, message: 'Algo ha salido mal al realizar el registro!' });
                }
            });
        };
        this.getProducts = (req, res) => {
            this.model.getProducts((error, row) => {
                if (error) {
                    return res.status(500).json({ error: true, message: 'Algo ha salido mal al realizar la inserción!' });
                }
                if (Object.keys(row).length != 0) {
                    return res.status(200).json(row);
                }
                return res.status(200).json({ error: false, message: 'No hay productos favoritos por el momento!' });
            });
        };
        this.addFavorites = (req, res) => {
            const { products } = req.body;
            const email = req.body.user["email"];
            this.model.addFavorites(email, products, (status) => {
                switch (status) {
                    case 1:
                        return res.status(200).json({ error: false, message: 'Inserción exitosa!' });
                    case 0:
                        return res.status(200).json({ error: true, message: 'El producto ingresado no es válido!' });
                    case -1:
                        return res.status(500).json({ error: true, message: 'Algo ha salido mal al realizar la inserción!' });
                }
            });
        };
        this.getFavorites = (req, res) => {
            const email = req.body.user["email"];
            this.model.getFavorites(email, (error, row) => __awaiter(this, void 0, void 0, function* () {
                if (error) {
                    return res.status(500).json({ error: true, message: 'Algo ha salido mal al realizar la consulta de favoritos para este usuario!' });
                }
                if (Object.keys(row).length != 0) {
                    const ids = JSON.parse(JSON.stringify(row))[0]['favorites'];
                    const favorites = [];
                    for (let i = 0; i < ids.length; i++) {
                        yield this.model.getProduct(parseInt(ids[i]), (productError, product) => {
                            if (!productError) {
                                favorites.push(product);
                            }
                            else {
                                return res.status(500).json({ error: true, message: 'Algo ha salido mal al realizar la consulta de favoritos para este usuario!' });
                            }
                        });
                    }
                    return res.status(200).json(favorites);
                }
                return res.status(200).json({ error: false, message: 'No hay productos favoritos por el momento!' });
            }));
        };
        this.getProductImage = (req, res) => {
            const { id } = req.params;
            this.model.getProductImage(parseInt(id), (row) => {
                if (row != '') {
                    res.download(row);
                }
                else {
                    return res.status(404).json({ error: true, message: 'No existen productos con ese id!' });
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
                    res.status(200).json({ error: true, message: 'El token ha expirado!' });
                }
                res.status(406).json({ error: true, message: 'EL token no es válido!' });
            }
        };
        this.model = new usersModel_1.default();
    }
}
exports.default = usersController;
