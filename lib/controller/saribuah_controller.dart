import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sarbu/boundary/boundary_test.dart';
import 'package:sarbu/entity/daftar/daftarkomposisi.dart';
import 'package:sarbu/entity/daftar/daftarsaribuah.dart';
import 'package:sarbu/entity/daftar/daftarstok.dart';
import 'package:sarbu/entity/komposisi.dart';
import 'package:sarbu/entity/sari_buah.dart';
import 'package:sarbu/entity/sertifikat.dart';
import 'package:sarbu/entity/stok_box_saribuah.dart';

//fill parameter later
class SariBuahController extends GetxController {
  DaftarSaribuah daftarSaribuah = DaftarSaribuah();
  DaftarKomposisi daftarKomposisi = DaftarKomposisi();
  DaftarStok daftarStok = DaftarStok();

  void addSaribuah(Map<String, dynamic> dataItem) {
    // daftarSaribuah.sariBuah.nama = dataItem['nama'];
    // daftarSaribuah.sariBuah.isibersih = dataItem['isibersih'];
    // daftarSaribuah.sariBuah.daftarkomposisi = dataItem['daftarkomposisi'];
    print(dataItem);
    daftarSaribuah.sariBuah.fromMap(dataItem);
    daftarSaribuah.addSariBuah(daftarSaribuah.sariBuah);
    //kasih boundary message
  }

  void removeSaribuah(SariBuah sariBuah) {
    daftarSaribuah.removeSaribuah(sariBuah);
    //kasih boundary message
  }

  Future<void> getAllSariBuahList() async {
    await daftarSaribuah.getAllSaribuah();
  }

  Future<void> getAllStokBoxSariBuahList() async {
    await daftarStok.getAllStokSaribuah();
  }

  addStok(Map<String, dynamic> dataItem) {
    daftarStok.stokBoxSariBuah.isi = dataItem['isi'];
    daftarStok.stokBoxSariBuah.jumlah = dataItem['jumlah'];
    daftarStok.stokBoxSariBuah.saribuah = dataItem['saribuah'];
    daftarStok.stokBoxSariBuah.tglproduksi = dataItem['tglproduksi'];
    daftarStok.stokBoxSariBuah.tglkadaluarsa = dataItem['tglkadaluarsa'];
    daftarStok.addStok(daftarStok.stokBoxSariBuah);
  }

  void removeStok(StokBoxSariBuah stokBoxSariBuah) {
    daftarStok.removeStokSaribuah(stokBoxSariBuah);
  }

  void addKomposisi(Map<String, dynamic> dataItem) {
    daftarKomposisi.komposisi.nama = dataItem['nama'];
    daftarKomposisi.komposisi.jumlah = dataItem['jumlah'];
    daftarKomposisi.komposisi.ukuran = dataItem['ukuran'];
    daftarKomposisi.addKomposisi(daftarKomposisi.komposisi);
  }

  void updateKomposisi(Map<String, dynamic> dataItem) {
    //soon TM
    daftarKomposisi.addKomposisi(daftarKomposisi.komposisi);
  }

  Future getAllKomposisi() async {
    await daftarKomposisi.getAllKomposisi();
  }

  void removeKomposisi(Komposisi komposisi) {
    daftarKomposisi.removeKomposisi(komposisi);
  }
}
