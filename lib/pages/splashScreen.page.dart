import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinjemlah/utils/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    var jwt = box.read('jwt');
    if (jwt != null) {
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAllNamed('/home');
      });
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAndToNamed('/login');
      });
    }

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
