import 'package:findpetapp/src/Page/Home/location_controller.dart';
import 'package:findpetapp/src/Services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;

class MapPetPage extends StatefulWidget {
  @override
  _MapPetPageState createState() => _MapPetPageState();
}

class _MapPetPageState extends State<MapPetPage> {
  final LocationController locationController = Get.put(LocationController());
  final AuthService authService = Get.find<AuthService>();

  String? _mapStyle;

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/lottie/map_style.json').then((style) {
      setState(() {
        _mapStyle = style;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (locationController.currentPosition.value == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          final position = locationController.currentPosition.value!;
          final LatLng currentLatLng =
              LatLng(position.latitude, position.longitude);
          final userName = authService.userData['name'] ?? 'Usuario';
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: currentLatLng,
              zoom: 16,
            ),
            markers: {
              Marker(
                markerId: MarkerId('currentLocation'),
                position: currentLatLng,
                infoWindow: InfoWindow(title: 'Estás aquí, $userName'),
              ),
            },
            onMapCreated: (GoogleMapController controller) {
              if (_mapStyle != null) {
                controller.setMapStyle(_mapStyle);
              }
            },
          );
        }
      }),
    );
  }
}
