import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:findpetapp/src/Services/auth_service.dart';

class RegisterController extends GetxController {
  final AuthService authService = Get.find<AuthService>();

  final Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  Future<void> seleccionarImagen(bool desdeCamara) async {
    final XFile? image = await _picker.pickImage(
      source: desdeCamara ? ImageSource.camera : ImageSource.gallery,
    );

    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  void limpiarImagen() {
    selectedImage.value = null;
  }

  Future<void> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phoneNumber,
    required String address,
    required String biography,
  }) async {
    await authService.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      address: address,
      biography: biography,
      imageUrl: selectedImage.value?.path,
    );
  }
}
