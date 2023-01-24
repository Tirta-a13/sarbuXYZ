import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sarbu/entity/pesanan.dart';

class DaftarPesanan {
  late List<Pesanan> _daftarpesanan;

  List<Pesanan> get getdaftarpesanan => _daftarpesanan;

  set setdaftarpesanan(value) => _daftarpesanan = List.from(value);

  Pesanan pesanan = Pesanan();

  String collection = 'pesanan';

  void addPesanan(Pesanan pesanan) {
    FirebaseFirestore.instance.collection(collection).add(pesanan.toJson());
  }

  void removePesanan(Pesanan pesanan) {
    FirebaseFirestore.instance.collection(collection).doc(pesanan.id).delete();
  }

  Future<void> getAllPesanan() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection(collection).get();
    var a = await Future.wait(snapshot.docs
        .map((doc) async => await Pesanan().fromJson(doc))
        .toList());
    setdaftarpesanan = a;
  }
}
