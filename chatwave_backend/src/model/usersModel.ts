import mongo from '../database/mongo';
import bcrypt from 'bcryptjs';

class usersModel{

    private mongo: mongo;

    constructor(){
        
        this.mongo = new mongo();
    }

    public login = async (email: string, password: string, fn: Function) => {
        

        this.mongo.connect();
        
        await this.mongo.model.find({'email': email}, {'password': 1, '_id': 0})
        .then((response: any) => {
            
            if(response.length == 1){
                
                if (bcrypt.compareSync(password, response[0]['password'])){
                    
                    fn(1);
                    return;
                }
            }

            fn(0);
        })
        .catch(() => {
            
            fn(-1);
        });
    }

    public register = async (name: string, email: string, password: string, phone: string, position: string, photo: string, fn: Function) => {
        

        this.mongo.connect();

        await this.mongo.model.create({'name': name, 'email': email, 'password': this.cryptPassword(password), 'phone': phone, 'position': position, 'photo': photo})
        .then(() => {

            fn(1);
        })
        .catch((error: any) => {

            const usedEmailError = error.keyPattern['email'];
            usedEmailError ? fn(0) : fn(-1);
        });
    }

    public cryptPassword = (password: string) => {

        const salt = bcrypt.genSaltSync(10);
        const hashedPassword = bcrypt.hashSync(password, salt);

        return hashedPassword;
    }
}

export default usersModel;