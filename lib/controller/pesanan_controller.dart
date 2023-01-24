import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sarbu/entity/daftar/daftarpesanan.dart';
import 'package:sarbu/entity/pesanan.dart';

class PesananController extends GetxController {
  DaftarPesanan daftarPesanan = DaftarPesanan();

  void addPesanan(Map<String, dynamic> dataItem) {
    daftarPesanan.pesanan.setPelanggan = dataItem['pelanggan'];
    daftarPesanan.pesanan.setStokBoxSariBuah = dataItem['stok'];
    daftarPesanan.pesanan.setJumlah = dataItem['jumlah'];
    daftarPesanan.pesanan.setTanggal = dataItem['tanggal'];
    daftarPesanan.pesanan.setHarga = dataItem['harga'];

    daftarPesanan.addPesanan(daftarPesanan.pesanan);
    //kasih boundary message
  }

  void removePesanan(Pesanan pesanan) {
    daftarPesanan.removePesanan(pesanan);
    //kasih boundary message
  }

  Future<void> getALLPesananList() async {
    await daftarPesanan.getAllPesanan();
  }
}
