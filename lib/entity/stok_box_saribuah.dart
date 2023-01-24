import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sarbu/entity/daftar/daftarsaribuah.dart';
import 'package:sarbu/entity/sari_buah.dart';

class StokBoxSariBuah {
  late String _id;
  late int _isi;
  late int _jumlah;

  late SariBuah _saribuah;
  late DateTime _tglproduksi;
  late DateTime _tglkadaluarsa;

  get id => _id;

  set id(value) => _id = value;

  get isi => _isi;

  set isi(value) => _isi = value;

  get jumlah => _jumlah;

  set jumlah(value) => _jumlah = value;

  SariBuah get saribuah => _saribuah;

  set saribuah(value) => _saribuah = value;

  get tglproduksi => _tglproduksi;

  set tglproduksi(value) => _tglproduksi = value;

  get tglkadaluarsa => _tglkadaluarsa;

  set tglkadaluarsa(value) => _tglkadaluarsa = value;

  Map<String, dynamic> toJson() => {
        'isi': isi,
        'jumlah': jumlah,
        'saribuah': saribuah.getid,
        'tglproduksi': tglproduksi,
        'tglkadaluarsa': tglkadaluarsa
      };

  Future<StokBoxSariBuah> fromJson(DocumentSnapshot snapshot) async {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    id = snapshot.id;
    isi = map['isi'];
    jumlah = map['jumlah'];
    saribuah = await DaftarSaribuah().getSariBuahById(map['saribuah']);
    tglproduksi = (map['tglproduksi'] as Timestamp).toDate();
    tglkadaluarsa = (map['tglkadaluarsa'] as Timestamp).toDate();

    return this;
  }

  // StokBoxSariBuah fromMap(Map<String, dynamic> map) {
  //   return StokBoxSariBuah(
  //       isi: map['isi'],
  //       jumlah: map['jumlah'],
  //       saribuah: map['saribuah'],
  //       tglproduksi: map['tglproduksi'],
  //       tglkadaluarsa: map['tglkadaluarsa']);
  // }
}
