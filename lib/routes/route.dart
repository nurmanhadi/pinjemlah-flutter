import 'package:get/get.dart';
import 'package:pinjemlah/pages/afterLoan.page.dart';
import 'package:pinjemlah/pages/afterLogin.page.dart';
import 'package:pinjemlah/pages/daftar.page.dart';
import 'package:pinjemlah/pages/detaiLoan.page.dart';
import 'package:pinjemlah/pages/home.page.dart';
import 'package:pinjemlah/pages/loan.page.dart';
import 'package:pinjemlah/pages/login.page.dart';
import 'package:pinjemlah/pages/payment.page.dart';
import 'package:pinjemlah/pages/profile.page.dart';
import 'package:pinjemlah/pages/riwayat.page.dart';
import 'package:pinjemlah/pages/splashScreen.page.dart';

final List<GetPage> appRoutes = [
  GetPage(name: '/', page: () => const SplashScreen()),
  GetPage(name: '/login', page: () => const LoginPage()),
  GetPage(name: '/daftar', page: () => const DaftarPage()),
  GetPage(name: '/home', page: () => const HomePage()),
  GetPage(name: '/loans', page: () => const AddLoan()),
  GetPage(name: '/loan', page: () => const DetailLoan()),
  GetPage(name: '/profile', page: () => const UpdateProfile()),
  GetPage(name: '/after-login', page: () => const AfterLogin()),
  GetPage(name: '/riwayat', page: () => const RiwayatPinjaman()),
  GetPage(name: '/payment', page: () => const AddPayment()),
  GetPage(name: '/after-loan', page: () => const AfterLoan()),
];
