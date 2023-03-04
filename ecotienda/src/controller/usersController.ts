import { Request, Response } from "express";
import usersModel from "../model/usersModel";

const jwt = require('jsonwebtoken');

class usersController{

    private model: usersModel;

    constructor(){

        this.model = new usersModel();
    }

    public login = (req: Request, res: Response) => {

        const { email, password } = req.body;

        this.model.login(email, password, (validation: number) => {
            
            if (validation == 1){
                
                const token = jwt.sign({ email: email, password: password}, process.env.TOKEN_SECRET, { expiresIn: '1m', algorithm: "HS256" });

                res.header('auth-token', token).json({ error: null, data: {token} })
            }
            else if (validation == 0){

                return res.status(404).json({ message: 'Email o contraseña incorrecta!'});
            }
            else{
                
                return res.status(404).json({ error: false, message: 'Upss, algo ha salido mal!'});
            }
        });
    }

    public verifyToken = (req: Request, res: Response, next: Function) => {

        const { authorization } = req.headers;

        if (!authorization){

            return res.status(401).json({ error: 'No se ha proporcionado un token de acceso. Acceso denegado!' });
        } 

        const bearerToken = authorization.split(' ')[1];

        try{

            const decodedToken = jwt.verify(bearerToken, process.env.TOKEN_SECRET);
            req.body.user = decodedToken;
        } 
        catch(error){

            if (error instanceof jwt.TokenExpiredError){
                
                res.status(200).json({ message: 'El token ha expirado!'});
            }
            else{

                res.status(406).json({error: 'EL token no es válido!'});
            }
        }
        next();
    }
}

export default usersController;
