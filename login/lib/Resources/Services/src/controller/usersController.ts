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
                
                const token = jwt.sign({

                    email: email,
                    password: password
                }, process.env.TOKEN_SECRET)

                res.header('auth-token', token).json({
                    error: null,
                    data: {token}
                })
            }
            else if (validation == 0){

                return res.json({ message: 'Email o contraseña incorrecta!'});
            }
            else{
                
                return res.status(404).json({ error: false, message: 'Upss, algo ha salido mal!'});
            }
        });
    }

    public verifyToken = (req: Request, res: Response) => {

        const { token } = req.body;

        if (!token) return res.status(401).json({ error: 'Acceso denegado' })
        try {
            const verified = jwt.verify(token, process.env.TOKEN_SECRET)
            
            if (verified){
                res.json({ message: 'Inicio de sesion exitoso!'});
            }
        } catch (error) {
            res.status(400).json({error: 'token no es válido'})
        }
    }
}

export default usersController;