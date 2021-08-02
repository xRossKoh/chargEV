import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get user {
    return _auth.authStateChanges();
  }

  //sign in anon
  Future signInAnon() async {
    UserCredential res = await _auth.signInAnonymously();
    print('done');
    return res.user;
  }

  // sign in with email & password
  Future signInWithEmailAndPassword({String email, String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print('done');
      User user = result.user;

      return user;
    } catch (e) {
      print(e.toString());
      return (null);
    }
  }

  // register w email & pw
  Future registerWithEmailAndPassword({String email, String password}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return result.user;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: $e');
      return null;
    }
  }

  // sign out
  Future signOut() async {
    return await _auth.signOut();
  }
}
