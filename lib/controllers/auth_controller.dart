import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_advanced/services/firebase_auth.dart';

class AuthController {
  final FirebaseAuthServices _authServices = FirebaseAuthServices();

  /// Signs in a user and ensures their email is verified.
  /// Returns null if successful, or an error message string if failed.
  Future<String?> signIn(String email, String password) async {
    try {
      await _authServices.signIn(email, password);
      
      if (!FirebaseAuth.instance.currentUser!.emailVerified) {
        return 'Email Not Verified';
      }
      
      return null; // Indicates success
    } catch (e) {
      return e.toString();
    }
  }

  /// Registers a user and sends an email verification.
  /// Returns null if successful, or an error message string if failed.
  Future<String?> signUp(String email, String password) async {
    try {
      await _authServices.createAccountWithEmailAndPassword(email, password);
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      
      return null; // Indicates success
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.toString();
    } catch (e) {
      return e.toString();
    }
  }

  /// Sends a password reset email.
  /// Returns null if successful, or an error message string if failed.
  Future<String?> forgetPassword(String email) async {
    try {
      await _authServices.forgetPassword(email);
      return null; // Indicates success
    } catch (e) {
      return e.toString();
    }
  }
}
