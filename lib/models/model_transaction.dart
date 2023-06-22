// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'dart:convert';

TransactionModel transactionModelFromJson(String str) => TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) => json.encode(data.toJson());

class TransactionModel {
  int id;
  String kodeBarang;
  String kondisi;
  int lokasi;
  String lokasiName;
  String tipeName;
  String barangName;
  int qty;

  TransactionModel({
    required this.id,
    required this.kodeBarang,
    required this.kondisi,
    required this.lokasi,
    required this.lokasiName,
    required this.tipeName,
    required this.barangName,
    required this.qty,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
        id: json["id"],
        kodeBarang: json["kode_barang"],
        kondisi: json["kondisi"],
        lokasi: json["lokasi"],
        lokasiName: json["lokasi_name"],
        tipeName: json["tipe_name"],
        barangName: json["barang_name"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode_barang": kodeBarang,
        "kondisi": kondisi,
        "lokasi": lokasi,
        "lokasi_name": lokasiName,
        "tipe_name": tipeName,
        "barang_name": barangName,
        "qty": qty,
      };
}
