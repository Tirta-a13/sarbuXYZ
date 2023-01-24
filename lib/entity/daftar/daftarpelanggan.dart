import 'package:cloud_firestore/cloud_firestore.dart';

import '../pelanggan.dart';

class DaftarPelanggan {
  late List<Pelanggan> _daftarPelanggan;

  List<Pelanggan> get getdaftarPelanggan => _daftarPelanggan;

  set daftarPelanggan(value) => _daftarPelanggan = List.from(value);

  Pelanggan pelanggan = Pelanggan();

  String collection = 'pelanggan';
  void addPelanggan(Pelanggan pelanggan) {
    FirebaseFirestore.instance.collection(collection).add(pelanggan.toJson());
  }

  void removePelanggan(Pelanggan pelanggan) {
    FirebaseFirestore.instance
        .collection(collection)
        .doc(pelanggan.id)
        .delete();
  }

  Future<void> getAllPelanggan() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection(collection).get();

    var futures = snapshot.docs.map((doc) async => Pelanggan().fromJson(doc));
    var a = await Future.wait(futures);
    daftarPelanggan = a;
  }

  Future<Pelanggan> getPelangganById(String id) async {
    var snapshot =
        await FirebaseFirestore.instance.collection(collection).doc(id).get();
    return Pelanggan().fromMap(snapshot.data() as Map<String, dynamic>);
  }
}
