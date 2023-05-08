import { Schema, model } from "mongoose";
import IUsers from "../interface/IUser";

const usersSchema = new Schema({
    name: {
        type: String,
        requied: true
    },
    email: {
        type: String,
        required: true,
        unique: true
    },
    password: {
        type: String,
        requied: true
    },
    phone: {
        type: String,
        requied: true
    },
    position: {
        type: String,
        requied: true
    },
    photo: {
        type: String,
        requied: true
    }
}, 
{
    versionKey: false
});

export default model<IUsers>('users', usersSchema);