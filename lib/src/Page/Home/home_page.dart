import 'package:findpetapp/src/Page/Auth/login_page.dart';
import 'package:findpetapp/src/Page/Home/dashboar_page.dart';
import 'package:findpetapp/src/Services/auth_service.dart';
import 'package:findpetapp/src/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class HomePage extends StatelessWidget {
//   final AuthService authService = Get.put(AuthService());

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (authService.isAuthenticated.value) {
//         return DashboardScreen(); 
//       } else {
//         return LoginPage(); 
//       }
//     });
//   }
// }


class HomePage extends StatelessWidget {
  final AuthService authService = Get.put(AuthService());

   HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FindPets'),
      ),
      drawer:  MyDrawer(), 
      body: Obx(() {
        if (authService.isAuthenticated.value) {
         return  DashboardPage();  
        } else {
          return LoginPage(); 
        }
      }),
    );
  }
}
