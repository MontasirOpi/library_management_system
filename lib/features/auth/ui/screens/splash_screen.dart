import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:library_management_system/app/assets_path.dart';
import 'package:library_management_system/features/auth/ui/screens/login_reg_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginRegScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              AssetsPath.appLogoSvg,
              width: 200,
              height: 200,
              placeholderBuilder: (context) => const CircularProgressIndicator(),
              semanticsLabel: 'App Logo',
            ),
            const SizedBox(height: 20),
            const Text(
              'Library Management System',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
