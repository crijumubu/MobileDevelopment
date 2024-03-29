"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const mongoose_1 = __importDefault(require("mongoose"));
const userSchema_1 = __importDefault(require("./schema/userSchema"));
const productSchema_1 = __importDefault(require("./schema/productSchema"));
class mongo {
    constructor() {
        this.connect = () => {
            mongoose_1.default.connect(this.uri)
                .then(() => {
                console.log("Connected to MongoDB Atlas");
            })
                .catch(error => {
                console.error('Error connecting to MongoDB Atlas: ', error);
                return process.exit(1);
            });
        };
        this.uri = `${process.env.MONGODB}`;
        this.model = userSchema_1.default;
    }
    set setModel(option) {
        if (option == 0) {
            this.model = userSchema_1.default;
        }
        else {
            this.model = productSchema_1.default;
        }
    }
}
exports.default = mongo;
