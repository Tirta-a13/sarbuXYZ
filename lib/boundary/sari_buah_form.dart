import 'dart:ffi';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarbu/entity/komposisi.dart';
import 'package:sarbu/helper/widget/text_field.dart';

import '../controller/saribuah_controller.dart';

class SariBuahForm extends StatefulWidget {
  const SariBuahForm({super.key});

  @override
  State<SariBuahForm> createState() => _SariBuahFormState();
}

class _SariBuahFormState extends State<SariBuahForm> {
  final Map<Komposisi, num> _ingredients = {};
  SariBuahController sariBuahController = Get.put(SariBuahController());
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _jumlah = TextEditingController();
  final TextEditingController _isi = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var pilih;
  var quantity;

  void _trySubmitForm() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> map1 = {
        'nama': _nama.text,
        'isibersih': int.parse(_isi.text),
        'daftarkomposisi': _ingredients
      };
      sariBuahController.addSaribuah(map1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Sari Buah'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              pilih = null;
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Tambah Komposisi"),
                    content: SizedBox(
                      height: 100,
                      child: Column(
                        children: [
                          FutureBuilder(
                              future: sariBuahController.getAllKomposisi(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Text("Loading.....");
                                }
                                return DropdownButton(
                                  iconSize: 50,
                                  value: pilih,
                                  isDense: true,
                                  hint: const Text('Pilih Produk Sari Buah'),
                                  items: sariBuahController
                                      .daftarKomposisi.daftarkomposisi
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
                          Expanded(
                              child: TextInputFields(
                                  controller: _jumlah,
                                  labelText: 'jumlah',
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Mohon Lengkapi Data';
                                    }
                                    return null;
                                  },
                                  icon: Icons.numbers))
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text("Add"),
                        onPressed: () {
                          // Add the new ingredient to the list
                          setState(() {
                            _ingredients
                                .addAll({pilih: double.parse(_jumlah.text)});
                            pilih = null;
                            Get.back();
                            // _ingredients.add(newIngredientController.text);
                            // _ingredientQuantities[
                            //     newIngredientController.text] = 0;
                          });
                          Get.off(SariBuahForm());
                        },
                      ),
                      TextButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextInputFields(
                controller: _nama,
                labelText: 'Nama Sari Buah',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Mohon Masukan Data';
                  }
                  return null;
                },
                icon: Icons.data_array),
            const SizedBox(height: 20),
            TextInputFields(
                controller: _isi,
                labelText: 'Isi bersih',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Mohon Masukan Data';
                  }
                  return null;
                },
                icon: Icons.data_array),
            Text('Tambah Komposisi dengan menekan tombol +'),
            Expanded(
              child: ListView.builder(
                  key: const Key('List'),
                  itemCount: _ingredients.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(_ingredients.keys.elementAt(index).nama),
                        leading: TextButton(
                          child: const Text("-"),
                          onPressed: () {
                            setState(() {
                              _ingredients.removeWhere((key, value) =>
                                  key == _ingredients.keys.elementAt(index));
                            });
                          },
                        ),
                        trailing: Text(
                            _ingredients.values.elementAt(index).toString()));
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _trySubmitForm();
        },
        child: const Icon(Icons.add_shopping_cart),
      ),
    );
  }
}
