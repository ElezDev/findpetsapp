import 'package:findpetapp/src/Api/cosntants.dart';
import 'package:findpetapp/src/Services/auth_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'dart:convert';
import 'package:http/http.dart' as http;

class PetPostController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  var imagenes = <File>[].obs;
  AuthService authService =
      AuthService(); 
  Future<void> seleccionarImagen(bool fromCamera) async {
    final pickedFile = await _picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (pickedFile != null) {
      imagenes.add(File(pickedFile.path));
    }
  }
  void eliminarImagen(int index) {
    imagenes.removeAt(index);
  }

  // Método para cambiar imagen
  Future<void> cambiarImagen(int index, bool fromCamera) async {
    final pickedFile = await _picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (pickedFile != null) {
      imagenes[index] = File(pickedFile.path);
    }
  }

  Future<void> publicarMascota(Map<String, dynamic> mascotaData) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Constants.pestUrl),
    );
    String token = await authService.getToken();

    request.headers['Authorization'] = 'Bearer $token';

    request.fields['name'] = mascotaData['name'];
    request.fields['age'] = mascotaData['age'].toString();
    request.fields['breed'] = mascotaData['breed'];
    request.fields['size'] = mascotaData['size'];
    request.fields['description'] = mascotaData['description'];
    request.fields['location'] = mascotaData['location'];
    request.fields['adoption_status'] = mascotaData['adoption_status'];
    request.fields['latitude'] = mascotaData['latitude'].toString();
    request.fields['longitude'] = mascotaData['longitude'].toString();
    print('token: ${token.toString()}');
    for (var image in imagenes) {
      var pic = await http.MultipartFile.fromPath('images[]', image.path);
      request.files.add(pic);
    }

    try {
      var response = await request.send();

      print('Código de estado: ${response.statusCode}');

      var responseData = await response.stream.bytesToString();
      print('Cuerpo de la respuesta: $responseData');

      if (response.statusCode == 201) {
        var jsonResponse = jsonDecode(responseData);
        Get.snackbar('Éxito', 'Mascota publicada: ${jsonResponse['id']}');
      } else {
        var errorMessage = jsonDecode(responseData)['message'] ??
            'No se pudo publicar la mascota';
        Get.snackbar('Error', errorMessage);
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Ocurrió un error: $e');
    }
  }
}
