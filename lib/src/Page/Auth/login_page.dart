import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:findpetapp/src/Services/auth_service.dart';

class LoginPage extends StatelessWidget {
  final AuthService authService = Get.find<AuthService>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Correo electrónico'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true, // Oculta la contraseña
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String email = emailController.text;
                String password = passwordController.text;
                await authService.login(email, password);
                
                // Verifica si la autenticación fue exitosa
                if (authService.isAuthenticated.value) {
                  Get.offAllNamed('/'); // Redirige a la pantalla principal si el login fue exitoso
                } else {
                  Get.snackbar('Error', 'Credenciales incorrectas', snackPosition: SnackPosition.BOTTOM);
                }
              },
              child: Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
