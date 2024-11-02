import 'dart:convert';
import 'package:findpetapp/src/Api/cosntants.dart';
import 'package:findpetapp/src/Services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:findpetapp/src/models/pet_model.dart';
import 'package:url_launcher/url_launcher.dart';

class PetController extends GetxController {
  var pets = <Pet>[].obs;
  var petsUser = <Pet>[].obs;

  var isLoading = true.obs;
  var currentIndex = 0.obs;
  var currentImageIndex = 0.obs;
  AuthService authService = AuthService();

  @override
  void onInit() {
    loadPets();
    loadPetsByUser();
    super.onInit();
  }

  Future<void> loadPets() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(Constants.petsUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        var loadedPets = data.map((json) => Pet.fromJson(json)).toList();
        pets.assignAll(loadedPets);
      } else {
        showOverlay("Error al cargar las mascotas", Colors.red);
      }
    } catch (e) {
      showOverlay("Error de conexión: $e", Colors.red);
    } finally {
      isLoading(false);
    }
  }

  Future<void> loadPetsByUser() async {
    String token = await authService.getToken();

    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse(Constants.petByUser),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        print(response.body);
        var loadedPetsUser = data.map((json) => Pet.fromJson(json)).toList();
        petsUser.assignAll(loadedPetsUser);
      } else {
        showOverlay("Error al cargar las mascotas", Colors.red);
      }
    } catch (e) {
      showOverlay("Error de conexión: $e", Colors.red);
    } finally {
      isLoading(false);
    }
  }

  void showOverlay(String message, Color backgroundColor) {
    Get.dialog(
      AlertDialog(
        backgroundColor: backgroundColor,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      barrierDismissible: true,
    );
    Future.delayed(const Duration(seconds: 2), () => Get.back());
  }

  void likePet(Pet pet) {
    Get.snackbar(
      "¡Te gustó!",
      pet.name,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void dislikePet(Pet pet) {
    Get.snackbar(
      "¡No te gustó!",
      pet.name,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

    makePhoneCall() async {
    const phoneNumber = 'tel:+573172231389';
    try {
      if (await canLaunchUrl(Uri.parse(phoneNumber))) {
        await launchUrl(Uri.parse(phoneNumber));
      } else {
        Get.snackbar(
          'Error',
          'No se pudo realizar la llamada al número $phoneNumber',
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Ocurrió un problema al intentar realizar la llamada.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
