import mongo from "../database/mongo";

class usersModel{

    private mongo: mongo;

    constructor(){
        
        this.mongo = new mongo();
    }

    public login = async (email: String, password: String, fn: Function) => {
        

        this.mongo.connect();

        const validation = await this.mongo.model.count({'email': email, 'password': password});
        
        fn(validation);

    }

}

export default usersModel;