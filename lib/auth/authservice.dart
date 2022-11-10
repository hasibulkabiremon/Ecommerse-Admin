

import 'package:ec_com_admin_01/db/db_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static User? get currentUser => _auth.currentUser;

  static Future<bool> login(String email, String password)async{
    final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password);
    return DbHelper.isAdmin(credential.user!.uid);
  }
  static Future<void> forgotPassword(String email){
   return _auth.sendPasswordResetEmail(email: email);
  }

  static Future<void> logout() => _auth.signOut();
}