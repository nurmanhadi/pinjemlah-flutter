import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinjemlah/handlers/loan.handler.dart';
import 'package:pinjemlah/utils/color.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if (loan.isLoading.value) {
                return const CircularProgressIndicator(
                  color: CustomColor.primary,
                );
              } else if (loan.loans.isEmpty) {
                return const Text(
                  'Kamu Belum Pinjam!',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: CustomColor.primary),
                );
              } else {
                final filteredCicilanLoans = loan.loans
                    .where((value) => value.status == 'cicilan')
                    .toList();
                final filteredPendingLoans = loan.loans
                    .where((value) => value.status == 'pending')
                    .toList();

                if (filteredCicilanLoans.isNotEmpty) {
                  return const Column(children: [
                    Text(
                      'Pinjamanmu diterima Admin!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: CustomColor.primary),
                    ),
                    Text(
                      'Cek Pinjaman',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: CustomColor.primary),
                    ),
                  ]);
                } else if (filteredPendingLoans.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                      itemCount: filteredPendingLoans.length,
                      shrinkWrap:
                          true, // Needed to prevent ListView from taking infinite height
                      itemBuilder: (context, index) {
                        final value = filteredPendingLoans[index];
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
                } else {
                  return const Column(
                    children: [
                      Text(
                        'Kamu telah menyelesaikan pinjamanmu!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CustomColor.primary),
                      ),
                      Text(
                        'kuy pinjem lagi',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CustomColor.primary),
                      ),
                    ],
                  );
                }
              }
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/loans');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: CustomColor.primary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Border radius
                ),
                elevation: 5,
              ),
              child: const Text("Pinjam"),
            )
          ],
        ),
      ),
    );
  }
}
