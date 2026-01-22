import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(Supabase.instance.client.auth);
}

class AuthRepository {
  final GoTrueClient _auth;

  AuthRepository(this._auth);

  Stream<AuthState> get authStateChanges => _auth.onAuthStateChange;
  Session? get currentSession => _auth.currentSession;

  Future<void> signInWithOtp({required String phone}) async {
    await _auth.signInWithOtp(
      phone: phone,
      shouldCreateUser: true,
    );
  }

  Future<AuthResponse> verifyOtp({
    required String phone,
    required String token,
  }) async {
    return await _auth.verifyOTP(
      phone: phone,
      token: token,
      type: OtpType.sms,
    );
  }

  Future<void> signInWithGoogle() async {
    // Native Google Sign In flow requires setup in Google Cloud Console
    // For now, we use the web-based flow as a fallback or starting point
    await _auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'com.careerCast.techPodcast://login-callback',
    );
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
