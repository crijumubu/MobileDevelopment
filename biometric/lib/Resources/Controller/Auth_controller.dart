import 'package:http/http.dart' as http;

class AuthController {

  static Future loginUser(String email, String password) async{

    const url = 'http://10.153.56.230:1802/api/users/login';

    var response = await http.post(Uri.parse(url), body: {
      "email": email,
      "password": password
    });

    if (response.statusCode == 200){

      return true;
    }

    return false;
  }
}