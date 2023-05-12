import { Schema, model } from "mongoose";
import IMessage from "../interface/IMessage";

const messageSchema = new Schema({
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
}, 
{
    versionKey: false
});

export default model<IMessage>('messages', messageSchema);