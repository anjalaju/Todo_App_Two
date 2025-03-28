import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _usercollection = FirebaseFirestore.instance
      .collection('users');

  //SignIn

  Future<UserCredential?> registerUser(UserModel user) async {
    UserCredential userData = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: user.email.toString(),
          password: user.password.toString(),
        );
    if (userData != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userData.user!.uid)
          .set({
            'uid': userData.user!.uid,
            'email': userData.user!.email,
            'name': user.name,
            'CreatedAt': user.createdAt,
            'status': user.status,
          });
      return userData;
    }
  }

  //logIn

  Future<DocumentSnapshot?> loginUser(UserModel user) async {
    DocumentSnapshot? snap;
    SharedPreferences _pref = await SharedPreferences.getInstance();

    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: user.email.toString(),
      password: user.password.toString(),
    );

    String? token = await userCredential.user!.getIdToken();

    if (userCredential != null) {
      snap = await _usercollection.doc(userCredential.user!.uid).get();

      await _pref.setString('token', token!);
      await _pref.setString('name', snap['name']);
      await _pref.setString('email', snap['email']);
      return snap;
    }
  }

  //logOut
  Future<void> logOut() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.clear();
    await _auth.signOut();
  }

  Future<bool> isloggedin() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String? _token = await _pref.getString('token');
    if (_token == null) {
      return false;
    } else {
      return true;
    }
  }
}
