import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_proj/domain/user.dart';

class AuthService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<LocalUser?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _fAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return LocalUser.fromFirebase(user!);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<LocalUser?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return LocalUser.fromFirebase(user!);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future logOut() async{
    await _fAuth.signOut();
  }

  Stream<LocalUser> get currentUser{
    return _fAuth.authStateChanges().map((User? user) =>  LocalUser.fromFirebase(user!));
  }

}
