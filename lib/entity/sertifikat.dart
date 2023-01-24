import 'package:cloud_firestore/cloud_firestore.dart';

class Sertifikat {
  String? id;
  String? namalembaga;
  String? noizin;

  Sertifikat({this.id, this.namalembaga, this.noizin});

  Map<String, dynamic> toMap() => {
        "lembaga": namalembaga,
        "noizin": noizin,
      };

  fromMap(Map<String, dynamic> map) {
    namalembaga = map['lembaga'];
    noizin = map['noizin'];
  }

  //----------Create
  create(Sertifikat sertifikat) {
    DocumentReference docref =
        FirebaseFirestore.instance.collection('komposisi').doc();
    docref.set(sertifikat.toMap());
    return docref;
  }

  //-----------Read
  read(Sertifikat sertifikat) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.doc(sertifikat.id.toString()).get();
    var a = snapshot.data() as Map<String, dynamic>;
    return a;
  }

  //-----------Delete
  delete(Sertifikat sertifikat) {
    FirebaseFirestore.instance
        .collection('sertifikat')
        .doc(sertifikat.id)
        .delete();
  }
}

//   factory Sertifikat.fromSnapshot(DocumentSnapshot snap) {
//     var map = snap.data() as Map<String, dynamic>;
//     return Sertifikat(namalembaga: map['namalembaga'], noizin: map['noizin']);
//   }

//   addSertifikat(Sertifikat sertifikat, String saribuahid) async {
//     DocumentReference ref =
//         FirebaseFirestore.instance.collection('sertifikat').doc();
//     DocumentReference saribuahdoc =
//         FirebaseFirestore.instance.collection('saribuah').doc(saribuahid);
//     try {
//       ref.set(sertifikat.toJson());
//       saribuahdoc.update({
//         "sertifikat": FieldValue.arrayUnion([ref])
//       });
//     } catch (e) {
//       return e;
//     }
//     return ref.id;
//   }
// }
