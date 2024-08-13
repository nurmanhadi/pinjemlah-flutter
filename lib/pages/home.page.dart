import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pinjemlah/components/home.dart';
import 'package:pinjemlah/components/pinjaman.dart';
import 'package:pinjemlah/utils/color.dart';

import '../components/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [const Home(), const Pinjaman(), const Profile()];
    return Scaffold(
      body: widgets[index],
      bottomNavigationBar: ConvexAppBar(
          items: [
            TabItem(icon: MdiIcons.home, title: 'Home'),
            TabItem(icon: MdiIcons.cashMultiple, title: 'Pinjaman'),
            TabItem(icon: MdiIcons.accountCircle, title: 'Profile'),
          ],
          color: Colors.white,
          backgroundColor: CustomColor.primary,
          initialActiveIndex: 0,
          onTap: (int i) => setState(() {
                index = i;
              })),
    );
  }
}
