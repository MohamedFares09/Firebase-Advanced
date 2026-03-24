import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthServices {
  Future<void> signIn(String email, String password);
  Future<void> signOut();
  Future<void> createAccountWithEmailAndPassword(String email, String password);
  Future<void> sendEmailVerification();
  Future<bool> isEmailVerified();
  Future<void> forgetPassword(String email);
}

class FirebaseAuthServices implements AuthServices {
  @override
  Future<void> signIn(String email, String password) async {
    // ✅ هنا نحذف try/catch عشان AuthController يمسك الأخطاء
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> createAccountWithEmailAndPassword(
      String email, String password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> sendEmailVerification() async {
    await FirebaseAuth.instance.currentUser?.sendEmailVerification();
  }

  @override
  Future<bool> isEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();
    return FirebaseAuth.instance.currentUser?.emailVerified ?? false;
  }

  @override
  Future<void> forgetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}