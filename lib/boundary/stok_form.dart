import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sarbu/helper/widget/text_field.dart';

import '../controller/saribuah_controller.dart';

class StokForm extends StatefulWidget {
  const StokForm({super.key});

  @override
  State<StokForm> createState() => _StokFormState();
}

class _StokFormState extends State<StokForm> {
  final TextEditingController _tanggalProduksi = TextEditingController();
  final TextEditingController _tanggalKadaluarsa = TextEditingController();
  final TextEditingController _isiJumlah = TextEditingController();
  final TextEditingController _totalStok = TextEditingController();
  final SariBuahController saribuahController = Get.put(SariBuahController());
  final _formKey = GlobalKey<FormState>();
  DateTime? tanggalKadaluarasa = DateTime.now();
  DateTime? tanggalProduksi = DateTime.now();
  var pilih;

  void _trySubmitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Map<String, dynamic> map1 = {
        'isi': int.parse(_isiJumlah.text),
        'jumlah': int.parse(_totalStok.text),
        'saribuah': saribuahController.daftarSaribuah.sariBuah,
        'tglproduksi': tanggalProduksi,
        'tglkadaluarsa': tanggalKadaluarasa
      };
      saribuahController.addStok(map1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Tambah Sari Buah'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                      future:
                          saribuahController.daftarSaribuah.getAllSaribuah(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text("Loading.....");
                        }
                        return DropdownButton(
                          iconSize: 50,
                          value: pilih,
                          isDense: true,
                          hint: const Text('Pilih Produk Sari Buah'),
                          items: saribuahController
                              .daftarSaribuah.getDaftarsaribuah
                              .map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value.nama),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              pilih = value;
                            });
                          },
                        );
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInputFields(
                      controller: _tanggalProduksi,
                      labelText: 'Tanggal Produksi',
                      ontap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(3000))
                            .then((value) {
                          _tanggalProduksi.text =
                              DateFormat('dd/MM/yyyy').format(value!);
                          tanggalProduksi = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Masukan Data';
                        }
                        return null;
                      },
                      icon: Icons.numbers),
                  const SizedBox(height: 20),
                  TextInputFields(
                      controller: _tanggalKadaluarsa,
                      labelText: 'Tanggal Kadaluarsa',
                      ontap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(3000))
                            .then((value) {
                          _tanggalProduksi.text =
                              DateFormat('dd/MM/yyyy').format(value!);
                          tanggalProduksi = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Masukan Data';
                        }
                        return null;
                      },
                      icon: Icons.numbers),
                  const SizedBox(height: 20),
                  TextInputFields(
                      controller: _isiJumlah,
                      labelText: 'Isi Bersih',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Masukan Data';
                        }
                        return null;
                      },
                      icon: Icons.numbers),
                  const SizedBox(height: 20),
                  TextInputFields(
                      controller: _totalStok,
                      labelText: 'Jumlah Stok',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Masukan Data';
                        }
                        return null;
                      },
                      icon: Icons.numbers),
                  const SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        onPressed: () => _trySubmitForm(),
                        child: const Text('Simpan')),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
