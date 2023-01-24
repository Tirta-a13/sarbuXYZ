import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../user.dart';

class DaftarUser {
  late List<User> _daftarUser;

  List<User> get daftarUser => _daftarUser;

  set daftarUser(value) => _daftarUser = List.from(value);

  User user = User();

  String collection = 'users';
  void addUser(User user) {
    FirebaseFirestore.instance.collection(collection).add(User().toJson());
    auth.FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: user.email, password: user.password)
        .then((value) => value);
  }

  void removeUser(User user) {
    FirebaseFirestore.instance.collection(collection).doc(user.id).delete();
  }

  Future<void> getAllUser() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection(collection).get();

    var c = snapshot.docs.map((doc) => User().fromJson(doc)).toList();
    daftarUser = c;
  }

  // Map userfromEntity(User user) {
  //   return user.fromJson();
  // }
}
