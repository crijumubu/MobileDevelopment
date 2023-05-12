import mongoose from "mongoose";
import userSchema from "./schema/userSchema";
import messageSchema from "./schema/messageSchema";

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

    public setModel = (modelValue: number) => {

        switch(modelValue){

            case 0:
                this.model = userSchema;
                break;
                
            case 1:
                this.model = messageSchema;
                break;
        }
    }
}

export default mongo;