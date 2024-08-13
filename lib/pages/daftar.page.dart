import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pinjemlah/handlers/auth.handler.dart';
import 'package:pinjemlah/utils/color.dart';

class DaftarPage extends StatefulWidget {
  const DaftarPage({super.key});

  @override
  State<DaftarPage> createState() => _DaftarPageState();
}

class _DaftarPageState extends State<DaftarPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthHandlers auth = Get.put(AuthHandlers());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/logo1.svg',
                  height: 150,
                ),
                const SizedBox(height: 50),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: "Nomor Telepon",
                          labelStyle: const TextStyle(
                            color: CustomColor.primary,
                            fontWeight: FontWeight.w500,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[300]!, width: 2.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color:
                                  Color(0xFF5E17EB), // Warna khusus saat fokus
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          prefixIcon: Icon(
                            MdiIcons.phone,
                            color: const Color(0xFF5E17EB),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Nomor Telepon tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
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
                              color:
                                  Color(0xFF5E17EB), // Warna khusus saat fokus
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          prefixIcon: Icon(
                            MdiIcons.lock,
                            color: const Color(0xFF5E17EB),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                      Obx(() => ElevatedButton(
                            onPressed: auth.isLoading.value
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      await auth.userDaftar(
                                        phoneController.text,
                                        passwordController.text,
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
                              elevation: 5, // Shadow elevation
                            ),
                            child: auth.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text("Daftar"),
                          )),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Get.offNamed('/login');
                        },
                        child: const Text(
                          'Sudah punya akun? Login',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
