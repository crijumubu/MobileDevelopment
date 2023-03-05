import mongo from '../database/mongo';
import bcrypt from 'bcryptjs';

class usersModel{

    private mongo: mongo;

    constructor(){
        
        this.mongo = new mongo();
    }

    public login = async (email: string, password: string, fn: Function) => {
        

        this.mongo.connect();
        this.mongo.setModel = 0;

        await this.mongo.model.find({'email': email}, {'password': 1, '_id': 0})
        .then((response: any) => {
            
            if(response.length == 1){

                if (bcrypt.compareSync(password, response[0]['password'])){

                    fn(1);
                }
            }else{
                
                fn(0);
            }
        })
        .catch((error: any) => {

            fn(-1);
        });
    }

    public register = async (email: string, password: string, fn: Function) => {
        

        this.mongo.connect();
        this.mongo.setModel = 0;

        await this.mongo.model.create({'email': email, 'password': this.cryptPassword(password), 'favorites': []}, (error: any) => {

            fn(error);
        });
    }

    public getProduct = async(product: number, fn: Function) => {

        this.mongo.connect();
        this.mongo.setModel = 1;

        return await this.mongo.model.find({'id': product}, {'_id': 0}) 
        .then((response: any, error: any) => {
            
            fn(error, response);
        });  
    }

    public getProducts = async(fn: Function) => {

        this.mongo.connect();
        this.mongo.setModel = 1;

        await this.mongo.model.find({}, {'_id':0})
        .then((response: any, error: any) => {
            
            fn(error, response);
        });
    }

    public getFavorites = async(email: string, fn: Function) => {

        this.mongo.connect();
        this.mongo.setModel = 0;

        await this.mongo.model.find({'email': email, favorites: { $ne: [] }}, {'favorites': 1,'_id':0})
        .then((response: any, error: any) => {
            
            fn(error, response);
        });
    }

    public addFavorites = async (email: string, products: number[], fn: Function) => {
        

        this.mongo.connect();
        this.mongo.setModel = 0;
        
        if (!Array.isArray(products)){

            fn(0);
            return;
        }

        await this.mongo.model.updateOne({'email': email}, {$set: {'favorites': products}})
        .then((response: any, error: any) => {
            
            if (!error){

                fn(1);
            }else{

                fn(-1);
            }
        })
    }

    public getProductImage = async (id: number, fn: Function) => {

        this.mongo.connect();
        this.mongo.setModel = 1;
        
        const product = await this.mongo.model.findOne({'id': id});
        let imagePath = '';

        if (product != null){

            imagePath = `./src/resources/${id}.jpg`;
        }

        fn(imagePath);
    }

    public cryptPassword = (password: string) => {

        const salt = bcrypt.genSaltSync(10);
        const hashedPassword = bcrypt.hashSync(password, salt);

        return hashedPassword;
    }
}

export default usersModel;