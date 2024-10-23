import 'package:findpetapp/src/Page/Auth/login_page.dart';
import 'package:findpetapp/src/Page/Home/dashboar_page.dart';
import 'package:findpetapp/src/Services/auth_service.dart';
import 'package:findpetapp/src/widgets/custom_app_bar.dart';
import 'package:findpetapp/src/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final AuthService authService = Get.put(AuthService());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'FindPets',
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Aquí puedes añadir la funcionalidad que desees
            },
          ),
        ],
        hasDrawer: true, // Indica que esta página tiene Drawer
      ),
      drawer: MyDrawer(), // Drawer activo
      body: Obx(() {
        if (authService.isAuthenticated.value) {
          return DashboardPage();
        } else {
          return LoginPage();
        }
      }),
    );
  }
}
