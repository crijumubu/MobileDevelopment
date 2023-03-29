import { Request, Response } from "express";
import usersModel from "../model/usersModel";

const jwt = require('jsonwebtoken');

class usersController{

    private model: usersModel;

    constructor(){

        this.model = new usersModel();
    }

    public login = (req: Request, res: Response) => {

        const { email, password, token } = req.body;
        
        this.model.login(email, password, token, (status: number, response: string) => {
                
            switch (status){
    
                case 1:

                    const token = jwt.sign({email: email}, process.env.TOKEN_SECRET, { expiresIn: '7m', algorithm: "HS256" });
                    return res.header('auth-token', token).json({ error: null, data: {response, token} });

                case 0:
                    
                    return res.status(401).json({ error: true, message: 'Email o contraseña incorrecta!'});
                
                case -1:

                    return res.status(500).json({ error: true, message: 'Algo ha salido mal al realizar el registro!'});
            }
        });
    }

    public biometric = (req: Request, res: Response) => {

        const { email, password} = req.body;
        let token : string = "";

        this.model.login(email, password, token, (status: number) => {
        
            switch (status){

                case 1:

                    const token = jwt.sign({email: email}, process.env.TOKEN_SECRET, { expiresIn: '10y', algorithm: "HS256" });

                    this.model.biometricToken(email, token, (biometricStatus: number) => {

                        if (biometricStatus != -1){

                            return res.json({ error: null, data: {email, token} });
                        
                        }
                        else{

                            return res.status(500).json({ error: true, message: 'Algo ha salido mal al realizar la habilitación biométrica' });
                        }
                    });
                    break;

                case 0:
                    
                    return res.status(401).json({ error: true, message: 'Email o contraseña incorrecta!'});
                
                case -1:

                    return res.status(500).json({ error: true, message: 'Algo ha salido mal al realizar el registro!'});
            }
        });
    }

    public verifyToken = (req: Request, res: Response, next: Function) => {

        const { authorization } = req.headers;

        if (!authorization){

            return res.status(401).json({ error: true, message: 'No se ha proporcionado un token de acceso. Acceso denegado!' });
        } 

        const bearerToken = authorization.split(' ')[1];

        try{

            const decodedToken = jwt.verify(bearerToken, process.env.TOKEN_SECRET);
            req.body.user = decodedToken;
            next();
        } 
        catch(error){

            if (error instanceof jwt.TokenExpiredError){
                
                return res.status(200).json({ error: true, message: 'El token ha expirado!' });
            }
            
            return res.status(406).json({ error: true, message: 'EL token no es válido!' });
        }
    }
}

export default usersController;