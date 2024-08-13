import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pinjemlah/handlers/auth.handler.dart';
import 'package:pinjemlah/handlers/profile.handler.dart';
import 'package:pinjemlah/utils/color.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthHandlers auth = Get.put(AuthHandlers());
  final UserProfile _profile = Get.put(UserProfile());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _profile.userProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: CustomColor.primary,
        title: const Text(
          "Profil",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if (_profile.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: CustomColor.primary,
                  ),
                );
              } else {
                return Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      children: [
                        TableRow(children: [
                          const Text(
                            "Nama",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ": ${_profile.user.value?.name ?? 'Tidak ada'}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ]),
                        const TableRow(children: [
                          SizedBox(height: 8),
                          SizedBox(height: 8),
                        ]),
                        TableRow(children: [
                          const Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ": ${_profile.user.value?.email ?? 'Tidak ada'}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ]),
                        const TableRow(children: [
                          SizedBox(height: 8),
                          SizedBox(height: 8),
                        ]),
                        TableRow(children: [
                          const Text(
                            "Tanggal Lahir",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ": ${_profile.user.value?.birthDate ?? 'Tidak ada'}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ]),
                        const TableRow(children: [
                          SizedBox(height: 8),
                          SizedBox(height: 8),
                        ]),
                        TableRow(children: [
                          const Text(
                            "Alamat",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ": ${_profile.user.value?.address ?? 'Tidak ada'}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ]),
                        const TableRow(children: [
                          SizedBox(height: 8),
                          SizedBox(height: 8),
                        ]),
                        TableRow(children: [
                          const Text(
                            "No HP",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ": ${_profile.user.value?.phoneNumber ?? 'Tidak ada'}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ]),
                        const TableRow(children: [
                          SizedBox(height: 8),
                          SizedBox(height: 8),
                        ]),
                        TableRow(children: [
                          const Text(
                            "Penghasilan",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ": ${_profile.user.value?.monthlyIncome.toString() ?? 'Tidak ada'}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ]),
                        const TableRow(children: [
                          SizedBox(height: 8),
                          SizedBox(height: 8),
                        ]),
                        TableRow(children: [
                          const Text(
                            "No KTP",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ": ${_profile.user.value?.ktpNumber ?? 'Tidak ada'}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ]),
                        const TableRow(children: [
                          SizedBox(height: 8),
                          SizedBox(height: 8),
                        ]),
                        TableRow(children: [
                          const Text(
                            "No Rekening",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ": ${_profile.user.value?.accountNumber ?? 'Tidak ada'}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ]),
                      ],
                    ),
                  ),
                );
              }
            }),
            const SizedBox(height: 5),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.3),
                  width: 1,
                ),
              ),
              elevation: 5,
              child: ListTile(
                leading: Icon(MdiIcons.history),
                title: const Text(
                  "RiwayatPinjaman",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                textColor: CustomColor.primary,
                iconColor: CustomColor.primary,
                onTap: () {
                  Get.toNamed('/riwayat');
                },
              ),
            ),
            const Spacer(),
            Obx(
              () => ElevatedButton.icon(
                onPressed: auth.isLoading.value
                    ? null
                    : () async {
                        bool confirmLogout = await _showLogoutDialog();
                        if (confirmLogout) {
                          await auth.userLogout();
                        }
                      },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Border radius
                  ),
                  elevation: 5,
                ),
                icon: const Icon(Icons.logout, color: Colors.white),
                label: auth.isLoading.value
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text("Logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _showLogoutDialog() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text("Apakah Anda yakin ingin keluar?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              style: ElevatedButton.styleFrom(
                iconColor: Colors.red,
              ),
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}
