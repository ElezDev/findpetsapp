// lib/src/Page/PetsPost/controllers/pet_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:findpetapp/src/models/pet_model.dart';

class PetController extends GetxController {
  var pets = <Pet>[].obs;
  var currentIndex = 0.obs;

  @override
  void onInit() {
    loadPets();
    super.onInit();
  }

  void loadPets() {
    var loadedPets = [
      Pet(
        name: 'Max',
        breed: 'Golden Retriever',
        imageUrl: 'assets/images/perros1.png',
        description: 'Max es un cachorro adorable y juguetón',
        age: '2 años',
        location: 'Lima, Perú',
      ),
      Pet(
        name: 'Bella',
        breed: 'Labrador',
        imageUrl: 'assets/images/perro2.png',
        description: 'Bella es cariñosa y le encantan los abrazos',
        age: '3 años',
        location: 'Cusco, Perú',
      ),
      Pet(
        name: 'Charlie',
        breed: 'Beagle',
        imageUrl: 'assets/images/perro.png',
        description: 'Charlie es aventurero y siempre está feliz',
        age: '1 año',
        location: 'Arequipa, Perú',
      ),
    ];
    pets.addAll(loadedPets);
  }

  void showOverlay(String message, Color backgroundColor) {
    Get.dialog(
      AlertDialog(
        backgroundColor: backgroundColor,
        content: Text(
          message,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      barrierDismissible: true,
    );

    Future.delayed(Duration(seconds: 2), () {
      Get.back(); // Cierra el diálogo después de 2 segundos
    });
  }

  void likePet(Pet pet) {
    print("Te gustó ${pet.name}");
    Get.snackbar(
      "¡Te gustó!",
      "${pet.name}",
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void dislikePet(Pet pet) {
    print("No te gustó ${pet.name}");
    Get.snackbar(
      "¡No te gustó!",
      "${pet.name}",
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
