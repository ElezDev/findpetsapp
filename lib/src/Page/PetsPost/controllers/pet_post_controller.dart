import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PetPostController extends GetxController {
 final ImagePicker _picker = ImagePicker();
  var imagenes = <File>[].obs;

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

  Future<void> cambiarImagen(int index, bool fromCamera) async {
    final pickedFile = await _picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (pickedFile != null) {
      imagenes[index] = File(pickedFile.path);
    }
  }
}