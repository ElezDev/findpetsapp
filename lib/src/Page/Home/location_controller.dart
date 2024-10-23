import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
class LocationController extends GetxController {
  var currentPosition = Rxn<Position>(); // Variable observable para la posición actual

  @override
  void onInit() {
    super.onInit();
    obtenerUbicacionActual();
  }

  Future<void> obtenerUbicacionActual() async {
    try {
      // Pedir permiso de ubicación
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      // Obtener la ubicación actual
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        
      );
      currentPosition.value = position; 
      print('Posición actual: ${position.latitude}, ${position.longitude}');
    } catch (e) {
      print('Error al obtener la ubicación: $e');
    }
  }
}
