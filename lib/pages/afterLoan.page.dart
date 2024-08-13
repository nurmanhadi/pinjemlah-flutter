import 'package:flutter/material.dart';
import 'package:pinjemlah/utils/color.dart';

class AfterLoan extends StatefulWidget {
  const AfterLoan({super.key});

  @override
  State<AfterLoan> createState() => _AfterLoanState();
}

class _AfterLoanState extends State<AfterLoan> {
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
