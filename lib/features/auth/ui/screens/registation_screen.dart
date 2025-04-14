import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:library_management_system/app/assets_path.dart';
import 'package:library_management_system/features/auth/ui/screens/widgets/build_text_field_widget.dart';
import 'package:library_management_system/features/auth/ui/screens/widgets/custom_button.dart';

class RegistationScreen extends StatefulWidget {
  const RegistationScreen({super.key});

  @override
  State<RegistationScreen> createState() => _RegistationScreenState();
}

class _RegistationScreenState extends State<RegistationScreen> {
  final TextEditingController passwordController =
      TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration')),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SvgPicture.asset(
                  AssetsPath.appRegSvg,
                  width: 200,
                  height: 200,
                ),
                BuildTextField(
                  hintText: 'Set Password',
                  controller: passwordController,
                ),
                const SizedBox(height: 16),
                BuildTextField(
                  hintText: 'Confirm Password',
                  controller: confirmPasswordController,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Register',
                  onPressed: () {
                    // Handle registration logic here
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
