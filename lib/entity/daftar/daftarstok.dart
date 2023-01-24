import 'package:cloud_firestore/cloud_firestore.dart';

import '../stok_box_saribuah.dart';

class DaftarStok {
  late List<StokBoxSariBuah> _daftarstok;
  List<StokBoxSariBuah> get getdaftarstok => _daftarstok;

  set setdaftarstok(value) => _daftarstok = List.from(value);

  StokBoxSariBuah stokBoxSariBuah = StokBoxSariBuah();

  String collection = 'stok';

  void addStok(StokBoxSariBuah stok) {
    FirebaseFirestore.instance
        .collection(collection)
        .add(stokBoxSariBuah.toJson());
  }

  void removeStokSaribuah(StokBoxSariBuah stok) {
    FirebaseFirestore.instance.collection(collection).doc(stok.id).delete();
  }

  Future<void> getAllStokSaribuah() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection(collection).get();

    var a = await Future.wait(snapshot.docs
        .map((doc) async => await StokBoxSariBuah().fromJson(doc))
        .toList());

    setdaftarstok = a;
  }

  Future<StokBoxSariBuah> getStokBoxSariBuahById(String id) async {
    await getAllStokSaribuah();
    for (var stok in _daftarstok) {
      if (stok.id == id) {
        return stok;
      }
    }
    throw Exception('Stok Tida Ada');
  }
}
