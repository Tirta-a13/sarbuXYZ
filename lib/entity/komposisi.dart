import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sarbu/helper/constan.dart';

class Komposisi {
  late String _id;
  late String _nama;
  late double _jumlah;
  late Satuan _ukuran;
  get ukuran => _ukuran;

  set ukuran(value) => _ukuran = value;

  get id => _id;

  set id(value) => _id = value;

  get nama => _nama;

  set nama(value) => _nama = value;

  get jumlah => _jumlah;

  set jumlah(value) => _jumlah = value;

  factory Komposisi() => Komposisi._();

  Komposisi._();

  Map<String, dynamic> toJson() =>
      {"nama": nama, "jumlah": jumlah, "ukuran": satuanToString(ukuran)};

  Komposisi fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    _id = doc.id;
    _nama = data['nama'];
    _jumlah = data['jumlah'];
    _ukuran = stringToSatuan(data['ukuran']);
    return this;
  }

  Map<String, dynamic> fromE(Komposisi komposisi) => {
        "id": komposisi.id,
        "nama": komposisi.nama,
        "jumlah": komposisi.jumlah,
        "ukuran": komposisi.ukuran
      };

  Map<String, dynamic> toMap() =>
      {"id": id, "nama": nama, "jumlah": jumlah, "ukuran": ukuran};

  fromMap(Map data) {
    nama = data['nama'];
    jumlah = data['jumlah'];
    ukuran = data['ukuran'];
  }
}
