import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarbu/boundary/dashboard_page.dart';
import 'package:sarbu/boundary/pelanggan_page.dart';
import 'package:sarbu/helper/widget/text_field.dart';

import '../controller/pelanggan_controller.dart';

class PelangganForm extends StatefulWidget {
  const PelangganForm({super.key});

  @override
  State<PelangganForm> createState() => _PelangganFormState();
}

class _PelangganFormState extends State<PelangganForm> {
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _telepon = TextEditingController();
  final TextEditingController _alamat = TextEditingController();
  final TextEditingController _provinsi = TextEditingController();
  final TextEditingController _kota = TextEditingController();
  final TextEditingController _contactperson = TextEditingController();
  final PelangganController pelanggancontroller =
      Get.put(PelangganController());
  final _formKey = GlobalKey<FormState>();
  late String docid;
  var id;

  bool edit = false;
  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      if (Get.arguments[0] == true) {
        Map<String, dynamic> map = {
          "id": id,
          "nama": _nama.text,
          "contactperson": _contactperson.text,
          "telepon": _telepon.text,
          "alamat": _alamat.text,
          "provinsi": _provinsi.text,
          "kota": _kota.text
        };
        pelanggancontroller.updatePelanggan(map);
      } else {
        Map<String, dynamic> map = {
          "nama": _nama.text,
          "contactperson": _contactperson.text,
          "telepon": _telepon.text,
          "alamat": _alamat.text,
          "provinsi": _provinsi.text,
          "kota": _kota.text
        };
        pelanggancontroller.addPelanggan(map);
        Get.offAll(const DashBoardPage());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (Get.arguments[0] == true) {
      edit = true;
      Map<String, dynamic> map = Get.arguments[1];
      _nama.text = map['nama'];
      _contactperson.text = map['contactperson'];
      _telepon.text = map['telepon'];
      _alamat.text = map['alamat'];
      _provinsi.text = map['provinsi'];
      _kota.text = map['kota'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: edit
            ? const Text('Edit Pelanggan')
            : const Text('Tambah Pelanggan'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextInputFields(
                      controller: _nama,
                      labelText: "Nama",
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Lengkapi Data';
                        }
                        return null;
                      },
                      icon: Icons.data_array),
                  const SizedBox(
                    height: 25,
                  ),
                  TextInputFields(
                      controller: _telepon,
                      labelText: "Telepon",
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Lengkapi Data';
                        }
                        return null;
                      },
                      icon: Icons.data_array),
                  const SizedBox(
                    height: 25,
                  ),
                  TextInputFields(
                      controller: _alamat,
                      labelText: "Alamat",
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Lengkapi Data';
                        }
                        return null;
                      },
                      icon: Icons.data_array),
                  const SizedBox(
                    height: 25,
                  ),
                  TextInputFields(
                      controller: _provinsi,
                      labelText: "Provinsi",
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Lengkapi Data';
                        }
                        return null;
                      },
                      icon: Icons.data_array),
                  const SizedBox(
                    height: 25,
                  ),
                  TextInputFields(
                      controller: _kota,
                      labelText: "Kota",
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Lengkapi Data';
                        }
                        return null;
                      },
                      icon: Icons.data_array),
                  const SizedBox(
                    height: 25,
                  ),
                  TextInputFields(
                      controller: _contactperson,
                      labelText: "Contact Person",
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Lengkapi Data';
                        }
                        return null;
                      },
                      icon: Icons.data_array),
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
