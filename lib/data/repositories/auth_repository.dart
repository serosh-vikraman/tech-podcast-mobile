import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(FirebaseAuth.instance);
}

class AuthRepository {
  final FirebaseAuth _auth;

  AuthRepository(this._auth);

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<void> signInWithOtp({required String phone}) async {
    // TODO: Implement Firebase Phone Auth
    throw UnimplementedError('Firebase Phone Auth not implemented yet');
  }

  Future<void> verifyOtp({
    required String phone,
    required String token,
  }) async {
     // TODO: Implement Firebase Phone Auth Verification
     throw UnimplementedError('Firebase Phone Auth Verification not implemented yet');
  }

  Future<void> signInWithGoogle() async {
    // WEB IMPLEMENTATION
    if (kIsWeb) {
      // Create a new provider
      GoogleAuthProvider authProvider = GoogleAuthProvider();
      // Once signed in, return the UserCredential
      await _auth.signInWithPopup(authProvider);
      return;
    }

    // MOBILE IMPLEMENTATION (Android/iOS)
    // We do NOT need serverVerifiedId for Firebase Auth with GoogleSignIn usually, 
    // unless we are doing backend verification manually. Firebase handles it.
    // However, google_sign_in needs standard setup.

    final GoogleSignIn googleSignIn = GoogleSignIn();
    
    try {
        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

        if (googleUser == null) {
          // User cancelled
          return;
        }

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase with the Google credential
        await _auth.signInWithCredential(credential);

    } catch (e) {
        debugPrint("Google Sign In Error: $e");
        rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    if (!kIsWeb) {
      await GoogleSignIn().signOut();
    }
  }
}
