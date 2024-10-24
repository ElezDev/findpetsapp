import 'package:findpetapp/src/Models/pets.dart';
import 'package:findpetapp/src/Page/Home/location_controller.dart';
import 'package:findpetapp/src/Services/auth_service.dart';
import 'package:findpetapp/src/Services/pets_service.dart';
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
  final PetService petService = PetService();

  String? _mapStyle;
  List<Pets> pets = []; // Lista para almacenar las mascotas
  BitmapDescriptor?
      myLocationIcon; // Icono personalizado para la ubicación actual

  @override
  void initState() {
    super.initState();
    loadMapStyle();
    fetchPets();
    _setCustomMarker(); // Establece el ícono personalizado al iniciar
  }

  void loadMapStyle() {
    rootBundle.loadString('assets/lottie/map_style.json').then((style) {
      setState(() {
        _mapStyle = style;
      });
    });
  }

  Future<void> fetchPets() async {
    try {
      List<Pets> fetchedPets = await petService.fetchPets();
      setState(() {
        pets = fetchedPets;
      });
    } catch (e) {
      print(e);
    }
  }

  void _setCustomMarker() async {
    myLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(50, 24)), // Tamaño del ícono
      'assets/images/marcador1.png', // Ruta del ícono
    );
  }

  void _showPetDetails(Pets pet) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(pet.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              pet.imageUrl != null
                  ? Image.network(pet.imageUrl!, fit: BoxFit.cover)
                  : Container(
                      height: 150,
                      color: Colors.grey[300],
                      child: Center(child: Text('No Image Available'))),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
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

          // Crear un conjunto de marcadores
          Set<Marker> markers = {
            Marker(
              markerId: MarkerId('currentLocation'),
              position: currentLatLng,
              infoWindow: InfoWindow(title: 'Estás aquí, $userName'),
              icon: myLocationIcon ??
                  BitmapDescriptor.defaultMarker, // Usa el ícono personalizado
            ),
            // Agregar marcadores para cada mascota
            for (var pet in pets)
              Marker(
                markerId: MarkerId(pet.id.toString()),
                position: LatLng(pet.latitude, pet.longitude),
                infoWindow: InfoWindow(title: pet.name),
                onTap: () => _showPetDetails(pet),
              ),
          };

          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: currentLatLng,
              zoom: 16,
            ),
            markers: markers,
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
