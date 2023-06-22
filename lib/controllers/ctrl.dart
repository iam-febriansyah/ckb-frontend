// ignore_for_file: unnecessary_overrides, use_build_context_synchronously
import 'package:cbk/api/api_services.dart';
import 'package:cbk/models/model_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cbk/helpers/constant.dart';

class Ctrl extends GetxController {
  ApiService apiService = ApiService();
  String domainIP = Constant.domainIP;
  String port = Constant.port;
  String mainUrl = Constant.mainUrl;
  String httpMainUrl = Constant.httpMainUrl;
  bool isLoading = true;
  bool isError = false;
  String remark = "";

  Future<GlobalResponse> actionAdd(BuildContext ctx, String kodeBarang, String kondisi, String lokasi, String qty) async {
    try {
      Map data = {};
      data['kode_barang'] = kodeBarang;
      data['kondisi'] = kondisi;
      data['lokasi'] = lokasi;
      data['qty'] = qty;
      print(data);
      var response = await apiService.apiAdd(ctx, data);
      return response;
    } catch (e) {
      return catchErr(ctx, e);
    }
  }

  Future<GlobalResponse> actionEdit(BuildContext ctx, String id, String kodeBarang, String kondisi, String lokasi, String qty) async {
    try {
      Map data = {};
      data['id'] = id;
      data['kode_barang'] = kodeBarang;
      data['kondisi'] = kondisi;
      data['lokasi'] = lokasi;
      data['qty'] = qty;
      var response = await apiService.apiEdit(ctx, data);
      return response;
    } catch (e) {
      return catchErr(ctx, e);
    }
  }

  Future<GlobalResponse> actionDelete(BuildContext ctx, String id) async {
    try {
      Map data = {};
      data['id'] = id;
      var response = await apiService.apiDelete(ctx, data);
      return response;
    } catch (e) {
      return catchErr(ctx, e);
    }
  }

  Future<GlobalResponse> actionList(BuildContext ctx) async {
    try {
      var response = await apiService.apiList(ctx);
      return response;
    } catch (e) {
      return catchErr(ctx, e);
    }
  }

  Future<GlobalResponse> actionLokasi(BuildContext ctx) async {
    try {
      var response = await apiService.apiLokasi(ctx);
      return response;
    } catch (e) {
      return catchErr(ctx, e);
    }
  }

  Future<GlobalResponse> actionBarang(BuildContext ctx) async {
    try {
      var response = await apiService.apiBarang(ctx);
      return response;
    } catch (e) {
      return catchErr(ctx, e);
    }
  }

  loginMandatory(String email, String password) {
    if (email.isEmpty) {
      return "Please enter email";
    } else if (password.isEmpty) {
      return "Please enter password";
    } else {
      return "";
    }
  }

  GlobalResponse catchErr(BuildContext ctx, e) {
    Map<String, dynamic> res = {};
    res['status'] = false;
    res['remarks'] = e.toString();
    isLoadingFalse(ctx, e.toString());
    return GlobalResponse.fromJson(res);
  }

  void isLoadingTrue(BuildContext ctx) {
    isLoading = true;
    isError = false;
    update();
  }

  void isLoadingFalse(BuildContext ctx, String err) {
    FocusScope.of(ctx).requestFocus(FocusNode());
    isLoading = false;
    isError = err == '' ? false : true;
    remark = err;
    Navigator.of(ctx, rootNavigator: true).pop();
    update();
  }

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
