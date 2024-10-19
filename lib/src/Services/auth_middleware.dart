import 'package:findpetapp/src/Services/auth_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authService = Get.find<AuthService>();
    return authService.isAuthenticated.value ? null : const RouteSettings(name: '/login');
  }
}





