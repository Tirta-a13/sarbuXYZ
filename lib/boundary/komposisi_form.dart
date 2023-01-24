import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarbu/boundary/dashboard_page.dart';
import 'package:sarbu/helper/constan.dart';
import 'package:sarbu/helper/widget/text_field.dart';

import '../controller/saribuah_controller.dart';

class KomposisiForm extends StatefulWidget {
  const KomposisiForm({super.key});

  @override
  State<KomposisiForm> createState() => _KomposisiFormState();
}

class _KomposisiFormState extends State<KomposisiForm> {
  SariBuahController sariBuahController = Get.put(SariBuahController());
  final _formKey = GlobalKey<FormState>();
  bool edit = false;
  final _komposisinama = TextEditingController();
  final _jumlah = TextEditingController();
  Satuan _ukuran = Satuan.buah;
  var id;

  void _trySubmitForm() {
    if (_formKey.currentState!.validate()) {
      if (Get.arguments[0] == true) {
        edit = true;
        sariBuahController.updateKomposisi({
          'id': id,
          'nama': _komposisinama.text,
          'jumlah': double.parse(_jumlah.text),
          'ukuran': _ukuran
        });
      } else {
        _formKey.currentState!.save();
        sariBuahController.addKomposisi({
          'nama': _komposisinama.text,
          'jumlah': double.parse(_jumlah.text),
          'ukuran': _ukuran
        });
      }
    }
    Get.offAll(const DashBoardPage());
  }

  @override
  void initState() {
    super.initState();

    if (Get.arguments[0] == true) {
      edit = true;
      Map<String, dynamic> map = Get.arguments[1];
      _komposisinama.text = map['nama'];
      _jumlah.text = map['jumlah'].toString();
      _ukuran = map['ukuran'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: edit
            ? const Text('Edit Komposisi Bahan')
            : const Text('Tambah Komposisi Bahan'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextInputFields(
                    controller: _komposisinama,
                    labelText: 'Bahan Komposisi',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Mohon Lengkapi Data';
                      }
                      return null;
                    },
                    icon: Icons.data_array),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextInputFields(
                        controller: _jumlah,
                        labelText: 'Jumlah Stok',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Mohon Lengkapi Data';
                          }
                          return null;
                        },
                        icon: Icons.data_array,
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    DropdownButton(
                        value: _ukuran,
                        items: Satuan.values.map((e) {
                          return DropdownMenuItem(
                              value: e, child: Text(e.name));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _ukuran = value as Satuan;
                          });
                        }),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: () {
                    _trySubmitForm();
                  },
                  child: const Text('Submit'),
                ),
              ],
            )),
      ),
    );
  }
}
