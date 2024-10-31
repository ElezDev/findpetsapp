import 'package:dotted_border/dotted_border.dart';
import 'package:findpetapp/src/Page/PetsPost/controllers/pet_post_controller.dart';
import 'package:findpetapp/src/Utils/Styles.dart';
import 'package:findpetapp/src/widgets/Seleccion_imagen_Modal.dart';
import 'package:findpetapp/src/widgets/custom_loading.dart';
import 'package:findpetapp/src/widgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:findpetapp/src/Services/auth_service.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService authService = Get.find<AuthService>();
  final PetPostController controller = Get.put(PetPostController());

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController biographyController = TextEditingController();

  File? _image;
  int _currentStep = 0;

  void _mostrarOpcionesImagen(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SeleccionImagenModal(
          onCameraSelected: () {
            controller.seleccionarImagen(true);
          },
          onGallerySelected: () {
            controller.seleccionarImagen(false);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Crear una cuenta',
                  style: bigTitle(context),
                  textAlign: TextAlign.center,
                ),
                Stepper(
                  currentStep: _currentStep,
                  onStepContinue: () {
                    if (_currentStep < 2) {
                      setState(() {
                        _currentStep++;
                      });
                    } else {
                      _registrarUsuario();
                    }
                  },
                  onStepCancel: () {
                    if (_currentStep > 0) {
                      setState(() {
                        _currentStep--;
                      });
                    }
                  },
                  steps: [
                    Step(
                      title: const Text('Información básica'),
                      content: Column(
                        children: [
                          buildTextField(
                            controller: firstNameController,
                            labelText: 'Nombre',
                            icon: Icons.person,
                          ),
                          const SizedBox(height: 20),
                          buildTextField(
                            controller: lastNameController,
                            labelText: 'Apellido',
                            icon: Icons.person,
                          ),
                          const SizedBox(height: 20),
                          buildTextField(
                            controller: emailController,
                            labelText: 'Correo electrónico',
                            icon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),
                          buildTextField(
                            controller: passwordController,
                            labelText: 'Contraseña',
                            icon: Icons.lock,
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                    Step(
                      title: const Text('Información adicional'),
                      content: Column(
                        children: [
                          buildTextField(
                            controller: phoneNumberController,
                            labelText: 'Teléfono',
                            icon: Icons.phone,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 20),
                          buildTextField(
                            controller: addressController,
                            labelText: 'Dirección',
                            icon: Icons.home,
                          ),
                          const SizedBox(height: 20),
                          buildTextField(
                            controller: biographyController,
                            labelText: 'Biografía',
                            icon: Icons.info_outline,
                          ),
                        ],
                      ),
                    ),
                    Step(
                      title: const Text('Subir imagen y confirmar'),
                      content: Column(
                        children: [
                          DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(12),
                            color: Colors.pinkAccent,
                            strokeWidth: 2,
                            child: Container(
                              width: 120,
                              height: 120,
                              child: Center(
                                child: GestureDetector(
                                  onTap: () => _mostrarOpcionesImagen(context),
                                  child: _image == null
                                      ? const Icon(Icons.image,
                                          size: 100, color: Colors.grey)
                                      : Image.file(
                                          _image!,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    if (_currentStep < 2) {
                      setState(() {
                        _currentStep++;
                      });
                    } else {
                      _registrarUsuario();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Siguiente',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _registrarUsuario() async {
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty) {
      Get.snackbar(
        'Error',
        'Por favor, completa todos los campos obligatorios',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    showLoadingDialog(context);
    await authService.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      phoneNumber: phoneNumberController.text.trim(),
      address: addressController.text.trim(),
      biography: biographyController.text.trim(),
      imageUrl: _image?.path,
    );

    Navigator.of(context).pop();

    if (authService.isAuthenticated.value) {
      Get.offAllNamed('/');
    } else {
      Get.snackbar(
        'Error',
        'No se pudo completar el registro',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }
}
