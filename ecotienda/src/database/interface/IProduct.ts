import { Document } from "mongoose";

export default interface IProduct extends Document {
    
    id: number;
    name: string;
    description: string;
    brand: string;
    price: number;
    image: string;
}