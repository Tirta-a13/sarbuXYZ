import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  late String _id;
  late String _email;
  late String _nama;
  late String _telepon;
  late String _password;
  late String _role;

  get id => _id;

  set id(value) => _id = value;

  get email => _email;

  set email(value) => _email = value;

  get nama => _nama;

  set nama(value) => _nama = value;

  get telepon => _telepon;

  set telepon(value) => _telepon = value;

  get password => _password;

  set password(value) => _password = value;

  get role => _role;

  set role(value) => _role = value;

  Map<String, dynamic> toJson() => {
        "email": email,
        "nama": nama,
        "telepon": telepon,
        "password": password,
        "role": role,
      };

  fromJson(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    id = snapshot.id;
    email = map['email'];
    nama = map['nama'];
    telepon = map['telepon'];
    password = map['password'];
    role = map['role'];
    return this;
  }

  fromMap(Map<String, dynamic> map) {
    email = map['email'];
    nama = map['nama'];
    telepon = map['telepon'];
    password = map['password'];
    role = map['role'];
    return this;
  }
}
