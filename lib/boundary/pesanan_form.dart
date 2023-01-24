import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sarbu/controller/saribuah_controller.dart';

import '../controller/pesanan_controller.dart';

class PesananForm extends StatefulWidget {
  const PesananForm({super.key});

  @override
  State<PesananForm> createState() => _PesananFormState();
}

class _PesananFormState extends State<PesananForm> {
  String _pilihanPelanggan = "",
      _pilihanStatus = "- PILIH -",
      _pilihanBarang = "";
  final TextEditingController _tanggal = TextEditingController();
  final TextEditingController _jumlah = TextEditingController();
  final TextEditingController _harga = TextEditingController();
  final PesananController pesanancontroller = Get.put(PesananController());
  final SariBuahController saribuahController = Get.put(SariBuahController());
  final List<String> _status = ["- PILIH -", "Draft", "Pembayaran", "Selesai"];
  final _formKey = GlobalKey<FormState>();
  late DateTime date;
  var pilihanSaribuah;
  var liter = [];
  Map<String, dynamic> map = Get.arguments[1];

  // var pelangganN = Get.arguments[2];
  // var pelangganP = Get.arguments[1];
  bool edit = false;

  String user = "user";

  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    // if (isValid == true) {
    // pesanancontroller.daftarPesanan.pesanan.setPelanggan=;
    // pesanancontroller.daftarPesanan.pesanan.setStokBoxSariBuah =
    //     pilihanSaribuah;
    // pesanancontroller.daftarPesanan.pesanan.setJumlah = int.parse(_jumlah.text);
    // pesanancontroller.daftarPesanan.pesanan.setStatus = _pilihanStatus;
    // pesanancontroller.daftarPesanan.pesanan.setHarga = int.parse(_harga.text);
    // pesanancontroller.daftarPesanan.pesanan.setTanggal = date;
    // pesanancontroller.daftarPesanan.setPesanan =
    //     pesanancontroller.daftarPesanan.pesanan;

    pesanancontroller.daftarPesanan
        .addPesanan(pesanancontroller.daftarPesanan.pesanan);
    // }
  }

  @override
  void initState() {
    super.initState();
    if (Get.arguments[0] == true) {
      edit = true;
    }
  }

  // Future<void> _loadObjects() async {
  //   var objectFutures =
  //       await saribuahController.daftarStok.getAllStokSaribuah();
  //   for (var objectFuture in objectFutures) {
  //     saribuahController.daftarStok.stokBoxSariBuah = await objectFuture;
  //     saribuahController.daftarStok
  //         .tambahstok(saribuahController.daftarStok.getStok!);
  //   }
  //   print(saribuahController.daftarStok.getDaftarstok);

  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Buat Pesanan'),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder(
          future: saribuahController.getAllSariBuahList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(title: Text(map['nama']))),
                    Card(
                      child: DropdownButton(
                        iconSize: 50,
                        value: pilihanSaribuah,
                        isDense: true,
                        hint: const Text('Pilih Produk Sari Buah'),
                        items: saribuahController
                            .daftarSaribuah.getDaftarsaribuah
                            .map((value) {
                          return DropdownMenuItem(
                            value: value.getid,
                            child: Text(value.nama),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            pilihanSaribuah = value;
                          });
                        },
                      ),
                    ),
                    TextFormField(
                      controller: _tanggal,
                      readOnly: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Masukan Data';
                        }
                        return null;
                      },
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(3000))
                            .then((value) {
                          _tanggal.text =
                              DateFormat('dd/MM/yyyy').format(value!);
                          date = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Tanggal',
                        icon: Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Icon(Icons.calendar_month),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _jumlah,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Masukan Data';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Jumlah',
                        icon: Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Icon(Icons.numbers),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _harga,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Masukan Data';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Total Harga',
                        icon: Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Icon(Icons.monetization_on),
                        ),
                      ),
                    ),
                    DropdownButtonFormField(
                      decoration: const InputDecoration(
                          icon: Padding(
                              padding: EdgeInsets.only(top: 15.0),
                              child: Icon(Icons.category_outlined))),
                      isExpanded: true,
                      items: _status.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _pilihanStatus = value.toString();
                        });
                      },
                      value: _pilihanStatus,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                          onPressed: () => _trySubmitForm(),
                          child: Text('Simpan')),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
