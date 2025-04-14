import 'package:supabase_flutter/supabase_flutter.dart';
class AuthService {
  final SupabaseClient _supabase=Supabase.instance.client;

  //sign in with email and password
Future<AuthResponse> signInWithEmailPassword(String email, String password) async {
  final response = await _supabase.auth.signInWithPassword(
    email: email,
    password: password,
  );
  //sing up with email and password

  //sign out

  //get user email
}