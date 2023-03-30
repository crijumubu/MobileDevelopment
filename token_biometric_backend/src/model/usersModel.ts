import { query } from 'express';
import mongo from '../database/mongo';
import bcrypt from 'bcryptjs';

class usersModel{

    private mongo: mongo;

    constructor(){
        
        this.mongo = new mongo();
    }

    public login = async (email: string, password: string, token: string, fn: Function) => {

        let status: number = 0, queryResponse: string = "";
        this.mongo.connect();

        if (token != ""){

            await this.mongo.model.find({'token': token}, {'email': 1, '_id': 0})
            .then((response: any) => {
                
                if(response.length == 1){

                    status = 1;
                    queryResponse = response[0]['email'];
                }
                else{

                    status = 0;
                }
            })
            .catch((error: any) => {

                status = -1;
            });
        }
        else{

            queryResponse = email;
            
            await this.mongo.model.find({'email': email}, {'password': 1, '_id': 0})
            .then((response: any) => {
                
                if(response.length == 1 && bcrypt.compareSync(password, response[0]['password'])){
                    
                    status = 1;
                }
                else{

                    status = 0;
                }
            })
            .catch((error: any) => {

                status = -1
            });
        }

        fn(status, queryResponse);
    }

    public biometric = async (email: string, token: string, fn: Function) => {
        
        let status: number = 0;
        this.mongo.connect();

        await this.mongo.model.updateOne({'email': email}, {$set: {'token': token}})
        .then((response: any, error: any) => {
            
            if (!error){

                status = 1;
            }
            else{

                status = -1;
            }
        });

        fn(status);
    }

    public cryptPassword = (password: string) => {

        const salt = bcrypt.genSaltSync(10);
        const hashedPassword = bcrypt.hashSync(password, salt);

        return hashedPassword;
    }
}

export default usersModel;