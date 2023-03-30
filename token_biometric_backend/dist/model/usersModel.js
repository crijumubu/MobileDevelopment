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
const mongo_1 = __importDefault(require("../database/mongo"));
const bcryptjs_1 = __importDefault(require("bcryptjs"));
class usersModel {
    constructor() {
        this.login = (email, password, token, fn) => __awaiter(this, void 0, void 0, function* () {
            let status = 0, queryResponse = "";
            this.mongo.connect();
            if (token != "") {
                yield this.mongo.model.find({ 'token': token }, { 'email': 1, '_id': 0 })
                    .then((response) => {
                    if (response.length == 1) {
                        status = 1;
                        queryResponse = response[0]['email'];
                    }
                    else {
                        status = 0;
                    }
                })
                    .catch((error) => {
                    status = -1;
                });
            }
            else {
                queryResponse = email;
                yield this.mongo.model.find({ 'email': email }, { 'password': 1, '_id': 0 })
                    .then((response) => {
                    if (response.length == 1 && bcryptjs_1.default.compareSync(password, response[0]['password'])) {
                        status = 1;
                    }
                    else {
                        status = 0;
                    }
                })
                    .catch((error) => {
                    status = -1;
                });
            }
            fn(status, queryResponse);
        });
        this.biometric = (email, token, fn) => __awaiter(this, void 0, void 0, function* () {
            let status = 0;
            this.mongo.connect();
            yield this.mongo.model.updateOne({ 'email': email }, { $set: { 'token': token } })
                .then((response, error) => {
                if (!error) {
                    status = 1;
                }
                else {
                    status = -1;
                }
            });
            fn(status);
        });
        this.cryptPassword = (password) => {
            const salt = bcryptjs_1.default.genSaltSync(10);
            const hashedPassword = bcryptjs_1.default.hashSync(password, salt);
            return hashedPassword;
        };
        this.mongo = new mongo_1.default();
    }
}
exports.default = usersModel;
