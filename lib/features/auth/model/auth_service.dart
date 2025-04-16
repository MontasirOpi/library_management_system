import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Sign in with email and password
  Future<AuthResponse> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Sign up with email, password, name and roll
  Future<AuthResponse> signUpWithEmailPassword(
    String email,
    String password, {
    required String name,
    required String roll,
  }) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {'name': name, 'roll': roll},
    );
  }

  // Sign out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // Get current user email
  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }

  // Get current user name
  String? getCurrentUserName() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.userMetadata?['name'];
  }

  // Get current user roll
  String? getCurrentUserRoll() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.userMetadata?['roll'];
  }
}
