import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinjemlah/utils/color.dart';
import 'package:pinjemlah/utils/dio.dart';

class UserPayment extends GetxController {
  final isLoading = false.obs;
  final Dio dio = DioClient().dio;

  Future<void> addPayment(String paymentAmount, String loanID) async {
    isLoading(true);
    var amount = double.tryParse(paymentAmount);

    try {
      final res = await dio.post('/user/loan/payment/$loanID', data: {
        'payment_amount': amount,
      });
      if (res.statusCode == 201) {
        Get.defaultDialog(
          title: "Sukses",
          titleStyle: const TextStyle(
            color: CustomColor.primary,
            fontWeight: FontWeight.bold,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 50,
              ),
              const SizedBox(height: 16),
              const Text(
                'kamu telah melakukan pembayaran',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CustomColor.primary,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: CustomColor.primary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: const Text("Ok"),
              ),
            ],
          ),
          backgroundColor: Colors.white,
        );
      } else {
        Get.snackbar("Ups", res.data['message']);
        Get.offNamed('/loan', arguments: loanID);
        return;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
