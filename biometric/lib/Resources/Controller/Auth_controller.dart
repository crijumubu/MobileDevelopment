import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';

class AuthController {

  static bool _fingerAuthorization = false;
  static final LocalAuthentication _auth = LocalAuthentication();

  static bool get fingerAuthorization => _fingerAuthorization;

  static set fingerAuthorization(bool value) {
    _fingerAuthorization = value;
  }
  
  static Future loginUser(String email, String password) async{

    const url = 'http://mienvio2.bucaramanga.upb.edu.co:1803/api/users/login';

    var response = await http.post(Uri.parse(url), body: {
      "email": email,
      "password": password
    });

    if (response.statusCode == 200) return true;

    return false;
  }

  static Future<bool> _canAuthenticate() async{

    if (await _auth.canCheckBiometrics || await _auth.isDeviceSupported()) return true;

    return false;
  }

  static Future<bool> authenticate() async{

    try{

      if (!await _canAuthenticate()) return false;

      return await _auth.authenticate(localizedReason: 'Scan for authenticate');
    }catch (e) {

      return false;
    }
  }
}