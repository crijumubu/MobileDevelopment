import mongo from "../database/mongo";
import bcrypt from "bcryptjs";

class usersModel{

    private mongo: mongo;

    constructor(){
        
        this.mongo = new mongo();
    }

    public login = async (email: string, password: string, fn: Function) => {
        

        this.mongo.connect();
        this.mongo.setModel = 0;

        await this.mongo.model.find({'email': email}, {"name":1, "password": 1, "_id":0})
        .then((response: any) => {
            
            if(response.length == 1){

                if (bcrypt.compareSync(password, response[0]['password'])){

                    fn(1, response[0]['name']);
                }
            }else{
                
                fn(0);
            }
        })
        .catch((error: any) => {

            fn(-1);
        });
    }

    public register = async (name: string, email: string, password: string, fn: Function) => {
        

        this.mongo.connect();
        this.mongo.setModel = 0;


        await this.mongo.model.create({'name': name, 'email': email, 'password': this.cryptPassword(password), 'favorite': []}, (error: any) => {

            fn(error);
        });
    }

    public getProducts = async(fn: Function) => {

        this.mongo.connect();
        
        this.mongo.setModel = 1;
        const products = await this.mongo.model.find({}, {"_id":0});
        fn(products);
    }

    public cryptPassword = (password: string) => {

        const salt = bcrypt.genSaltSync(10);
        const hashedPassword = bcrypt.hashSync(password, salt);

        return hashedPassword;
    }
}

export default usersModel;