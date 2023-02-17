import mongo from "../database/mongo";

class usersModel{

    private mongo: mongo;

    constructor(){
        
        this.mongo = new mongo();
    }

    public login = async (email: String, password: String, fn: Function) => {
        
    }
}

export default usersModel;