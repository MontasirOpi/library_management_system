import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    final email = _emailController.text;
    final password = _passwordController.text;
    try{
      await authService.signInWithEmailPassword(email, password);
      // Navigate to the home page after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
    catch(e){
      // Handle error (e.g., show a snackbar or dialog)
      print('Login failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login'), backgroundColor: Colors.white),
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
              BuildTextField(hintText: "Email Id", controller: _emailController),
              SizedBox(height: 20),
              BuildTextField(
                hintText: "Password",
                controller: _passwordController,
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'LOGIN',
                onPressed: login
              ),
            ],
          ),
        ),
      ),
    );
  }
}
