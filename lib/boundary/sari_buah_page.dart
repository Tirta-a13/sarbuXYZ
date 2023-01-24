import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarbu/boundary/dashboard_page.dart';
import 'package:sarbu/boundary/sari_buah_form.dart';
import 'package:sarbu/controller/saribuah_controller.dart';

enum Sarbu { edit, delete, komposisi, sertifikat }

class SariBuahPage extends StatefulWidget {
  const SariBuahPage({super.key});

  @override
  State<SariBuahPage> createState() => _SariBuahPageState();
}

class _SariBuahPageState extends State<SariBuahPage> {
  SariBuahController sariBuahController = Get.put(SariBuahController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: sariBuahController.getAllSariBuahList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return ListView.builder(
              itemCount:
                  sariBuahController.daftarSaribuah.getDaftarsaribuah.length,
              itemBuilder: (BuildContext context, int indexSari) {
                return Card(
                  child: ListTile(
                    title: Text((sariBuahController
                            .daftarSaribuah.getDaftarsaribuah[indexSari].nama)
                        .toString()),
                    subtitle: Column(children: [
                      const Text('Komposisi'),
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: sariBuahController
                            .daftarSaribuah
                            .getDaftarsaribuah[indexSari]
                            .daftarkomposisi
                            .length,
                        itemBuilder: (BuildContext context, int indexK) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text((sariBuahController
                                      .daftarSaribuah
                                      .getDaftarsaribuah[indexSari]
                                      .daftarkomposisi
                                      .keys
                                      .elementAt(indexK)
                                      .nama)
                                  .toString()),
                              Text((sariBuahController
                                      .daftarSaribuah
                                      .getDaftarsaribuah[indexSari]
                                      .daftarkomposisi
                                      .values
                                      .elementAt(indexK))
                                  .toString()),
                              Text((sariBuahController
                                      .daftarSaribuah
                                      .getDaftarsaribuah[indexSari]
                                      .daftarkomposisi
                                      .keys
                                      .elementAt(indexK)
                                      .ukuran)
                                  .toString()),
                            ],
                          );
                        },
                      ),
                    ]),
                    trailing: SizedBox(
                      width: 100,
                      child: PopupMenuButton<Sarbu>(
                          onSelected: (Sarbu sarbu) {
                            if (sarbu == Sarbu.komposisi) {
                              // Get.to(() => komposisiForm(),
                              //     arguments: [documentSnapshot.id]);
                            } else if (sarbu == Sarbu.edit) {
                              // Get.to(() => BarangForm(), arguments: [
                              //   true,
                              //   documentSnapshot.id,
                              // ]);

                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        titlePadding: const EdgeInsets.all(0),
                                        title: Container(
                                          padding: const EdgeInsets.all(5),
                                          color: Colors.red,
                                          child: const Center(
                                              child: Text(
                                            "HAPUS SARI BUAH?",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.grey),
                                            child: const Text("BATAL"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              sariBuahController.removeSaribuah(
                                                  sariBuahController
                                                          .daftarSaribuah
                                                          .getDaftarsaribuah[
                                                      indexSari]);
                                              Get.off(DashBoardPage());
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.red),
                                            child: const Text("HAPUS"),
                                          ),
                                        ],
                                      ));
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<Sarbu>>[
                                const PopupMenuItem(
                                  value: Sarbu.delete,
                                  child: Text("Delete"),
                                ),
                              ]),
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ((() {
            Get.to(() => const SariBuahForm(), arguments: [false]);
          })),
          child: const Icon(Icons.add),
        ));
  }
}
