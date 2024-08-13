import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pinjemlah/handlers/loan.handler.dart';
import 'package:pinjemlah/utils/color.dart';

class AddLoan extends StatefulWidget {
  const AddLoan({super.key});

  @override
  State<AddLoan> createState() => _AddLoanState();
}

class _AddLoanState extends State<AddLoan> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController amount = TextEditingController();
  final TextEditingController term = TextEditingController();
  final LoanHandlers loan = Get.put(LoanHandlers());
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    var name = box.read('rekening');
    if (name == null) {
      Future.delayed(const Duration(seconds: 2), () {
        Get.snackbar("Ups", "Kamu belum update profile");
        Get.offNamed('/profile');
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tambah Pinjaman",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: CustomColor.primary,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: amount,
                      decoration: InputDecoration(
                        labelText: "Jumlah Pinjaman",
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
                            color: Color(0xFF5E17EB), // Warna khusus saat fokus
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
                          return "Jumlah pinjaman tidak boleh kosong";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: term,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Jumlah Bulan ",
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
                            color: Color(0xFF5E17EB), // Warna khusus saat fokus
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        prefixIcon: Icon(
                          MdiIcons.calendarMonth,
                          color: const Color(0xFF5E17EB),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Jumlah bulan tidak boleh kosong";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Tenor cuma 5% kok",
                      style: TextStyle(color: CustomColor.primary),
                    ),
                    const SizedBox(height: 40),
                    Obx(() => ElevatedButton(
                        onPressed: loan.isLoading.value
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  await loan.addLoan(
                                    amount.text,
                                    term.text,
                                  );
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
                          elevation: 5,
                        ),
                        child: loan.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text("Submit"))),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
