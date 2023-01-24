enum Satuan { Kg, gr, ml, buah }

enum Status { draft, pembayaran, selesai }

String satuanToString(Satuan satuan) {
  return satuan.toString().split('.').last;
}

Satuan stringToSatuan(String value) {
  return Satuan.values.firstWhere((v) => satuanToString(v) == value);
}

String statusToString(Status status) {
  return status.toString().split('.').last;
}

Status stringToStatus(String value) {
  return Status.values.firstWhere((v) => statusToString(v) == value);
}
