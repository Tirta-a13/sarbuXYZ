import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarbu/boundary/user_form.dart';
import 'package:sarbu/controller/user_controller.dart';

enum User { edit, delete }

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  UserController userController = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: userController.viewUserList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }
            return ListView.builder(
              itemCount: userController.daftarUser.daftarUser.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                        (userController.daftarUser.daftarUser[index].nama)
                            .toString()),
                    trailing: SizedBox(
                        width: 100,
                        child: PopupMenuButton<User>(
                            onSelected: (User pelanggan) {
                              if (pelanggan == User.edit) {
                                // Get.to(() => PelangganForm(), arguments: [
                                //   true,
                                //   pelangganController.daftarPelanggan.getPelanggan?.id,
                                //   pelangganController.daftarPelanggan.getPelanggan?.nama,
                                //   pelangganController.daftarPelanggan.getPelanggan?.telepon,
                                //   pelangganController.daftarPelanggan.getPelanggan?.alamat,
                                //   pelangganController.daftarPelanggan.getPelanggan?.provinsi,
                                //   pelangganController.daftarPelanggan.getPelanggan?.kota,
                                //   pelangganController.daftarPelanggan.getPelanggan?.contactperson
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
                                              "HAPUS Pelanggan?",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.grey),
                                              child: const Text("BATAL"),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.red),
                                              child: const Text("HAPUS"),
                                            ),
                                          ],
                                        ));
                              }
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<User>>[
                                  const PopupMenuItem(
                                    value: User.edit,
                                    child: Text("Edit"),
                                  ),
                                  const PopupMenuItem(
                                    value: User.delete,
                                    child: Text("Delete"),
                                  )
                                ])),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ((() {
            Get.to(() => const UserForm(), arguments: [false]);
          })),
          child: const Icon(Icons.add),
        ));
  }
}
