import 'package:flutter/material.dart';
import 'package:library_management_system/app/app_color.dart';
import 'package:library_management_system/features/auth/model/auth_service.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final authService = AuthService();

  String? name;
  String? email;
  String? roll;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() {
    setState(() {
      name = authService.getCurrentUserName() ?? 'No name found';
      email = authService.getCurrentUserEmail() ?? 'No email found';
      roll = authService.getCurrentUserRoll() ?? 'No roll found';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.deepPurple),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: AppColors.themeColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/user.jpg'),
                ),
                const SizedBox(height: 20),
                Text(
                  name ?? '',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'University Roll: ${roll ?? ''}',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Text(
                  email ?? '',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Navigate to edit profile screen
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Edit Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
