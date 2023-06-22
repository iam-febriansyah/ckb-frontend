// To parse this JSON data, do
//
//     final lokasiModel = lokasiModelFromJson(jsonString);

import 'dart:convert';

LokasiModel lokasiModelFromJson(String str) => LokasiModel.fromJson(json.decode(str));

String lokasiModelToJson(LokasiModel data) => json.encode(data.toJson());

class LokasiModel {
  int id;
  String lokasiName;

  LokasiModel({
    required this.id,
    required this.lokasiName,
  });

  factory LokasiModel.fromJson(Map<String, dynamic> json) => LokasiModel(
        id: json["id"],
        lokasiName: json["lokasi_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lokasi_name": lokasiName,
      };
}
