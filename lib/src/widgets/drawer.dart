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
                color: Colors.blue.shade700, 
                image: const DecorationImage(
                  image: AssetImage(
                      'assets/background_drawer.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: authService.userData['avatarUrl'] != null
                    ? NetworkImage(authService.userData['avatarUrl'])
                    : const AssetImage('assets/default_avatar.png') as ImageProvider,
                backgroundColor: Colors.white,
              ),
              accountName: Text(
                authService.userData['name'] ?? 'Nombre de Usuario',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                authService.userData['email'] ?? 'Email',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.blue),
              title: const Text('Perfil'),
              onTap: () {
                Get.toNamed('/profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.blue),
              title: const Text('Configuración'),
              onTap: () {
                Get.toNamed(
                    '/settings');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Cerrar sesión'),
              onTap: () {
                authService.logout();
                Get.offAllNamed('/login'); 
              },
            ),
          ],
        );
      }),
    );
  }
}
