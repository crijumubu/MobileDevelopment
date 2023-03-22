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
                
                return res.status(200).json({ message: 'Bienvenido al sistema!'});
            }
            else if (validation == 0){

                return res.status(404).json({ message: 'Email o contraseña incorrecta!'});
            }
            else{
                
                return res.status(404).json({ error: false, message: 'Upss, algo ha salido mal!'});
            }
        });
    }
}

export default usersController;