import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_advanced/services/firebase_auth.dart';

class AuthController {
  final FirebaseAuthServices _authServices = FirebaseAuthServices();

  /// Signs in a user
  /// Returns null if successful, or an error message string if failed
  Future<String?> signIn(String email, String password) async {
    try {
      await _authServices.signIn(email, password);
      return null; // ✅ نجاح
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return 'The account does not exist for that email.';
        case 'wrong-password':
          return 'The password provided is wrong.';
        case 'invalid-email':
          return 'The email provided is invalid.';
        case 'user-disabled':
          return 'The account is disabled.';
        case 'too-many-requests':
          return 'Too many requests. Please try again later.';
        case 'network-request-failed':
          return 'Network request failed. Please check your internet.';
        default:
          return e.message ?? 'Login failed';
      }
    } catch (e) {
      return e.toString();
    }
  }

  /// Registers a user
  Future<String?> signUp(String email, String password) async {
    try {
      await _authServices.createAccountWithEmailAndPassword(email, password);
      await _authServices.sendEmailVerification();
      return null; // نجاح
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          return 'The password provided is too weak.';
        case 'email-already-in-use':
          return 'The account already exists for that email.';
        default:
          return e.message ?? 'Registration failed';
      }
    } catch (e) {
      return e.toString();
    }
  }

  /// Password reset
  Future<String?> forgetPassword(String email) async {
    try {
      await _authServices.forgetPassword(email);
      return null; // نجاح
    } catch (e) {
      return e.toString();
    }
  }
}
