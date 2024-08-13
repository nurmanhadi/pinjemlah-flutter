import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pinjemlah/handlers/loan.handler.dart';
import 'package:pinjemlah/utils/color.dart';

class DetailLoan extends StatefulWidget {
  const DetailLoan({super.key});

  @override
  State<DetailLoan> createState() => _DetailLoanState();
}

class _DetailLoanState extends State<DetailLoan> {
  final LoanHandlers _loan = Get.put(LoanHandlers());
  late String loanID;

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
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: CustomColor.primary,
        title: const Text(
          "Detail Pinjamanmu",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () {
            if (_loan.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(
                  color: CustomColor.primary,
                ),
              );
            } else {
              final loanStatus = _loan.loan.value?.status ?? '';
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Table(
                    border: TableBorder.all(color: Colors.grey),
                    columnWidths: const {
                      0: FlexColumnWidth(3),
                      1: FlexColumnWidth(7),
                    },
                    children: [
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Tipe',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Text(_loan.loan.value?.loanType ?? "tidak ada"),
                        ),
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Jumlah',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'Rp.${_loan.loan.value?.loanSlug ?? "tidak ada"}'),
                        ),
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Tenor',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              '${_loan.loan.value?.loanTerm.toString() ?? "tidak ada"} Bulan'),
                        ),
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Status',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _loan.loan.value?.status ?? "tidak ada",
                            style: TextStyle(
                              color: loanStatus == 'lunas'
                                  ? Colors.green
                                  : loanStatus == 'cicilan'
                                      ? Colors.amber
                                      : Colors.red,
                            ),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Tanggal Pinjam',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              _loan.loan.value?.applicationDate ?? "tidak ada"),
                        ),
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Batas Pinjaman',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              '${_loan.loan.value?.approvalDate} s/d ${_loan.loan.value?.disbursementDate}'),
                        ),
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Sisa Pinjaman',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'Rp.${_loan.loan.value?.loanAmount.toString() ?? "tidak ada"}'),
                        ),
                      ]),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (loanStatus != 'pending') ...[
                    const Text(
                      "Daftar Pembayaran",
                      style: TextStyle(
                        color: CustomColor.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Obx(() {
                        if (_loan.payments.isEmpty) {
                          return const Center(
                              child: Text("Tidak ada pembayaran",
                                  style:
                                      TextStyle(color: CustomColor.primary)));
                        } else {
                          return ListView.builder(
                            itemCount: _loan.payments.length,
                            itemBuilder: (context, index) {
                              final e = _loan.payments[index];
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                        'Rp.${e.paymentAmount.toString()}'),
                                    subtitle: Text('Tanggal: ${e.paymentDate}'),
                                    trailing: Text(
                                      'Status: ${e.paymentStatus}',
                                      style: TextStyle(
                                        color: e.paymentStatus == 'lunas'
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                ],
                              );
                            },
                          );
                        }
                      }),
                    ),
                  ],
                  if (loanStatus == 'cicilan')
                    Card(
                      color: CustomColor.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      elevation: 5,
                      child: ListTile(
                        leading: Icon(MdiIcons.creditCardOutline),
                        title: const Text(
                          "Bayar Pinjaman",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        textColor: Colors.white,
                        iconColor: Colors.white,
                        onTap: () {
                          Get.toNamed('/payment', arguments: loanID);
                        },
                      ),
                    ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
