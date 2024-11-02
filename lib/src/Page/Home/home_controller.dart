import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs; // Observable para el índice actual

  void changeTab(int index) {
    currentIndex.value = index; // Cambia el índice actual
  }
}
