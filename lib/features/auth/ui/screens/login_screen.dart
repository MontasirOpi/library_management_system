import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:library_management_system/app/assets_path.dart';
import 'package:library_management_system/features/auth/ui/screens/widgets/build_text_field_widget.dart';
import 'package:library_management_system/features/auth/ui/screens/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController =
      TextEditingController();
  final TextEditingController passwordController =
      TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SvgPicture.asset(
                AssetsPath.appLoginSvg,
                width: 200,
                height: 200,
              ),
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
                controller: emailController,
              ),
              SizedBox(height: 20),
              BuildTextField(
                hintText: "Password",
                controller: passwordController,
              ),
              SizedBox(height: 20),
              CustomButton(text: 'LOGIN', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
