import 'package:get/get.dart';

class UserSession extends GetxController {
  Future<void> checkSession() async {
    String? jwt = "jwt";
    if (jwt != "null") {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/login');
    }
  }
}
