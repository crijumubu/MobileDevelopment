import mongo from '../database/mongo';
import bcrypt from 'bcryptjs';
import firebase from '../notification/firebase';

class usersModel{

    private mongo: mongo;
    private firebase: firebase;

    constructor(){
        
        this.mongo = new mongo();
        this.firebase = new firebase();
    }

    public login = async (email: string, password: string, fcmToken: string, fn: Function) => {
        

        this.mongo.connect();
        this.mongo.setModel(0);
        
        await this.mongo.model.find({'email': email}, {'password': 1, 'fcmTokens': 1, '_id': 0})
        .then(async (response: any) => {
            
            if(response.length == 1){
                
                if (bcrypt.compareSync(password, response[0]['password'])){                 
                    
                    if (!response[0]['fcmTokens'].includes(fcmToken)){

                        await this.mongo.model.updateOne({'email': email}, {$push: { 'fcmTokens': fcmToken}})
                        .catch(() => {

                            fn(-1);
                            return;
                        });
                    }

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

    public register = async (name: string, email: string, password: string, phone: string, position: string, photo: string, fcmToken: string, fn: Function) => {
        

        this.mongo.connect();
        this.mongo.setModel(0);
        
        await this.mongo.model.create({'name': name, 'email': email, 'password': this.cryptPassword(password), 'phone': phone, 'position': position, 'photo': photo, 'fcmTokens': fcmToken})
        .then(() => {

            fn(1);
        })
        .catch((error: any) => {

            const usedEmailError = error.keyPattern['email'];
            usedEmailError ? fn(0) : fn(-1);
        });
    }

    public sendMessage = async (from: string, to: string, subject: string, message: string, fn: Function) => {

        this.mongo.connect();
        this.mongo.setModel(0);

        // Get notification tokens

        var sendNotificationsTo : string[] = [];

        await this.mongo.model.find({'email': to}, {'fcmTokens': 1,'_id': 0})
        .then((response: any) => {
            
            response[0]['fcmTokens'].forEach((token: string) => {

                sendNotificationsTo.push(token);
            });
        })
        .catch(() => { 

            fn(0);
            return;
        });
        
        // Create message and send notifications

        this.mongo.setModel(1);

        await this.mongo.model.create({'from': from, 'to': to, 'subject': subject, 'message': message, 'device': sendNotificationsTo})
        .then((response: any) => {
            
            var idMessage = response['_id'];

            sendNotificationsTo.forEach(async (device: string) => {

                await this.firebase.sendNotification(device, subject, message, from, async (response: string) => {
                    
                    await this.mongo.model.updateOne({'_id': idMessage}, {$push: { 'deviceStatus': response}})
                    .catch(() => { 

                        fn(-1);
                        return;
                    });
                })
                .catch(() => { 

                    fn(-1);
                    return;
                });
            });
        })
        .catch(() => { 

            fn(-1);
            return;
        });

        fn(1);
        return;
    }

    public getUsers = async (from: string, fn: Function) => {
        

        this.mongo.connect();
        this.mongo.setModel(0);
        
        await this.mongo.model.find({'email': {$ne : from}}, {'name': 1,'email': 1, 'phone': 1, 'position': 1, 'photo': 1, '_id': 0})
        .then((response: any, error: any) => {
            
            fn(response, error);
        });
    }

    public getSentMessages = async (from: string, to: string, fn: Function) => {
        

        this.mongo.connect();
        this.mongo.setModel(1);
        
        await this.mongo.model.find({'from': from, 'to': to}, {'from': 1,'to': 1, 'subject': 1, 'message': 1, '_id': 0})
        .then((response: any, error: any) => {
            
            fn(response, error);
        });
    }

    private cryptPassword = (password: string) => {

        const salt = bcrypt.genSaltSync(10);
        const hashedPassword = bcrypt.hashSync(password, salt);

        return hashedPassword;
    }
}

export default usersModel;