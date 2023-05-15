import { Document } from "mongoose";

export default interface IMessage extends Document{

    from: string;
    to: string;
    subject: string;
    message: string;
    devices: string[];
    deviceStatus: string[];
}