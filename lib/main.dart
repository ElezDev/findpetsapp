import 'package:findpetapp/src/Page/Auth/login_page.dart';
import 'package:findpetapp/src/Page/Auth/register_page.dart';
import 'package:findpetapp/src/Page/Home/home_page.dart';
import 'package:findpetapp/src/Page/MapsPet/map_pet_page.dart';
import 'package:findpetapp/src/Page/Omboarding/onboarding_page.dart';
import 'package:findpetapp/src/Page/PetsPost/new_pet_page.dart';
import 'package:findpetapp/src/Page/PetsPost/pets_swipe_page.dart';
import 'package:findpetapp/src/Services/auth_middleware.dart';
import 'package:findpetapp/src/Services/auth_service.dart';
import 'package:findpetapp/src/Services/onboarding_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final authService = Get.put(AuthService());
  final onboardingService = OnboardingService();

  // Verificación de autenticación
  await authService.checkAuthentication();
  final shouldShowOnboarding = await onboardingService.shouldShowOnboarding();

  // Remover el splash
  FlutterNativeSplash.remove();

  String initialRoute;

  if (authService.isAuthenticated.value) {
    initialRoute = '/';
  } else if (shouldShowOnboarding) {
    initialRoute = '/onboarding';
  } else {
    initialRoute = '/login';
  }

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'App de Mascotas',
      initialRoute: initialRoute,
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomePage(),
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: '/login',
          page: () => LoginPage(),
        ),
        GetPage(
          name: '/onboarding',
          page: () => const OnboardingPage(),
        ),
        GetPage(
          name: '/newpet',
          page: () => NewPetPage(),
        ),
        GetPage(
          name: '/petswipe',
          page: () => PetsSwipePage(),
        ),
        GetPage(
          name: '/mapPet',
          page: () => const MapPetPage(),
        ),
        GetPage(
          name: '/UserProfilePage',
          page: () => const MapPetPage(),
        ),
        GetPage(
          name: '/register',
          page: () => RegisterPage(),
        ),
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          primary: Color(0xFF2E4A62), // Azul grisáceo oscuro
          onPrimary: Colors.white,
          secondary: Color(0xFFE07A5F), // Coral profundo
          onSecondary: Colors.white,
          surface: Color(0xFFFFFFFF), // Blanco para superficies
          onSurface: Colors.black87,
          error: Color(0xFFD9534F), // Rojo quemado para errores
          onError: Colors.white,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          primary: Color(0xFF2E4A62), // Azul grisáceo oscuro
          onPrimary: Colors.white,
          secondary: Color(0xFFE07A5F), // Coral profundo
          onSecondary: Colors.white,
          surface: Color(0xFF121212), // Superficie en gris oscuro
          onSurface: Colors.white70,
          error: Color(0xFFD9534F), // Rojo quemado
          onError: Colors.white,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
    );
  }
}
