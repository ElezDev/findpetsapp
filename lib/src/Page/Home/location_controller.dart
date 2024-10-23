import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends GetxController {
  var currentPosition = Rx<Position?>(null); 

  @override
  void onInit() {
    super.onInit();
    determinePosition();
  }

  Future<void> determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    currentPosition.value = position;
    print('Posición actual: ${position.latitude}, ${position.longitude}');
  }
}
