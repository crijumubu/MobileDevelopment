import mongoose from "mongoose";
import userSchema from "./schema/userSchema";
import productSchema from "./schema/productSchema";

class mongo{

    private uri: string;
    public model: any;

    constructor(){

        this.uri = `${process.env.MONGODB}`;
        this.model = userSchema;
    }

    public connect = () => {

        mongoose.connect(this.uri)
        .then(() => {

            console.log("Connected to MongoDB Atlas");
        })
        .catch(error => {

            console.error('Error connecting to MongoDB Atlas: ', error);
            return process.exit(1);
        });
    }

    public set setModel(option: number){

        if (option == 0){

            this.model = userSchema;
        }else{

            this.model = productSchema;
        }
    }
}

export default mongo;