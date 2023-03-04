import { Schema, model } from "mongoose";
import IUsers from "../interface/IUser";

const usersSchema = new Schema({
    email: {
        type: String,
        required: true
    },
    password: {
        type: String,
        requied: true
    }
});

export default model<IUsers>('users', usersSchema);