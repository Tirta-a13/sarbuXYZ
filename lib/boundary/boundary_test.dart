import 'package:flutter/material.dart';
import 'package:sarbu/entity/sari_buah.dart';

class BoundaryObject {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void displayConfirmationMessage(String message) {
    // Display a snackbar with the given message
    ScaffoldMessenger(
      key: _scaffoldKey,
      child: Text(message),
    );
  }

  void displaySaribuahList(List<SariBuah> saribuah, Function(int) onTap) {
    // Build a list view of the saribuah
    Widget saribuahList = ListView.builder(
      itemCount: saribuah.length,
      itemBuilder: (context, index) {
        print(saribuah[index].nama);
        return ListTile(
          title: Text('aaaa'),
          onTap: () => onTap(index),
        );
      },
    );
    _scaffoldKey.currentState?.showBottomSheet((context) => saribuahList);
  }
}
