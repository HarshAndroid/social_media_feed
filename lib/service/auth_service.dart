import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dialog_x.dart';

class AuthService {
  // for authentication
  static FirebaseAuth get auth => FirebaseAuth.instance;

  // for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<bool> register(
      final String email, final String password) async {
    try {
      // final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      log('User logged in successfully: ${auth.currentUser}');
      return true;
    } catch (e) {
      log('Error logging in user: $e');
      DialogX.error(msg: e is FirebaseAuthException ? e.message : null);
      return false;
    }
  }

  static Future<bool> login(final String email, final String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      log('User logged in successfully: ${credential.user}');
      return credential.user != null;
    } catch (e) {
      log('Error logging in user: $e');
      DialogX.error(msg: e is FirebaseException ? e.message : null);
      return false;
    }
  }

  static Future<bool> logout({bool showDialog = true}) async {
    try {
      // await account.deleteSessions();
      // await Pref.clearDB();
      await auth.signOut();

      log('User logged out successfully');
      return true;
    } catch (e) {
      log('Error logging out user: $e');
      if (showDialog) {
        DialogX.error(msg: e is FirebaseAuthException ? e.message : null);
      }
      return false;
    }
  }
}
