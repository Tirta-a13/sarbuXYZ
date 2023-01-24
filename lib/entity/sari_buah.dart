import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sarbu/entity/daftar/daftarkomposisi.dart';
import 'package:sarbu/entity/komposisi.dart';

class SariBuah {
  late String _id;
  late String _nama;
  late int _isibersih;
  late Map<Komposisi, num> _daftarkomposisi;

  get getid => _id;

  set id(String value) => _id = value;

  get nama => _nama;

  set nama(value) => _nama = value;

  get isibersih => _isibersih;

  set isibersih(value) => _isibersih = value;

  Map<Komposisi, num> get daftarkomposisi => _daftarkomposisi;

  set daftarkomposisi(value) => _daftarkomposisi = value;

  Map<String, dynamic> toJson() {
    return {
      "nama": nama,
      "isibersih": isibersih,
      "daftarkomposisi": _daftarkomposisi.map((key, value) {
        return MapEntry(key.id, value);
      })
    };
  }

  SariBuah fromMap(Map<String, dynamic> data) {
    _nama = data['nama'];
    _isibersih = data['isibersih'];
    _daftarkomposisi = data['daftarkomposisi'];
    return this;
  }

  Future<SariBuah> fromJson(DocumentSnapshot doc) async {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    _id = doc.id;
    _nama = data['nama'];
    _isibersih = data['isibersih'];
    _daftarkomposisi = {};
    Map<String, dynamic> data2 =
        data['daftarkomposisi'] as Map<String, dynamic>;

    List<Future<void>> futures = [];
    data2.forEach((key, value) {
      futures.add(DaftarKomposisi().byID(key).then((kom) {
        _daftarkomposisi[kom] = value;
      }));
    });
    await Future.wait(futures);
    return this;
  }
}
