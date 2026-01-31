import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

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
    // WEB IMPLEMENTATION
    if (kIsWeb) {
      await _auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: kIsWeb ? null : 'ai.careertwin.mobile://login-callback',
      );
      return;
    }

    // MOBILE IMPLEMENTATION (Android/iOS)
    /// Web Client ID that you registered with Google Cloud.
    /// This is required for Google Sign In on Android to return an ID Token.
    const webClientId = '868273007836-8rr5si869gfm35ernonalbqu8g653b4d.apps.googleusercontent.com';
    
    final GoogleSignIn googleSignIn = GoogleSignIn(
      serverClientId: webClientId,
    );
    
    try {
        final googleUser = await googleSignIn.signIn();
        final googleAuth = await googleUser?.authentication;

        if (googleAuth == null) {
          // User cancelled or error
          return;
        }

        final accessToken = googleAuth.accessToken;
        final idToken = googleAuth.idToken;

        if (accessToken == null) {
          throw 'No Access Token found.';
        }
        if (idToken == null) {
          throw 'No ID Token found.';
        }

        await _auth.signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: idToken,
          accessToken: accessToken,
        );
    } catch (e) {
        rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
