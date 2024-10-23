import 'package:findpetapp/src/Page/Auth/login_page.dart';
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

  // Mueve la verificación de autenticación aquí, antes de remover el splash
  await authService.checkAuthentication();
  final shouldShowOnboarding = await onboardingService.shouldShowOnboarding();

  // Una vez que todo esté listo, remueve el splash
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
          page: () => HomePage(),
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
          page: () => MapPetPage(),
        ),
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4563DB),
          brightness: Brightness.light, // Tema claro
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFB0006D),
          brightness: Brightness.dark, // Tema oscuro
        ),
      ),
      themeMode: ThemeMode.system,
    );
  }
}


