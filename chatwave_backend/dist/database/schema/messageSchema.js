"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const mongoose_1 = require("mongoose");
const messageSchema = new mongoose_1.Schema({
    from: {
        type: String,
        requied: true
    },
    to: {
        type: String,
        required: true,
    },
    subject: {
        type: String,
        requied: true
    },
    message: {
        type: String,
        requied: true
    },
    device: {
        type: Array,
        requied: true
    },
    deviceStatus: {
        type: Array,
        requied: true
    }
}, {
    versionKey: false
});
exports.default = (0, mongoose_1.model)('messages', messageSchema);
