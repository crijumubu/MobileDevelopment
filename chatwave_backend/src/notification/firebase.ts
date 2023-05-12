class firebase{

  private firebaseAdmin: any;
  private firebaseServiceAccount: any;
  private notificationOptions: any;

  constructor(){
      
      this.firebaseAdmin = require("firebase-admin");
      this.firebaseServiceAccount = require("./chatwake-key.json");
      this.config();
  }

  private config = () => {

    this.firebaseAdmin.initializeApp({credential: this.firebaseAdmin.credential.cert(this.firebaseServiceAccount)});

    this.notificationOptions = { priority: "high", timeToLive: 60 * 60 * 24};
  }

  public sendNotification = async (registrationToken: string, subject: string, message: string, from: string, fn: Function)=> {

    var payload = { 'notification': {'title': subject, 'body': message}, 'data': { 'personSent': from }};

    await this.firebaseAdmin.messaging().sendToDevice(registrationToken, payload, this.notificationOptions)
    .then((response: any) => {

      fn(response['results'][0]['messageId']);
    });
  }
}

export default firebase;