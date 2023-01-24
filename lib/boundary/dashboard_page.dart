import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sarbu/boundary/komposisi_page.dart';
import 'package:sarbu/boundary/pelanggan_page.dart';
import 'package:sarbu/boundary/pesanan_form.dart';
import 'package:sarbu/boundary/pesanan_page.dart';
import 'package:sarbu/boundary/sari_buah_page.dart';
import 'package:sarbu/boundary/stok_page.dart';
import 'package:sarbu/boundary/test.dart';
import 'package:sarbu/boundary/users_page.dart';
import 'package:sarbu/controller/auth_controller.dart';

enum DrawerSections {
  pesanan,
  spb,
  stok,
  saribuah,
  pelanggan,
  logout,
  pengadaan,
}

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  var currentPage = DrawerSections.saribuah;
  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.pesanan) {
      container = const PesananPage();
    } else if (currentPage == DrawerSections.pelanggan) {
      container = const PelangganPage();
    } else if (currentPage == DrawerSections.pengadaan) {
      container = const KomposisiPage();
    } else if (currentPage == DrawerSections.spb) {
      container = const UsersPage();
    } else if (currentPage == DrawerSections.saribuah) {
      container = const SariBuahPage();
    } else if (currentPage == DrawerSections.stok) {
      container = const StokPage();
    } else if (currentPage == DrawerSections.logout) {
      AuthController().logout(context);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(currentPage.name.toUpperCase()),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                const SizedBox(
                  height: 20,
                ),
                myDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyHeaderDrawer() {
    return Container(
      color: Colors.red,
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "user",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            'email',
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget myDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Pesanan", Icons.local_offer,
              currentPage == DrawerSections.pesanan ? true : false),
          menuItem(2, "Pelanggan", Icons.people,
              currentPage == DrawerSections.pelanggan ? true : false),
          menuItem(3, "Stok", Icons.check_box,
              currentPage == DrawerSections.stok ? true : false),
          Divider(),
          menuItem(4, "Pengadaan", Icons.add_box,
              currentPage == DrawerSections.pengadaan ? true : false),
          menuItem(5, "Saribuah", Icons.local_drink,
              currentPage == DrawerSections.stok ? true : false),
          menuItem(6, "SPB", Icons.person,
              currentPage == DrawerSections.spb ? true : false),
          Divider(),
          menuItem(7, "Logout", Icons.logout,
              currentPage == DrawerSections.logout ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.pesanan;
            } else if (id == 2) {
              currentPage = DrawerSections.pelanggan;
            } else if (id == 3) {
              currentPage = DrawerSections.stok;
            } else if (id == 4) {
              currentPage = DrawerSections.pengadaan;
            } else if (id == 5) {
              currentPage = DrawerSections.saribuah;
            } else if (id == 6) {
              currentPage = DrawerSections.spb;
            } else if (id == 7) {
              currentPage = DrawerSections.logout;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
