import 'package:get/get.dart';

import '../entity/daftar/daftaruser.dart';
import '../entity/user.dart';

class UserController extends GetxController {
  DaftarUser daftarUser = DaftarUser();

  void addUser(Map<String, dynamic> dataItem) {
    daftarUser.user.email = dataItem['email'];
    daftarUser.user.nama = dataItem['nama'];
    daftarUser.user.telepon = dataItem['telepon'];
    daftarUser.user.password = dataItem['password'];
    daftarUser.user.role = dataItem['role'];
    daftarUser.addUser(daftarUser.user);
  }

  void removeUser(User user) {
    daftarUser.removeUser(user);
  }

  Future viewUserList() async {
    await daftarUser.getAllUser();

    return List.from(daftarUser.daftarUser);
  }
}
