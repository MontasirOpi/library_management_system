import 'package:flutter/material.dart';
import 'package:library_management_system/features/homePage/ui/screens/issued_books.dart';
import 'package:library_management_system/features/homePage/ui/screens/notifications_page.dart';
import 'package:library_management_system/features/my%20profile/my_profile.dart';
import 'package:library_management_system/app/app_color.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Text(
                  'Library App',
                  style: TextStyle(
                    color: AppColors.themeColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.indigo),
              title: const Text('My Profile'),
              onTap: () {
                // Navigate to My Profile Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyProfile()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.menu_book, color: Colors.indigo),
              title: const Text('Issued Books'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const IssuedBooks()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications, color: Colors.indigo),
              title: const Text('Notifications'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NotificationsPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
