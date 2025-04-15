import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: Text(
                'Library Management System',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurple,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.indigo),
            title: const Text('My Profile'),
            onTap: () {
              // Navigate to Profile Page
            },
          ),
          ListTile(
            leading: const Icon(Icons.menu_book, color: Colors.indigo),
            title: const Text('Issued Books'),
            onTap: () {
              // Navigate to Issued Books Page
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications, color: Colors.indigo),
            title: const Text('Notifications'),
            onTap: () {
              // Navigate to Notifications
            },
          ),
          ListTile(
            leading: const Icon(Icons.help, color: Colors.indigo),
            title: const Text('Help'),
            onTap: () {
              // Navigate to Help page
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.indigo),
            title: const Text('Settings'),
            onTap: () {
              // Navigate to Settings page
            },
          ),
        ],
      ),
    );
  }
}
