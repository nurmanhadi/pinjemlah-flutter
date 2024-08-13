import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pinjemlah/handlers/payment.handler.dart';
import 'package:pinjemlah/utils/color.dart';

import '../handlers/loan.handler.dart';

class AddPayment extends StatefulWidget {
  const AddPayment({super.key});

  @override
  State<AddPayment> createState() => _AddPaymentState();
}

class _AddPaymentState extends State<AddPayment> {
  late String loanID;
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final UserPayment _py = Get.put(UserPayment());
  final box = GetStorage();
  final LoanHandlers _loan = Get.put(LoanHandlers());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loanID = Get.arguments;
      _loan.getLoanByID(loanID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const Text(
                            'PEMBAYARAN',
                            style: TextStyle(
                              color: CustomColor.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Obx(() {
                            final loan = _loan.loan.value;
                            if (loan != null) {
                              final loanAmount = double.parse(loan.loanSlug);
                              final loanTerm = loan.loanTerm;
                              final monthlyPayment =
                                  (loanAmount / loanTerm) + (loanAmount * 0.05);
                              return Text(
                                "Pinjamanmu bulan ini Rp.${monthlyPayment.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  color: CustomColor.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            } else {
                              return const Text(
                                "Data pinjaman tidak tersedia",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                          }),
                          const SizedBox(height: 20),
                          const Text(
                            "Bunga 5% ya :)",
                            style: TextStyle(
                              color: CustomColor.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _amountController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: "Jumlah Bayaran ",
                              labelStyle: const TextStyle(
                                color: CustomColor.primary,
                                fontWeight: FontWeight.w500,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(
                                      0xFF5E17EB), // Warna khusus saat fokus
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              prefixIcon: Icon(
                                MdiIcons.cash,
                                color: const Color(0xFF5E17EB),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Jumlah bayaran tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'No Rekening: ${box.read('rekening')}',
                                style: const TextStyle(
                                  color: CustomColor.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(() => ElevatedButton(
                        onPressed: _py.isLoading.value
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  await _py.addPayment(
                                      _amountController.text, loanID);
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: CustomColor.primary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // Border radius
                          ),
                          elevation: 5, // Shadow elevation
                        ),
                        child: _py.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text('Submit'),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
