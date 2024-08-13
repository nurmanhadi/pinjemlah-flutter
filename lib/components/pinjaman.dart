import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinjemlah/handlers/loan.handler.dart';
import 'package:pinjemlah/utils/color.dart';

class Pinjaman extends StatefulWidget {
  const Pinjaman({super.key});

  @override
  State<Pinjaman> createState() => _PinjamanState();
}

class _PinjamanState extends State<Pinjaman> {
  final LoanHandlers loan = Get.put(LoanHandlers());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loan.getLoans();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: Colors.white,
        backgroundColor: CustomColor.primary,
        title: const Center(
          child: Text(
            "Daftar Pinjamanmu",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (loan.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: CustomColor.primary,
            ),
          );
        } else if (loan.loans.isEmpty) {
          return const Center(
              child: Text(
            'Kamu belum Pinjam :(',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: CustomColor.primary),
          ));
        } else {
          final filteredLoans =
              loan.loans.where((value) => value.status == 'cicilan').toList();
          if (filteredLoans.isEmpty) {
            return const Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tidak ada Cicilan!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: CustomColor.primary),
                ),
                Text(
                  'tunggu admin terima Pinjamannu',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: CustomColor.primary),
                ),
              ],
            ));
          }
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: filteredLoans.length,
              itemBuilder: (context, index) {
                final value = filteredLoans[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Rp.${value.loanSlug}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        '${value.loanTerm.toString()} Bulan',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      trailing: Text(
                        'Status: ${value.status}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: value.status == 'lunas'
                              ? Colors.green
                              : value.status == 'cicilan'
                                  ? Colors.amber
                                  : Colors.red,
                        ),
                      ),
                      tileColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.3),
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      onTap: () {
                        Get.toNamed('/loan',
                            arguments: value.loanID.toString());
                      },
                    ),
                    const SizedBox(height: 5),
                  ],
                );
              },
            ),
          );
        }
      }),
    );
  }
}
