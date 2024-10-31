import 'package:dio/dio.dart';
import 'package:findpetapp/src/Api/cosntants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService extends GetxController {
  final Dio _dio = Dio();
  var isAuthenticated = false.obs;
  String? token;
  var userData = {}.obs;
  Future<void> login(String email, String password) async {
    try {
      var response = await _dio.post(
        Constants.loginUrl,
        data: {'email': email, 'password': password},
      );

      token = response.data['token'];
      print(token);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', token!);

      isAuthenticated.value = true;
      await fetchUserData();
    } catch (e) {
      print('Error: $e');
      isAuthenticated.value = false;
    }
  }

  Future<void> checkAuthentication() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('authToken');
    print(token);

    if (token != null) {
      isAuthenticated.value = true;
      await fetchUserData();
    } else {
      isAuthenticated.value = false;
    }
  }

  Future<void> fetchUserData() async {
    try {
      if (token != null) {
        _dio.options.headers["Authorization"] = "Bearer $token";
        var response = await _dio.get(Constants.userDataUrl);
        userData.value = response.data['user'];
        print(response);
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');

    isAuthenticated.value = false;
    token = null;
    userData.value = {};
  }

  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('authToken') ?? '';
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phoneNumber,
    String? address,
    String? biography,
    String? imageUrl,
  }) async {
    try {
      // Validar campos
      if (firstName.isEmpty ||
          lastName.isEmpty ||
          email.isEmpty ||
          password.isEmpty) {
        throw Exception('Todos los campos son obligatorios');
      }

      var request =
          http.MultipartRequest('POST', Uri.parse(Constants.registerUrl));

      request.fields['first_name'] = firstName;
      request.fields['last_name'] = lastName;
      request.fields['email'] = email;
      request.fields['password'] = password;
      if (phoneNumber != null) request.fields['phone_number'] = phoneNumber;
      if (address != null) request.fields['address'] = address;
      if (biography != null) request.fields['biography'] = biography;

      if (imageUrl != null) {
        var file = await http.MultipartFile.fromPath('image_url', imageUrl);
        request.files.add(file);
      }

      print('Datos enviados: ${request.fields}');
      if (request.files.isNotEmpty) {
        print('Imagen enviada: ${request.files[0].filename}');
      }

      final response = await request.send();

      final responseBody = await http.Response.fromStream(response);
      print('Respuesta del servidor: ${responseBody.body}');

      // Procesar la respuesta
      if (responseBody.statusCode == 201) {
        Get.snackbar(
          'Registro Exitoso',
          'Usuario registrado con éxito',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAllNamed(
            '/login');
      } else {
        Get.snackbar(
          'Error de Registro',
          jsonDecode(responseBody.body)['message'] ??
              'No se pudo completar el registro',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error: $e'); 
      Get.snackbar(
        'Error',
        'Hubo un problema al registrar al usuario. Inténtalo de nuevo.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }
}
