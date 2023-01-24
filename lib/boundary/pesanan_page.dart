import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sarbu/boundary/pesanan_form.dart';
import 'package:sarbu/controller/pesanan_controller.dart';
import 'package:sarbu/helper/constan.dart';

enum Pesanan {
  edit,
  delete,
}

class PesananPage extends StatefulWidget {
  const PesananPage({super.key});

  @override
  State<PesananPage> createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  @override
  Widget build(BuildContext context) {
    PesananController pesananController = Get.put(PesananController());
    return Scaffold(
      body: FutureBuilder(
          future: pesananController.getALLPesananList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount:
                      pesananController.daftarPesanan.getdaftarpesanan.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(pesananController.daftarPesanan
                            .getdaftarpesanan[index].getPelanggan.getNama),
                        subtitle: Column(
                          children: [
                            Text(DateFormat('dd/MM/yyyy').format(
                                pesananController.daftarPesanan
                                    .getdaftarpesanan[index].getTanggal)),
                            Text(statusToString(pesananController.daftarPesanan
                                    .getdaftarpesanan[index].getStatus)
                                .toUpperCase())
                          ],
                        ),
                        trailing: SizedBox(
                            width: 100,
                            child: PopupMenuButton<Pesanan>(
                                onSelected: (Pesanan menu) {
                                  setState(() {
                                    if (menu == Pesanan.edit) {
                                      Get.to(() => const PesananForm(),
                                          arguments: [
                                            true,
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
                                                    child: const Text("BATAL"),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {},
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.red),
                                                    child: const Text("HAPUS"),
                                                  ),
                                                ],
                                              ));
                                    }
                                  });
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<Pesanan>>[
                                      const PopupMenuItem(
                                        value: Pesanan.edit,
                                        child: Text("Edit"),
                                      ),
                                      const PopupMenuItem(
                                        value: Pesanan.delete,
                                        child: Text("Delete"),
                                      )
                                    ])),
                      ),
                    );
                  });
            }
            return const Text('Something Went Wrong');
          }),
    );
  }
}
