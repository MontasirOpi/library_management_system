import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:library_management_system/app/app_color.dart';
import 'package:library_management_system/app/assets_path.dart';
import 'package:library_management_system/features/auth/model/auth_service.dart';
import 'package:library_management_system/features/common/widgets/build_text_field_widget.dart';
import 'package:library_management_system/features/common/widgets/custom_button.dart';
import 'package:library_management_system/features/homePage/ui/screens/homepage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    try {
      await authService.signInWithEmailPassword(email, password);
      // Navigate to the home page after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      // Handle error (e.g., show a snackbar or dialog)
      print('Login failed: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.themeColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Login',
          style: TextStyle(
            color: AppColors.themeColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SvgPicture.asset(AssetsPath.appLoginSvg, width: 200, height: 200),
              SizedBox(height: 20),
              Text(
                'Login To Your Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              BuildTextField(
                hintText: "Email Id",
                controller: _emailController,
              ),
              SizedBox(height: 20),
              BuildTextField(
                hintText: "Password",
                obscureText: true,
                controller: _passwordController,
              ),
              SizedBox(height: 20),
              CustomButton(text: 'LOGIN', onPressed: login),
            ],
          ),
        ),
      ),
    );
  }
}
