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

        this.model.login(email, password, (status: number, name?: string) => {

            switch (status){

                case 1:

                    const token = jwt.sign({ name: name, email: email}, process.env.TOKEN_SECRET, { expiresIn: '7d', algorithm: "HS256" });
                    res.header('auth-token', token).json({ error: null, data: {name, token} });
                    break;

                case 0:

                    return res.status(401).json({ error: true, message: 'Email o contraseña incorrecta!'});
                
                case -1:

                    return res.status(500).json({ error: true, message: 'Algo ha salido mal al realizar el registro!'});
            }
        });
    }

    public register = (req: Request, res: Response) => {

        const { name, email, password } = req.body;

        this.model.register(name, email, password, (error: any) => {
            
            if (!error){

                return res.status(200).json({ error: false, message: 'Registro exitóso!' });
            }
            else{

                const usedEmailError = error.keyPattern['email'];

                if (usedEmailError){

                    return res.status(409).json({ error: true, message: 'El correo ya se encuentra en uso!' });
                }
                
                return res.status(500).json({ error: true, message: 'Algo ha salido mal al realizar el registro!' });
            }
        });
    }

    public getProducts = (req: Request, res: Response) => {

        this.model.getProducts((error: any, row: JSON) => {
            
            if (error){

                return res.status(500).json({ error: true, message: 'Algo ha salido mal al realizar la inserción!' });
            }

            if (Object.keys(row).length != 0){

                return res.status(200).json(row);
            }

            return res.status(200).json({ error: false, message: 'No hay productos favoritos por el momento!' });
        });
    }

    public addFavorites = (req: Request, res: Response) => {

        const { products } = req.body;
        const email = req.body.user["email"];

        this.model.addFavorites(email, products, (status: number) => {

            switch (status){

                case 1:

                    return res.status(200).json({ error: false, message: 'Inserción exitosa!' });
                
                case 0:

                    return res.status(200).json({ error: true, message: 'El producto ingresado no es válido!' });

                case -1:

                    return res.status(500).json({ error: true, message: 'Algo ha salido mal al realizar la inserción!' });
            }
        });
    }

    public getFavorites = (req: Request, res: Response) => {

        const email = req.body.user["email"];

        this.model.getFavorites(email, (error: any, row: JSON) => {
            
            if (error){

                return res.status(500).json({ error: true, message: 'Algo ha salido mal al realizar la inserción!' });
            }

            if (Object.keys(row).length != 0){

                return res.status(200).json(row);
            }

            return res.status(200).json({ error: false, message: 'No hay productos favoritos por el momento!' });
        });
    }

    public getProductImage = (req: Request, res: Response) => {
        
        const { id } = req.params;

        this.model.getProductImage(parseInt(id), (row: string) => {

            if (row != ''){

                res.download(row);
            } else{

                return res.status(404).json({ error: true, message: 'No existen productos con ese id!' });
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
                
                res.status(200).json({ error: true, message: 'El token ha expirado!' });
            }
            
            res.status(406).json({ error: true, message: 'EL token no es válido!' });
        }
    }
}

export default usersController;