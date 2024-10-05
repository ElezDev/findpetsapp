import 'package:dio/dio.dart';
import 'package:findpetapp/src/Api/cosntants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  final Dio _dio = Dio();
  var isAuthenticated = false.obs;
  String? token;
  var userData = {}.obs;
  Future<void> login(String email, String password) async {
    try {
      var response = await _dio.post(
        Constants.loginUrl,
        data: {'email': email, 'password': password},
      );

      token = response.data['token'];
      print(token);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', token!);

      isAuthenticated.value = true;
    } catch (e) {
      print('Error: $e');
      isAuthenticated.value = false;
    }
  }

  Future<void> checkAuthentication() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('authToken');
    print(token);

    if (token != null) {
      isAuthenticated.value = true;
       await fetchUserData();
    } else {
      isAuthenticated.value = false;
    }
  }

  Future<void> fetchUserData() async {
    try {
      if (token != null) {
        _dio.options.headers["Authorization"] = "Bearer $token";
        var response = await _dio.get(Constants.userDataUrl);
        userData.value = response.data['user'];
        print(response);
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');

    isAuthenticated.value = false;
    token = null;
    userData.value = {};
  }
}
