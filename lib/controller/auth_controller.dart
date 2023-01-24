import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  void check(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Get.toNamed('/login');
      } else {
        Get.toNamed('/dashboard');
      }
    });
  }

  login(String email, String password) {
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }
  }

  logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    check(context);
  }
}
