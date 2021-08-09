import 'package:firebase_auth/firebase_auth.dart';

class UserInfo {
  String uid;
  String displayName;

  UserInfo({this.uid, this.displayName});

  UserInfo.fromFirebaseUser(User user) {
    this.uid = user.uid;
    this.displayName = user.displayName;
  }
}
