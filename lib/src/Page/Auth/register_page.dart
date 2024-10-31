import 'package:dotted_border/dotted_border.dart';
import 'package:findpetapp/src/Page/Auth/register_controller.dart';
import 'package:findpetapp/src/Utils/Styles.dart';
import 'package:findpetapp/src/widgets/Seleccion_imagen_Modal.dart';
import 'package:findpetapp/src/widgets/custom_loading.dart';
import 'package:findpetapp/src/widgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController controller = Get.put(RegisterController());
  int _currentStep = 0;

  // Controladores de texto
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController biographyController = TextEditingController();

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

  void _nextStep() {
    setState(() {
      if (_currentStep < 2) {
        _currentStep++;
      }
    });
  }

  void _prevStep() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Crear una cuenta',
                  style: bigTitle(context),
                  textAlign: TextAlign.center,
                ),
                _buildStepper(),
                const SizedBox(height: 20),
                _buildRegisterButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepper() {
    return Stepper(
      currentStep: _currentStep,
      onStepContinue: _nextStep,
      onStepCancel: _prevStep,
      steps: [
        Step(
          title: const Text('Paso 1: Información Personal'),
          content: _buildImageAndNameSection(),
          isActive: _currentStep >= 0,
          state: _currentStep == 0 ? StepState.editing : StepState.complete,
        ),
        Step(
          title: const Text('Paso 2: Información de Contacto'),
          content: _buildContactInfoSection(),
          isActive: _currentStep >= 1,
          state: _currentStep == 1 ? StepState.editing : StepState.complete,
        ),
        Step(
          title: const Text('Paso 3: Biografía'),
          content: _buildBiographySection(),
          isActive: _currentStep >= 2,
          state: _currentStep == 2 ? StepState.editing : StepState.complete,
        ),
      ],
    );
  }

  Widget _buildImageAndNameSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _mostrarOpcionesImagen(context),
          child: Obx(
            () => DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(12),
              color: Colors.pinkAccent,
              strokeWidth: 2,
              child: Container(
                width: 120,
                height: 120,
                child: Center(
                  child: controller.selectedImage.value == null
                      ? const Icon(Icons.image, size: 100, color: Colors.grey)
                      : Image.file(
                          controller.selectedImage.value!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
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
      ],
    );
  }

  Widget _buildContactInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
    );
  }

  Widget _buildBiographySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTextField(
          controller: biographyController,
          labelText: 'Biografía',
          icon: Icons.info_outline,
        ),
        const SizedBox(height: 20),
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
      ],
    );
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_currentStep == 2) {
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

          await controller.registerUser(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            phoneNumber: phoneNumberController.text.trim(),
            address: addressController.text.trim(),
            biography: biographyController.text.trim(),
          );

          Navigator.of(context).pop();

          if (controller.authService.isAuthenticated.value) {
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
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: const Text(
        'Registrarse',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
