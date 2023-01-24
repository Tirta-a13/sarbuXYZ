import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sarbu/boundary/stok_form.dart';

import '../controller/saribuah_controller.dart';

enum Stok { edit, delete }

class StokPage extends StatefulWidget {
  const StokPage({super.key});

  @override
  State<StokPage> createState() => _StokPageState();
}

class _StokPageState extends State<StokPage> {
  final SariBuahController saribuahcontroller = Get.put(SariBuahController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: saribuahcontroller.getAllStokBoxSariBuahList(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }
              return ListView.builder(
                  itemCount: saribuahcontroller.daftarStok.getdaftarstok.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                          title: Text((saribuahcontroller.daftarStok
                                  .getdaftarstok[index].saribuah.nama)
                              .toString()),
                          subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Text('Tanggal Produksi :'),
                                          Text(DateFormat('dd/MM/yyyy').format(
                                              saribuahcontroller
                                                  .daftarStok
                                                  .getdaftarstok[index]
                                                  .tglproduksi))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text('Tanggal Kadaluarsa :'),
                                          Text(DateFormat('dd/MM/yyyy').format(
                                              saribuahcontroller
                                                  .daftarStok
                                                  .getdaftarstok[index]
                                                  .tglkadaluarsa))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text('Isi :'),
                                          Text((saribuahcontroller.daftarStok
                                                  .getdaftarstok[index].isi)
                                              .toString())
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text('Jumlah :'),
                                          Text((saribuahcontroller.daftarStok
                                              .getdaftarstok[index].jumlah
                                              .toString()))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                          trailing: SizedBox(
                              width: 100,
                              child: PopupMenuButton<Stok>(
                                  onSelected: (Stok stok) {
                                    if (stok == Stok.edit) {
                                      // Get.to(() => StokForm(), arguments: [
                                      //   true,
                                      //   documentSnapshot.id,
                                      //   documentSnapshot['isiBersih']
                                      // ]);
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                titlePadding:
                                                    const EdgeInsets.all(0),
                                                title: Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  color: Colors.red,
                                                  child: const Center(
                                                      child: Text(
                                                    "HAPUS SARI BUAH?",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.grey),
                                                    child: const Text("BATAL"),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      saribuahcontroller
                                                          .daftarStok
                                                          .removeStokSaribuah(
                                                              saribuahcontroller
                                                                      .daftarStok
                                                                      .getdaftarstok[
                                                                  index]);
                                                      Get.back();
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.red),
                                                    child: const Text("HAPUS"),
                                                  ),
                                                ],
                                              ));
                                    }
                                  },
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry<Stok>>[
                                        const PopupMenuItem(
                                          value: Stok.edit,
                                          child: Text("Edit"),
                                        ),
                                        const PopupMenuItem(
                                          value: Stok.delete,
                                          child: Text("Delete"),
                                        ),
                                      ]))),
                    );
                  });
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: ((() {
            Get.to(() => const StokForm(), arguments: [false]);
          })),
          child: const Icon(Icons.add),
        ));
  }
}
