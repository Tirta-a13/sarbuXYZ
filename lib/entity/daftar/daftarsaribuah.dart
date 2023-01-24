import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sarbu/entity/sari_buah.dart';

class DaftarSaribuah {
  late List<SariBuah> _daftarsaribuah;

  List<SariBuah> get getDaftarsaribuah => _daftarsaribuah;

  SariBuah sariBuah = SariBuah();

  set setDaftarSaribuah(value) => _daftarsaribuah = List.from(value);

  String collection = 'saribuah';
  void addSariBuah(SariBuah sariBuah) {
    FirebaseFirestore.instance.collection(collection).add(sariBuah.toJson());
  }

  void removeSaribuah(SariBuah sariBuah) {
    FirebaseFirestore.instance
        .collection(collection)
        .doc(sariBuah.getid)
        .delete();
  }

  Future<void> getAllSaribuah() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection(collection).get();

    var a = await Future.wait(snapshot.docs.map((e) => SariBuah().fromJson(e)));
    setDaftarSaribuah = a;
  }

  Future<SariBuah> getSariBuahById(String id) async {
    await getAllSaribuah();

    for (var saribuah in _daftarsaribuah) {
      if (saribuah.getid == id) {
        return saribuah;
      }
    }
    throw Exception('Saribuah Tida Ada');
  }
}
