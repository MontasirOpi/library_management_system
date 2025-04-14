import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:library_management_system/app/app_color.dart';
import 'package:library_management_system/app/assets_path.dart';

class LoginRegScreen extends StatelessWidget {
  const LoginRegScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login/Register')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetsPath.appLogoSvg,
                width: 200,
                height: 200,
              ),
              Text(
                'Welcome ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'A collection of materials, books, and resources for students and faculty members.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to login screen
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(300, 50), // Set width and height
                  backgroundColor: AppColors.themeColor,
                ),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white,
                   fontSize: 18,),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(300, 50),
                  backgroundColor:
                      AppColors.themeColor, // Set width and height
                ),
                child: Text(
                  'New Register',
                  style: TextStyle(color: Colors.white,
                  fontSize: 18, // Set font size),
                ),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
