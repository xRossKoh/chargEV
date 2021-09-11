import 'package:charg_ev/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:charg_ev/models/user_info.dart' as model;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<model.UserInfo> get user {
    return _auth.authStateChanges().asyncMap(
      (user) => user == null ? null : DatabaseService(uid: user.uid).userInfo);
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
  Future registerWithEmailAndPassword(
      {String email, String password, String displayName}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      model.UserInfo user = //model prefix is used to identify chargEV's UserInfo from firebase's UserInfo
          model.UserInfo(uid: result.user.uid, displayName: displayName);

      await DatabaseService().addUserInfo(user);

      return user;
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
