import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarbu/boundary/komposisi_form.dart';
import 'package:sarbu/controller/saribuah_controller.dart';
import 'package:sarbu/helper/constan.dart';

enum KomposisiEnum {
  edit,
  delete,
}

class KomposisiPage extends StatefulWidget {
  const KomposisiPage({super.key});

  @override
  State<KomposisiPage> createState() => _KomposisiPageState();
}

class _KomposisiPageState extends State<KomposisiPage> {
  SariBuahController sariBuahController = Get.put(SariBuahController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: sariBuahController.getAllKomposisi(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }
              return ListView.builder(
                itemCount:
                    sariBuahController.daftarKomposisi.daftarkomposisi.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Text(sariBuahController
                          .daftarKomposisi.daftarkomposisi[index].nama),
                      subtitle: Column(children: [
                        Row(
                          children: [
                            Text((sariBuahController.daftarKomposisi
                                    .daftarkomposisi[index].jumlah)
                                .toString()),
                            Text(satuanToString(sariBuahController
                                .daftarKomposisi
                                .daftarkomposisi[index]
                                .ukuran)),
                          ],
                        )
                      ]),
                      trailing: SizedBox(
                        width: 100,
                        child: PopupMenuButton<KomposisiEnum>(
                            onSelected: (KomposisiEnum sarbu) {
                              if (sarbu == KomposisiEnum.edit) {
                                Get.to(() => const KomposisiForm(), arguments: [
                                  true,
                                  sariBuahController
                                      .daftarKomposisi.daftarkomposisi[index]
                                      .toMap(),
                                ]);
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
                                              "HAPUS KOMPOSISI?",
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                                sariBuahController
                                                    .removeKomposisi(
                                                        sariBuahController
                                                                .daftarKomposisi
                                                                .daftarkomposisi[
                                                            index]);
                                                Get.back();
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
                                <PopupMenuEntry<KomposisiEnum>>[
                                  const PopupMenuItem(
                                    value: KomposisiEnum.delete,
                                    child: Text("Delete"),
                                  ),
                                  const PopupMenuItem(
                                    value: KomposisiEnum.edit,
                                    child: Text("Edit"),
                                  ),
                                ]),
                      ),
                    ),
                  );
                },
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: ((() {
            Get.to(() => KomposisiForm(), arguments: [false]);
          })),
          child: Icon(Icons.add),
        ));
  }
}
