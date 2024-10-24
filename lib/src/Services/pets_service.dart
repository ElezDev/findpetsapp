import 'dart:convert';
import 'package:findpetapp/src/Api/cosntants.dart';
import 'package:findpetapp/src/Models/pets.dart';
import 'package:http/http.dart' as http;

class PetService {
Future<List<Pets>> fetchPets() async {
  try {
    final response = await http.get(Uri.parse(Constants.petsUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map<Pets>((pet) {
        List<ImageModel> images = [];
        if (pet['images'] != null) {
          images = List<ImageModel>.from(
            pet['images'].map((img) => ImageModel(
              id: img['id'],
              petId: img['pet_id'],
              imageUrl: img['image_url'],
            )),
          );
        }

        return Pets(
          id: pet['id'],
          name: pet['name'],
          latitude: double.parse(pet['latitude']),
          longitude: double.parse(pet['longitude']),
          images: images, // Aquí pasas la lista de imágenes
          imageUrl: images.isNotEmpty ? images[0].imageUrl : null, // Puedes seguir usando la primera imagen si lo deseas
        );
      }).toList();
    } else {
      throw Exception('Failed to load pets: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load pets: $e');
  }
}

}
