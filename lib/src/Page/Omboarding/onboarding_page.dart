import 'package:findpetapp/src/Utils/Styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:findpetapp/src/Services/onboarding_service.dart';

class OnboardingPage extends StatefulWidget {
  OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final OnboardingService _onboardingService = OnboardingService();
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "¡Bienvenido a FindPet!",
      "description":
          "Encuentra, adopta y publica mascotas de manera sencilla y rápida.",
      "image": "assets/images/perros1.png",
    },
    {
      "title": "Conéctate con Otros",
      "description": "Únete a una comunidad de amantes de los animales.",
      "image": "assets/images/perro2.png",
    },
    {
      "title": "Adopta una Mascota",
      "description": "Haz feliz a un animal y dale un hogar.",
      "image": "assets/images/perro.png",
    },
  ];

  void _finishOnboarding(BuildContext context) async {
    await _onboardingService.setOnboardingShown();
    Get.offAllNamed('/login');
  }

  void _nextPage() {
    if (_currentIndex < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _finishOnboarding(context);
    }
  }

  void _skipOnboarding() async {
    await _onboardingService.setOnboardingShown();
    Get.offAllNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              // Fila para el botón de omitir y el título
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                        size: 30,
                        color: Colors.pinkAccent,
                        
                        ),
                    onPressed: () {
                      // Acción al presionar el botón de retroceso
                      // Get.offAllNamed('/login'); // Redirige al login
                    },
                  ),
                  TextButton(
                    onPressed:
                        _skipOnboarding, // Llama a la función para omitir
                    child: const Text(
                      "Omitir",
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: _onboardingData.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _onboardingData[index]['title']!,
                          style: bigTitle(context),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _onboardingData[index]['description']!,
                          style: smallitle(context),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        Image.asset(
                          _onboardingData[index]['image']!,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      ],
                    );
                  },
                ),
              ),
              // Indicador de progreso
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _onboardingData.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: _currentIndex == index ? 24 : 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _currentIndex == index
                          ? Colors.pinkAccent
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Botón para iniciar
              ElevatedButton(
                onPressed: _nextPage, // Llama a la función para avanzar
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  _currentIndex == _onboardingData.length - 1
                      ? "Comenzar"
                      : "Siguiente",
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
