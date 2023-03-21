import { Document } from "mongoose";

export default interface IProduct extends Document {
    
    id: number;
    name: string;
    brand: string;
    rate: number;
    image: string;
}