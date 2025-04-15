import 'package:flutter/material.dart';
import 'package:library_management_system/features/auth/model/auth_service.dart';
import 'package:library_management_system/features/common/widgets/build_text_field_widget.dart';
import 'package:library_management_system/features/common/widgets/custom_button.dart';

class RegistationProfileScreen extends StatefulWidget {
  const RegistationProfileScreen({super.key});

  @override
  State<RegistationProfileScreen> createState() =>
      _RegistationProfileScreenState();
}

class _RegistationProfileScreenState extends State<RegistationProfileScreen> {
  final authService = AuthService();
  final _nameController = TextEditingController();
  final _rollController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void signUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final name = _nameController.text.trim();
    final roll = _rollController.text.trim();

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      await authService.signUpWithEmailPassword(
        email,
        password,
        name: name,
        roll: roll,
      );
      Navigator.pop(context); // You can navigate to login or home
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: $e')),
        );
      }
    }
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
              BuildTextField(hintText: "Name", controller: _nameController),
              const SizedBox(height: 10),
              BuildTextField(
                hintText: "University Roll No.",
                controller: _rollController,
              ),
              const SizedBox(height: 10),
              BuildTextField(
                hintText: "Email Id",
                controller: _emailController,
              ),
              const SizedBox(height: 10),
              BuildTextField(
                hintText: 'Set Password',
                controller: _passwordController,
              ),
              const SizedBox(height: 16),
              BuildTextField(
                hintText: 'Confirm Password',
                controller: _confirmPasswordController,
              ),
              const SizedBox(height: 30),
              CustomButton(text: 'SAVE & NEXT', onPressed: signUp),
            ],
          ),
        ),
      ),
    );
  }
}
