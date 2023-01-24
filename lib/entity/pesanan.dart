import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sarbu/entity/daftar/daftarpelanggan.dart';
import 'package:sarbu/entity/daftar/daftarstok.dart';
import 'package:sarbu/entity/pelanggan.dart';
import 'package:sarbu/entity/stok_box_saribuah.dart';
import 'package:sarbu/helper/constan.dart';

class Pesanan {
  late String id;
  late Pelanggan pelanggan;
  late StokBoxSariBuah stokBoxSariBuah;
  late DateTime tanggal;
  late int jumlah;
  late int harga;
  late Status status;

  get getId => id;

  set setId(id) => this.id = id;

  Pelanggan get getPelanggan => pelanggan;

  set setPelanggan(pelanggan) => this.pelanggan = pelanggan;

  StokBoxSariBuah get getStokBoxSariBuah => stokBoxSariBuah;

  set setStokBoxSariBuah(stokBoxSariBuah) =>
      this.stokBoxSariBuah = stokBoxSariBuah;

  get getTanggal => tanggal;

  set setTanggal(tanggal) => this.tanggal = tanggal;

  get getJumlah => jumlah;

  set setJumlah(jumlah) => this.jumlah = jumlah;

  get getHarga => harga;

  set setHarga(harga) => this.harga = harga;

  get getStatus => status;

  set setStatus(status) => this.status = status;

  Map<String, dynamic> toJson() => {
        'pelanggan': pelanggan.getId,
        'stok': stokBoxSariBuah.id,
        'tanggal': tanggal,
        'jumlah': jumlah,
        'harga': harga,
        'status': statusToString(status)
      };
  Future<Pesanan> fromJson(DocumentSnapshot doc) async {
    Map<String, dynamic> map = doc.data() as Map<String, dynamic>;

    pelanggan = await DaftarPelanggan().getPelangganById(map['pelanggan']);
    stokBoxSariBuah = await DaftarStok().getStokBoxSariBuahById(map['stok']);
    tanggal = (map['tanggal'] as Timestamp).toDate();
    jumlah = map['jumlah'];
    harga = map['harga'];
    status = stringToStatus(map['status']);
    return this;
  }
}
