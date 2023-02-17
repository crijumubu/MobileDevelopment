import { Request, Response } from "express";
import usersModel from "../model/usersModel";

class usersController{

    private model: usersModel;

    constructor(){

        this.model = new usersModel();
    }

    public login = (req: Request, res: Response) => {

        const { email, password } = req.body;

        this.model.login(email, password, (validation: number) => {
            
            if (validation == 1){

                return res.json({ message: 'Inicio de sesion exitoso!'});
            }
            else if (validation == 0){

                return res.json({ message: 'Email o contraseña incorrecta!'});
            }
            else{
                
                return res.status(404).json({ error: false, message: 'Upss, algo ha salido mal!'});
            }
        });
    }
}

export default usersController;