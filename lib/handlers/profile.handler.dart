import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinjemlah/models/user.model.dart';
import 'package:pinjemlah/utils/dio.dart';

class UserProfile extends GetxController {
  final isLoading = false.obs;
  final Dio dio = DioClient().dio;
  final Rx<User?> user = Rx<User?>(null);

  Future<void> updateProfile(String name, String email, String birtDate,
      String address, String ktp, String income, String rekening) async {
    isLoading(true);
    var incomeD = double.tryParse(income);
    try {
      final res = await dio.put('/user/update-profile', data: {
        'name': name,
        'email': email,
        'birth_date': birtDate,
        'address': address,
        'ktp_number': ktp,
        'monthly_income': incomeD,
        'account_number': rekening,
      });
      if (res.statusCode == 200) {
        final box = GetStorage();
        box.write('rekening', rekening);
        box.write('income', incomeD);
        Get.snackbar('Success', 'Profile Updated');
        Get.offNamed('/home');
      } else {
        Get.snackbar('Ups', res.data['message']);
        return;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> userProfile() async {
    isLoading(true);
    try {
      final res = await dio.get('/user/profile');
      if (res.statusCode == 200) {
        user.value = User.fromJson(res.data['data']);
      } else {
        Get.snackbar('Ups', res.data['message']);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
