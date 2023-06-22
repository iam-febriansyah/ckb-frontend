// To parse this JSON data, do
//
//     final loginResponse = globalResponseFromJson(jsonString);

import 'dart:convert';

import 'package:cbk/models/model_barang.dart';
import 'package:cbk/models/model_lokasi.dart';
import 'package:cbk/models/model_transaction.dart';

GlobalResponse globalResponseFromJson(String str) => GlobalResponse.fromJson(json.decode(str));

String globalResponseToJson(GlobalResponse data) => json.encode(data.toJson());

class GlobalResponse {
  bool status;
  String remarks;
  List<TransactionModel>? transactionModel;
  List<LokasiModel>? lokasiModel;
  List<BarangModel>? barangModel;

  GlobalResponse({required this.status, required this.remarks, this.transactionModel, this.lokasiModel, this.barangModel});

  factory GlobalResponse.fromJson(Map<String, dynamic> json) => GlobalResponse(
        status: json["status"],
        remarks: json["remarks"],
        transactionModel:
            json["transaction"] != null ? List<TransactionModel>.from(json["transaction"].map((x) => TransactionModel.fromJson(x))) : [],
        lokasiModel: json["lokasi"] != null ? List<LokasiModel>.from(json["lokasi"].map((x) => LokasiModel.fromJson(x))) : [],
        barangModel: json["barang"] != null ? List<BarangModel>.from(json["barang"].map((x) => BarangModel.fromJson(x))) : [],
      );

  Map<String, dynamic> toJson() =>
      {"status": status, "remarks": remarks, "transaction": transactionModel, "lokasi": lokasiModel, "barang": barangModel};
}

class GeneralList {
  String id;
  String title;
  String subtitle;

  GeneralList({
    required this.id,
    required this.title,
    required this.subtitle,
  });

  factory GeneralList.fromJson(Map<String, dynamic> json) => GeneralList(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "Password": subtitle,
      };
}
