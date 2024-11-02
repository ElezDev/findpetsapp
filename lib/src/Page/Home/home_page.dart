import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:findpetapp/src/Page/Auth/login_page.dart';
import 'package:findpetapp/src/Page/Home/dashboard_page.dart';
import 'package:findpetapp/src/Page/Home/home_controller.dart';
import 'package:findpetapp/src/Page/MapsPet/map_pet_page.dart';
import 'package:findpetapp/src/Page/PetsPost/pets_swipe_page.dart';
import 'package:findpetapp/src/Page/User/user_profile_page.dart';
import 'package:findpetapp/src/Services/auth_service.dart';
import 'package:findpetapp/src/widgets/custom_app_bar.dart';
import 'package:findpetapp/src/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = Get.put(AuthService());
    final HomeController homeController = Get.put(HomeController());
    final List<Widget> pages = [
      DashboardPage(),
      PetsSwipePage(),
      const MapPetPage(),
      UserProfilePage(),
    ];

    return Scaffold(
     
      body: Obx(() {
        if (authService.isAuthenticated.value) {
          return pages[homeController
              .currentIndex.value]; // Cambia la página según el índice
        } else {
          return LoginPage();
        }
      }),
      bottomNavigationBar: Obx(() => ConvexAppBar(
            backgroundColor: Theme.of(context).primaryColor,
            activeColor: Colors.pinkAccent,
            color: Colors.white,
            style: TabStyle.react,
            items: const [
              TabItem(icon: Icons.home, title: 'Inicio'),
              TabItem(icon: Icons.pets, title: 'Pest'),
              TabItem(icon: Icons.map_sharp, title: 'Maps'),
              TabItem(icon: Icons.person, title: 'Mi Perfil'),
            ],
            initialActiveIndex: homeController.currentIndex.value,
            onTap: (int index) {
              homeController
                  .changeTab(index); // Cambia el índice en el controlador
              // Aquí no necesitas hacer más, el cuerpo se actualizará automáticamente
            },
          )),
    );
  }
}
