import 'package:pinjemlah/models/payment.model.dart';

class Loan {
  int loanID;
  int userID;
  String loanType;
  double loanAmount;
  double lnterestRate;
  int loanTerm;
  String status;
  String applicationDate;
  String approvalDate;
  String disbursementDate;
  String loanSlug;
  List<Payment> payments;

  Loan({
    required this.loanID,
    required this.userID,
    required this.loanType,
    required this.loanAmount,
    required this.lnterestRate,
    required this.loanTerm,
    required this.status,
    required this.applicationDate,
    required this.approvalDate,
    required this.disbursementDate,
    required this.loanSlug,
    required this.payments,
  });

  factory Loan.fromJson(Map<String, dynamic> json) {
    return Loan(
      loanID: json['loan_id'],
      userID: json['user_id'],
      loanType: json['loan_type'],
      loanAmount: (json['loan_amount'] is int)
          ? (json['loan_amount'] as int).toDouble()
          : json['loan_amount'],
      lnterestRate: (json['interest_rate'] is int)
          ? (json['interest_rate'] as int).toDouble()
          : json['interest_rate'],
      loanTerm: json['loan_term'],
      status: json['status'],
      applicationDate: json['application_date'],
      approvalDate: json['approval_date'],
      disbursementDate: json['disbursement_date'],
      loanSlug: json['loan_slug'],
      payments: (json['payments'] != null)
          ? (json['payments'] as List)
              .map((payment) => Payment.fromJson(payment))
              .toList()
          : [],
    );
  }
}
