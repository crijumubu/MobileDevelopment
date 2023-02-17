import { Request, Response } from "express";
import usersModel from "../model/usersModel";

class usersController{

    private model: usersModel;

    constructor(){

        this.model = new usersModel();
    }

    public login = (req: Request, res: Response) => {

        const { email, password } = req.body;

        this.model.login(email, password, (error: any, status: number, row: any) => {
            
            if (error) {

                return res.json({ error: true, message: 'Upss, algo ha salido mal!'});
            }
            if (status == 1){

                return res.json({ message: 'Inicio de sesion exitoso!', row});
            }
            else if (status == 0){

                return res.json({ message: 'Contraseña incorrecta!'});
            }
            else{
                
                return res.status(404).json({ error: false, message: 'Upss, no pudimos encontrar tu cuenta!'});
            }
        });
    }
}

export default usersController;