import 'package:get/get.dart';

import '../entity/daftar/daftarpelanggan.dart';
import '../entity/pelanggan.dart';

class PelangganController extends GetxController {
  DaftarPelanggan daftarPelanggan = DaftarPelanggan();

  void addPelanggan(Map<String, dynamic> dataItem) {
    daftarPelanggan.pelanggan.fromMap(dataItem);

    daftarPelanggan.addPelanggan(daftarPelanggan.pelanggan);
  }

  void updatePelanggan(Map<String, dynamic> dataItem) {
    daftarPelanggan.pelanggan.fromMap(dataItem);
  }

  void removePelanggan(Pelanggan pelanggan) {
    daftarPelanggan.removePelanggan(pelanggan);
  }

  Future<void> getAllPelangganList() async {
    await daftarPelanggan.getAllPelanggan();
  }
}
