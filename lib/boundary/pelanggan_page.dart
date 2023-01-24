import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarbu/boundary/pelanggan_form.dart';
import 'package:sarbu/boundary/pesanan_form.dart';
import 'package:sarbu/controller/pelanggan_controller.dart';

enum PelangganM { edit, delete, pesan }

class PelangganPage extends StatefulWidget {
  const PelangganPage({super.key});

  @override
  State<PelangganPage> createState() => _PelangganPageState();
}

class _PelangganPageState extends State<PelangganPage> {
  PelangganController pelangganController = Get.put(PelangganController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: pelangganController.getAllPelangganList(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: pelangganController
                        .daftarPelanggan.getdaftarPelanggan.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(pelangganController.daftarPelanggan
                              .getdaftarPelanggan[index].getNama),
                          trailing: SizedBox(
                              width: 100,
                              child: PopupMenuButton<PelangganM>(
                                  onSelected: (PelangganM menu) {
                                    setState(() {
                                      if (menu == PelangganM.edit) {
                                        Get.to(() => const PelangganForm(),
                                            arguments: [
                                              true,
                                              pelangganController
                                                  .daftarPelanggan
                                                  .getdaftarPelanggan[index]
                                                  .toMap()
                                            ]);
                                      } else if (menu == PelangganM.pesan) {
                                        Get.to(() => const PesananForm(),
                                            arguments: [
                                              true,
                                              pelangganController
                                                  .daftarPelanggan
                                                  .getdaftarPelanggan[index]
                                                  .toMap()
                                            ]);
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
                                                      "HAPUS Pelanggan?",
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
                                                      child:
                                                          const Text("BATAL"),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary:
                                                                  Colors.red),
                                                      child:
                                                          const Text("HAPUS"),
                                                    ),
                                                  ],
                                                ));
                                      }
                                    });
                                  },
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry<PelangganM>>[
                                        const PopupMenuItem(
                                          value: PelangganM.pesan,
                                          child: Text("Buat Pesanan"),
                                        ),
                                        const PopupMenuItem(
                                          value: PelangganM.edit,
                                          child: Text("Edit"),
                                        ),
                                        const PopupMenuItem(
                                          value: PelangganM.delete,
                                          child: Text("Delete"),
                                        )
                                      ])),
                        ),
                      );
                    });
              }
              return const Text('Something Went Wrong');
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: ((() {
            Get.to(() => const PelangganForm(), arguments: [false]);
          })),
          child: const Icon(Icons.add),
        ));
  }
}
