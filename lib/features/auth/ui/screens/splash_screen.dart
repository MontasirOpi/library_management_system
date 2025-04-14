import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:library_management_system/app/assets_path.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
              placeholderBuilder:
                  (context) => CircularProgressIndicator(),
              semanticsLabel: 'App Logo',
            ),

            Text(
              'Library Management System',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
           
          ],
        ),
      ),
    );
  }
}
