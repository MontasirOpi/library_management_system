/*
Auth gate - this will continuously listen for auth state change

unauthenticated -> Login page
authenticated -> profile page
*/
import 'package:flutter/material.dart';
import 'package:library_management_system/features/auth/ui/screens/login_screen.dart';
import 'package:library_management_system/features/homePage/ui/screens/homepage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      //listen to the auth state changes
      stream: Supabase.instance.client.auth.onAuthStateChange,
      //build appropriate page based on auth state
      builder: (context, snapshot) {
        //loating...
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        //check if there valid session currently
        final session = snapshot.hasData? snapshot.data!.session: null;
        if (session != null) {
          //user is authenticated
          return const HomePage();
        } else {
          //user is not authenticated
          return const LoginScreen();
        }
      },
    );
  }
}
