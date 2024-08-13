import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinjemlah/utils/color.dart';
import 'package:pinjemlah/utils/dio.dart';

class AfterLogin extends StatefulWidget {
  const AfterLogin({super.key});

  @override
  State<AfterLogin> createState() => _AfterLoginState();
}

class _AfterLoginState extends State<AfterLogin> {
  final Dio dio = DioClient().dio;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    _checkUserProfile();
  }

  Future<void> _checkUserProfile() async {
    try {
      final response = await dio.get('/user/profile');

      if (response.statusCode == 200) {
        final data = response.data['data']['email'];
        var rekening = response.data['data']['account_number'];
        var income = response.data['data']['monthly_income'];
        if (data != "") {
          Future.delayed(const Duration(seconds: 2), () {
            Get.offAllNamed('/home');
            box.write('rekening', rekening);
            box.write('income', income);
          });
        } else {
          Future.delayed(const Duration(seconds: 2), () {
            Get.offNamed('/profile');
          });
        }
      } else {
        Get.snackbar("Ups", response.data['message']);
      }
    } catch (e) {
      // Handle error
      print('Error fetching user profile: $e');
      Get.offNamed('/error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: CustomColor.primary,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
