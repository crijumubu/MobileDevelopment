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
Object.defineProperty(exports, "__esModule", { value: true });
class firebase {
    constructor() {
        this.config = () => {
            this.firebaseAdmin.initializeApp({ credential: this.firebaseAdmin.credential.cert(this.firebaseServiceAccount) });
            this.notificationOptions = { priority: "high", timeToLive: 60 * 60 * 24 };
        };
        this.sendNotification = (registrationToken, subject, message, from, fn) => __awaiter(this, void 0, void 0, function* () {
            var payload = { 'notification': { 'title': subject, 'body': message }, 'data': { 'personSent': from } };
            yield this.firebaseAdmin.messaging().sendToDevice(registrationToken, payload, this.notificationOptions)
                .then((response) => {
                fn(response['results'][0]['messageId']);
            });
        });
        this.firebaseAdmin = require("firebase-admin");
        this.firebaseServiceAccount = require("./chatwake-key.json");
        this.config();
    }
}
exports.default = firebase;
