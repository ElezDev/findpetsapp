import 'package:findpetapp/src/Services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  final AuthService authService = Get.find<AuthService>();

   MyDrawer({super.key});

   @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Obx(() {
        return ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    authService.userData['name'] ?? 'Nombre de Usuario',
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  Text(
                    authService.userData['email'] ?? 'Email',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Perfil'),
              onTap: () {
              },
            ),
            ListTile(
              title: const Text('Cerrar sesión'),
              onTap: () {
                authService.logout();
                Get.offAllNamed('/login'); // Navega a la pantalla de login
              },
            ),
          ],
        );
      }),
    );
  }
}