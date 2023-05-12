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
const firebase_1 = __importDefault(require("../notification/firebase"));
class usersModel {
    constructor() {
        this.login = (email, password, fcmToken, fn) => __awaiter(this, void 0, void 0, function* () {
            this.mongo.connect();
            this.mongo.setModel(0);
            yield this.mongo.model.find({ 'email': email }, { 'password': 1, 'fcmTokens': 1, '_id': 0 })
                .then((response) => __awaiter(this, void 0, void 0, function* () {
                if (response.length == 1) {
                    if (bcryptjs_1.default.compareSync(password, response[0]['password'])) {
                        if (!response[0]['fcmTokens'].includes(fcmToken)) {
                            yield this.mongo.model.updateOne({ 'email': email }, { $push: { 'fcmTokens': fcmToken } })
                                .catch(() => {
                                fn(-1);
                                return;
                            });
                        }
                        fn(1);
                        return;
                    }
                }
                fn(0);
            }))
                .catch(() => {
                fn(-1);
            });
        });
        this.register = (name, email, password, phone, position, photo, fcmToken, fn) => __awaiter(this, void 0, void 0, function* () {
            this.mongo.connect();
            this.mongo.setModel(0);
            yield this.mongo.model.create({ 'name': name, 'email': email, 'password': this.cryptPassword(password), 'phone': phone, 'position': position, 'photo': photo, 'fcmTokens': fcmToken })
                .then(() => {
                fn(1);
            })
                .catch((error) => {
                const usedEmailError = error.keyPattern['email'];
                usedEmailError ? fn(0) : fn(-1);
            });
        });
        this.sendMessage = (from, to, subject, message, fn) => __awaiter(this, void 0, void 0, function* () {
            this.mongo.connect();
            this.mongo.setModel(0);
            // Get notification tokens
            var sendNotificationsTo = [];
            yield this.mongo.model.find({ 'email': to }, { 'fcmTokens': 1, '_id': 0 })
                .then((response) => {
                response[0]['fcmTokens'].forEach((token) => {
                    sendNotificationsTo.push(token);
                });
            })
                .catch(() => {
                fn(0);
                return;
            });
            // Create message and send notifications
            this.mongo.setModel(1);
            yield this.mongo.model.create({ 'from': from, 'to': to, 'subject': subject, 'message': message, 'device': sendNotificationsTo })
                .then((response) => {
                var idMessage = response['_id'];
                sendNotificationsTo.forEach((device) => __awaiter(this, void 0, void 0, function* () {
                    yield this.firebase.sendNotification(device, subject, message, from, (response) => __awaiter(this, void 0, void 0, function* () {
                        yield this.mongo.model.updateOne({ '_id': idMessage }, { $push: { 'deviceStatus': response } })
                            .catch(() => {
                            fn(-1);
                            return;
                        });
                    }))
                        .catch(() => {
                        fn(-1);
                        return;
                    });
                    fn(1);
                }));
            })
                .catch(() => {
                fn(-1);
                return;
            });
            ;
        });
        this.getUsers = (from, fn) => __awaiter(this, void 0, void 0, function* () {
            this.mongo.connect();
            this.mongo.setModel(0);
            yield this.mongo.model.find({ 'email': { $ne: from } }, { 'name': 1, 'email': 1, 'phone': 1, 'position': 1, 'photo': 1, '_id': 0 })
                .then((response, error) => {
                fn(response, error);
            });
        });
        this.getSentMessages = (from, to, fn) => __awaiter(this, void 0, void 0, function* () {
            this.mongo.connect();
            this.mongo.setModel(1);
            yield this.mongo.model.find({ 'from': from, 'to': to }, { 'from': 1, 'to': 1, 'subject': 1, 'message': 1, '_id': 0 })
                .then((response, error) => {
                fn(response, error);
            });
        });
        this.cryptPassword = (password) => {
            const salt = bcryptjs_1.default.genSaltSync(10);
            const hashedPassword = bcryptjs_1.default.hashSync(password, salt);
            return hashedPassword;
        };
        this.mongo = new mongo_1.default();
        this.firebase = new firebase_1.default();
    }
}
exports.default = usersModel;
