import { Document } from "mongoose";

export default interface IUser extends Document{

    from: string;
    to: string;
    subject: string;
    message: string;
    devices: string[];
    deviceStatus: string[];
}