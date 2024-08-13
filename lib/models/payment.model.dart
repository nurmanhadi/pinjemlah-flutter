class Payment {
  int paymentID;
  int loanID;
  String paymentDate;
  double paymentAmount;
  String paymentStatus;

  Payment({
    required this.paymentID,
    required this.loanID,
    required this.paymentDate,
    required this.paymentAmount,
    required this.paymentStatus,
  });
  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      paymentID: json['payment_id'],
      loanID: json['loan_id'],
      paymentDate: json['payment_date'],
      paymentAmount: (json['payment_amount'] is int)
          ? (json['payment_amount'] as int).toDouble()
          : json['payment_amount'],
      paymentStatus: json['payment_status'],
    );
  }
}
