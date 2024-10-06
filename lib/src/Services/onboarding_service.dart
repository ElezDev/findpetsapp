import 'package:shared_preferences/shared_preferences.dart';

class OnboardingService {
  Future<bool> shouldShowOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboardingShown') ?? true; 
  }

  Future<void> setOnboardingShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingShown', true);
  }
}
