// To parse this JSON data, do
//
//     final barangModel = barangModelFromJson(jsonString);

import 'dart:convert';

BarangModel barangModelFromJson(String str) => BarangModel.fromJson(json.decode(str));

String barangModelToJson(BarangModel data) => json.encode(data.toJson());

class BarangModel {
  int id;
  String kodeBarang;
  String barangName;
  int tipe;
  String tipeName;

  BarangModel({
    required this.id,
    required this.kodeBarang,
    required this.barangName,
    required this.tipe,
    required this.tipeName,
  });

  factory BarangModel.fromJson(Map<String, dynamic> json) => BarangModel(
        id: json["id"],
        kodeBarang: json["kode_barang"],
        barangName: json["barang_name"],
        tipe: json["tipe"],
        tipeName: json["tipe_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode_barang": kodeBarang,
        "barang_name": barangName,
        "tipe": tipe,
        "tipe_name": tipeName,
      };
}
