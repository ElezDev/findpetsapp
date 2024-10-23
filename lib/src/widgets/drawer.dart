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
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue.shade700, // Fondo atractivo
                image: DecorationImage(
                  image: AssetImage(
                      'assets/background_drawer.jpg'), // Fondo personalizado
                  fit: BoxFit.cover,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: authService.userData['avatarUrl'] != null
                    ? NetworkImage(authService.userData['avatarUrl'])
                    : AssetImage('assets/default_avatar.png') as ImageProvider,
                backgroundColor: Colors.white,
              ),
              accountName: Text(
                authService.userData['name'] ?? 'Nombre de Usuario',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                authService.userData['email'] ?? 'Email',
                style: TextStyle(fontSize: 16),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.blue),
              title: const Text('Perfil'),
              onTap: () {
                Get.toNamed('/profile'); // Navega a la pantalla de perfil
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.blue),
              title: const Text('Configuración'),
              onTap: () {
                Get.toNamed(
                    '/settings'); // Navega a la pantalla de configuración
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
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
