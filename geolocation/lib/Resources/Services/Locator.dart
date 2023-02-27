import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class Locator{

  Position? _position;

  Locator() {
    _defineLocation();
  }

  void _defineLocation() async {

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      return Future.error('Los servicios de ubicación están desactivados');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {

      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Se deniegan los permisos de ubicación');
      }
    }

    if (permission == LocationPermission.deniedForever) {

      return Future.error('Los permisos de ubicación se denegaron permanentemente, no podemos solicitar permisos');
    }

    _position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Position? get getLocation{
    return _position;
  }

  Future <void> showMap(String url) async{

    final Uri locationUri = Uri.parse(url);
    try{

      await launchUrl(locationUri, mode: LaunchMode.externalApplication);
    }catch (error){

      print(error);
      return Future.error('No fue posible abrir la url: $locationUri');
    }
  }
}