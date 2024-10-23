import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:findpetapp/src/Page/Auth/login_page.dart';
import 'package:findpetapp/src/Page/Home/dashboard_page.dart';
import 'package:findpetapp/src/Page/PetsPost/pets_swipe_page.dart';
import 'package:findpetapp/src/Services/auth_service.dart';
import 'package:findpetapp/src/widgets/custom_app_bar.dart';
import 'package:findpetapp/src/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService authService = Get.put(AuthService());
  int _currentIndex = 0;

  final List<Widget> _pages = [
    DashboardPage(),
    PetsSwipePage(),
    Center(child: Text('Perfil de Usuario')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'FindPets',
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
        hasDrawer: true,
      ),
      drawer: MyDrawer(),
      body: Obx(() {
        if (authService.isAuthenticated.value) {
          return _pages[_currentIndex];
        } else {
          return LoginPage();
        }
      }),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        activeColor: Colors.pinkAccent,
        color: Colors.white,
        style: TabStyle.react,
        items: const [
          TabItem(icon: Icons.home, title: 'Inicio'),
          TabItem(icon: Icons.pets, title: 'Pest'),
          TabItem(icon: Icons.person, title: 'Perfil'),
        ],
        initialActiveIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
