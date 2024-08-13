import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinjemlah/handlers/profile.handler.dart';
import 'package:pinjemlah/utils/color.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _birtDate = TextEditingController();
  final TextEditingController _alamat = TextEditingController();
  final TextEditingController _ktp = TextEditingController();
  final TextEditingController _income = TextEditingController();
  final TextEditingController _rekening = TextEditingController();

  final UserProfile _profile = Get.put(UserProfile());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
        centerTitle: true,
        backgroundColor: CustomColor.primary,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _name,
                        decoration: InputDecoration(
                          labelText: "Nama Lengkap",
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
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Nama tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
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
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _birtDate,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Tanggal Lahir",
                          labelStyle: const TextStyle(
                            color: CustomColor.primary,
                            fontWeight: FontWeight.w500,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
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
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 10.0,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Tanggal lahir tidak boleh kosong';
                          }
                          return null;
                        },
                        onTap: () {
                          _selectDate();
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _alamat,
                        decoration: InputDecoration(
                          labelText: "Alamat Sesuai KTP",
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
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Alamat tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _ktp,
                        decoration: InputDecoration(
                          labelText: "No KTP",
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
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Ktp tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _income,
                        decoration: InputDecoration(
                          labelText: "Pemasukan/bulan",
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
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'pemasukan tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _rekening,
                        decoration: InputDecoration(
                          labelText: "No Rekening",
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
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Rekening tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                      Obx(() => ElevatedButton(
                            onPressed: _profile.isLoading.value
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      await _profile.updateProfile(
                                        _name.text,
                                        _email.text,
                                        _birtDate.text,
                                        _alamat.text,
                                        _ktp.text,
                                        _income.text,
                                        _rekening.text,
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
                            child: _profile.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text("Submit"),
                          )),
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

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1969, 7),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _birtDate.text = picked.toString().split(" ")[0];
      });
    }
  }
}
