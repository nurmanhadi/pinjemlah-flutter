import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinjemlah/models/loan.model.dart';
import 'package:pinjemlah/models/payment.model.dart';
import 'package:pinjemlah/utils/color.dart';
import 'package:pinjemlah/utils/dio.dart';

class LoanHandlers extends GetxController {
  final isLoading = false.obs;
  final Dio dio = DioClient().dio;
  final RxList<Loan> loans = <Loan>[].obs;
  final Rx<Loan?> loan = Rx<Loan?>(null);
  final RxList<Payment> payments = <Payment>[].obs;

  Future<void> addLoan(String loanAmount, String loanTerm) async {
    isLoading(true);
    var loan = double.tryParse(loanAmount);
    var term = int.tryParse(loanTerm);
    try {
      final res = await dio.post('/user/loan', data: {
        'loan_amount': loan,
        'loan_term': term,
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
                "Pinjaman Berhasil ditambahkan. tunggu admin cek ya :)",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CustomColor.primary,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Get.offNamed('/home'),
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
        Get.snackbar("Gagal Pinjam", res.data['message']);
        Get.offNamed('/home');
        return;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> getLoans() async {
    isLoading(true);
    try {
      final res = await dio.get('/user/loans');
      if (res.statusCode == 200) {
        final List<dynamic> loanList = res.data['data'];
        loans.value = loanList.map((loan) => Loan.fromJson(loan)).toList();
      } else {
        Get.snackbar("Ups", res.data['message']);
        return;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> getLoanByID(String id) async {
    isLoading(true);
    try {
      final res = await dio.get('/user/loan/$id');
      if (res.statusCode == 200) {
        loan.value = Loan.fromJson(res.data['data']);
        final List<dynamic> paymentList = res.data['data']['payments'];
        payments.value =
            paymentList.map((payment) => Payment.fromJson(payment)).toList();
      } else {
        Get.snackbar("Ups", res.data['message']);
        Get.offNamed('/home');
        return;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
