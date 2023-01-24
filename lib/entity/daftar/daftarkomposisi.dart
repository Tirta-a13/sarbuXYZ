import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sarbu/entity/komposisi.dart';

class DaftarKomposisi {
  late List<Komposisi> _daftarkomposisi;

  List<Komposisi> get daftarkomposisi => _daftarkomposisi;

  set daftarkomposisi(value) => _daftarkomposisi = List.from(value);

  Komposisi komposisi = Komposisi();

  String collection = 'komposisi';

  addKomposisi(Komposisi komposisi) async {
    await FirebaseFirestore.instance
        .collection('komposisi')
        .doc()
        .set(komposisi.toJson());
  }

  removeKomposisi(Komposisi komposisi) {
    FirebaseFirestore.instance
        .collection(collection)
        .doc(komposisi.id)
        .delete();
  }

  Future<void> getAllKomposisi() async {
    QuerySnapshot b =
        await FirebaseFirestore.instance.collection(collection).get();
    var c = b.docs.map((e) => Komposisi().fromJson(e)).toList();
    daftarkomposisi = c;
  }

  Future<Komposisi> byID(String id) async {
    await getAllKomposisi();
    for (var komposisi in _daftarkomposisi) {
      if (komposisi.id == id) {
        return komposisi;
      }
    }
    throw Exception('Komposisi Tida Adak');
  }

  Map komposisifromEntity(data) {
    return Komposisi().fromE(data);
  }
}
