import 'package:flutter/material.dart';
import 'package:library_management_system/features/auth/ui/screens/login_screen.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Logout'),
              content: const Text('Are you sure you want to logout?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    ); // Navigate to login screen
                  },
                  child: const Text('Logout'),
                ),
              ],
            );
          },
        );
      },
      borderRadius: BorderRadius.circular(50),
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/images/user.jpg'),
      ),
    );
  }
}
