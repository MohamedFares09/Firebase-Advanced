import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthServices {
  Future<void> signIn(String email, String password);
  Future<void> signOut();
  Future<void> createAccountWithEmailAndPassword(String email, String password);
}

class FirebaseAuthServices implements AuthServices {
  @override
  Future<void> signIn(String email, String password) async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    }catch(e){
      print(e);
    }
  }

  @override
  Future<void> signOut() async {
    try{
      await FirebaseAuth.instance.signOut();
    }catch(e){
      print(e);
    }
  }

  @override
  Future<void> createAccountWithEmailAndPassword(String email, String password) async {
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    }catch(e){
      print(e);
    }
  }
}