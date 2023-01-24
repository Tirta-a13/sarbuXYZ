import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarbu/controller/pelanggan_controller.dart';
import 'package:sarbu/controller/pesanan_controller.dart';
import 'package:sarbu/controller/saribuah_controller.dart';

class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  PesananController pesananController = Get.put(PesananController());
  PelangganController pelangganController = Get.put(PelangganController());
  @override
  void initState() {
    super.initState();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: pelangganController.getAllPelangganList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return const Text("Loading");
          }

          return Text('test');
        },
      ),
    );
  }
}
