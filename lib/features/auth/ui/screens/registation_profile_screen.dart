import 'package:flutter/material.dart';
import 'package:library_management_system/app/app_color.dart';
import 'package:library_management_system/features/auth/ui/screens/registation_screen.dart';
import 'package:library_management_system/features/auth/ui/screens/widgets/build_text_field_widget.dart';
import 'package:library_management_system/features/auth/ui/screens/widgets/custom_button.dart';

class RegistationProfileScreen extends StatefulWidget {
  const RegistationProfileScreen({super.key});

  @override
  State<RegistationProfileScreen> createState() =>
      _RegistationProfileScreenState();
}

class _RegistationProfileScreenState
    extends State<RegistationProfileScreen> {
  final TextEditingController nameController =
      TextEditingController();
  final TextEditingController rollController =
      TextEditingController();
  final TextEditingController emailController =
      TextEditingController();
  final TextEditingController passwordController =
      TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    rollController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registration Form")),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue.shade900,
                      radius: 16,
                      child: const Icon(
                        Icons.camera_alt,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text("Add Photo", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              BuildTextField(
                hintText: "Name",
                controller: nameController,
              ),
              const SizedBox(height: 10),
              BuildTextField(
                hintText: "University Roll No.",
                controller: rollController,
              ),
              const SizedBox(height: 10),
              BuildTextField(
                hintText: "Email Id",
                controller: emailController,
              ),
              const SizedBox(height: 10),
              BuildTextField(
                hintText: "Password",
                controller: passwordController,
              ),
              const SizedBox(height: 10),
              BuildTextField(
                hintText: "Confirm Password",
                controller: confirmPasswordController,
              ),
              const SizedBox(height: 30),
              CustomButton(
                text: 'SAVE & NEXT',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegistationScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
