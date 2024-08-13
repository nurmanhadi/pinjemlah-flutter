import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthHandlers extends GetxController {
  final isLoading = false.obs;
  final Dio dio = Dio();
  final cookieJar = CookieJar();
  String url = 'https://strategic-adina-nurman-629004a9.koyeb.app';

  AuthHandlers() {
    dio.interceptors.add(CookieManager(cookieJar));
  }

  @override
  void onInit() async {
    super.onInit();
    await GetStorage.init();
  }

  Future<void> userLogin(String phone, String password) async {
    isLoading(true);
    try {
      final res = await dio.post(
        '$url/api/auth/login',
        data: {
          "phone_number": phone,
          "password": password,
        },
      );
      if (res.statusCode == 202) {
        final box = GetStorage();
        box.write('jwt', res.data['token']);
        Get.offNamed('/after-login');
      } else {
        print(res.data['message']);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> userDaftar(String phone, String password) async {
    isLoading(true);
    try {
      final res = await dio.post(
        '$url/api/auth/register',
        data: {
          "phone_number": phone,
          "password": password,
        },
      );
      if (res.statusCode == 201) {
        Get.offNamed('/login');
      } else {
        Get.snackbar("Daftar", res.data['message']);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> userLogout() async {
    isLoading(true);
    try {
      final res = await dio.post('$url/api/auth/logout');
      if (res.statusCode == 200) {
        final box = GetStorage();
        box.remove('jwt');
        box.remove('rekening');
        box.remove('income');
        box.remove('ip');
        dio.interceptors.remove(CookieManager(cookieJar));
        Get.offAllNamed('/login');
      } else {
        Get.snackbar("Logout", res.data['message']);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
