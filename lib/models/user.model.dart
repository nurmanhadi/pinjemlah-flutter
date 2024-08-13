import 'package:pinjemlah/models/loan.model.dart';

class User {
  int userId;
  String name;
  String email;
  String password;
  String ktpNumber;
  String birthDate;
  String phoneNumber;
  String address;
  double monthlyIncome;
  String accountNumber;
  List<Loan> loans;

  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.password,
    required this.ktpNumber,
    required this.birthDate,
    required this.phoneNumber,
    required this.address,
    required this.monthlyIncome,
    required this.accountNumber,
    required this.loans,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      ktpNumber: json['ktp_number'],
      birthDate: json['birth_date'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      monthlyIncome: (json['monthly_income'] is int)
          ? (json['monthly_income'] as int).toDouble()
          : json['monthly_income'],
      accountNumber: json['account_number'],
      loans: (json['loans'] != null)
          ? (json['loans'] as List)
              .map((payment) => Loan.fromJson(payment))
              .toList()
          : [],
    );
  }
}
