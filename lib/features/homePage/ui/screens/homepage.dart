import 'package:flutter/material.dart';
import 'package:library_management_system/app/app_color.dart';
import 'package:library_management_system/features/auth/ui/screens/logout.dart';
import 'package:library_management_system/features/homePage/model/build_section.dart';
import 'package:library_management_system/features/homePage/model/search.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Library Management System',
          style: TextStyle(color: AppColors.themeColor, fontSize: 20),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu, color: AppColors.themeColor),
          onPressed: () {},
        ),
        actionsIconTheme: const IconThemeData(color: AppColors.themeColor),
        actions: [
          Padding(padding: EdgeInsets.only(right: 16.0), child: Logout()),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Search(),
            ),
            const SizedBox(height: 20),
            // Sections
            Expanded(
              child: ListView(
                children: [
                  BuildSection(context: context, category: "Maths"),
                  BuildSection(context: context, category: "Physics"),
                  BuildSection(context: context, category: "Chemistry"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
