import 'package:cloud_firestore/cloud_firestore.dart';

class Pelanggan {
  late String id;
  late String nama;
  late String contactperson;
  late String telepon;
  late String alamat;
  late String provinsi;
  late String kota;

  get getId => id;

  set setId(id) => this.id = id;

  get getNama => nama;

  set setNama(nama) => this.nama = nama;

  get getContactperson => contactperson;

  set setContactperson(contactperson) => this.contactperson = contactperson;

  get getTelepon => telepon;

  set setTelepon(telepon) => this.telepon = telepon;

  get getAlamat => alamat;

  set setAlamat(alamat) => this.alamat = alamat;

  get getProvinsi => provinsi;

  set setProvinsi(provinsi) => this.provinsi = provinsi;

  get getKota => kota;

  set setKota(kota) => this.kota = kota;

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "contactperson": contactperson,
        "telepon": telepon,
        "alamat": alamat,
        "provinsi": provinsi,
        "kota": kota
      };

  Map<String, dynamic> toMap() => {
        "id": id,
        "nama": nama,
        "contactperson": contactperson,
        "telepon": telepon,
        "alamat": alamat,
        "provinsi": provinsi,
        "kota": kota
      };

  fromMap(Map<String, dynamic> map) {
    nama = map['nama'];
    contactperson = map['contactperson'];
    telepon = map['telepon'];
    alamat = map['alamat'];
    provinsi = map['provinsi'];
    kota = map['kota'];
    return this;
  }

  Pelanggan fromJson(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;

    id = snapshot.id;
    nama = map['nama'];
    contactperson = map['contactperson'];
    telepon = map['telepon'];
    alamat = map['alamat'];
    provinsi = map['provinsi'];
    kota = map['kota'];
    return this;
  }
}
