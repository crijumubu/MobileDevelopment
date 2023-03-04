import mongo from "../database/mongo";

class usersModel{

    private mongo: mongo;

    constructor(){
        
        this.mongo = new mongo();
    }

    public login = async (email: String, password: String, fn: Function) => {
        

        this.mongo.connect();
        this.mongo.setModel = 0;

        const validation = await this.mongo.model.find({'email': email, 'password': password}, {"name": 1, "_id":0});
        fn(validation);
    }

    public getProducts = async(fn: Function) => {

        this.mongo.connect();
        
        this.mongo.setModel = 1;
        const products = await this.mongo.model.find({}, {"_id":0});
        fn(products);
    }

}

export default usersModel;