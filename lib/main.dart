import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 👈 Required for orientation control
import 'package:library_management_system/app/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 👈 Required for async calls before runApp

  // Lock orientation to portraitUp only
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Initialize Supabase
  await supabase.Supabase.initialize(
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtmYXNiZGJscWVhc2NwdXdvenduIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ2NDQ5NzIsImV4cCI6MjA2MDIyMDk3Mn0.lAU27rfWc7GD7sLXyPdo1M3NU6RPA45Gr-KYE1pD6Vo",
    url: "https://kfasbdblqeascpuwozwn.supabase.co",
  );

  runApp(const MyApp());
}
