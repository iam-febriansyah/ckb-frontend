// ignore_for_file: unnecessary_brace_in_string_interps, use_build_context_synchronously, avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:cbk/helpers/constant.dart';
import 'package:cbk/models/model_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  int timeOut = 30;
  var url = Constant.httpMainUrl;
  static const String urlList = "/api/list";
  static const String urlAdd = "/api/add";
  static const String urlEdit = "/api/edit";
  static const String urlDelete = "/api/delete";
  static const String urlLokasi = "/api/lokasi";
  static const String urlBarang = "/api/barang";

  Future<GlobalResponse> fetchPost(BuildContext ctx, String endPoint, dynamic auth, Map data) async {
    try {
      var body = jsonEncode(data);
      final response = await http
          .post(Uri.parse(url + endPoint),
              headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': auth}, body: body)
          .timeout(Duration(seconds: timeOut), onTimeout: () => throw TimeoutException('Can\'t connect in ${timeOut} seconds.'));
      print(endPoint);
      if (response.statusCode == 200) {
        GlobalResponse res = GlobalResponse.fromJson(jsonDecode(response.body));
        return res;
      } else {
        Map<String, dynamic> res = {};
        res['status'] = false;
        res['remarks'] = 'Failed to post error $endPoint';
        return GlobalResponse.fromJson(res);
      }
    } catch (e) {
      Map<String, dynamic> res = {};
      res['status'] = false;
      res['remarks'] = e.toString();
      return GlobalResponse.fromJson(res);
    }
  }

  Future<GlobalResponse> apiList(BuildContext ctx) async {
    try {
      return await fetchPost(ctx, urlList, '', {});
    } catch (e) {
      Map<String, dynamic> res = {};
      res['status'] = false;
      res['remarks'] = e.toString();
      return GlobalResponse.fromJson(res);
    }
  }

  Future<GlobalResponse> apiAdd(BuildContext ctx, Map data) async {
    try {
      return await fetchPost(ctx, urlAdd, '', data);
    } catch (e) {
      Map<String, dynamic> res = {};
      res['status'] = false;
      res['remarks'] = e.toString();
      return GlobalResponse.fromJson(res);
    }
  }

  Future<GlobalResponse> apiEdit(BuildContext ctx, Map data) async {
    try {
      return await fetchPost(ctx, urlEdit, '', data);
    } catch (e) {
      Map<String, dynamic> res = {};
      res['status'] = false;
      res['remarks'] = e.toString();
      return GlobalResponse.fromJson(res);
    }
  }

  Future<GlobalResponse> apiDelete(BuildContext ctx, Map data) async {
    try {
      return await fetchPost(ctx, urlDelete, '', data);
    } catch (e) {
      Map<String, dynamic> res = {};
      res['status'] = false;
      res['remarks'] = e.toString();
      return GlobalResponse.fromJson(res);
    }
  }

  Future<GlobalResponse> apiLokasi(BuildContext ctx) async {
    try {
      return await fetchPost(ctx, urlLokasi, '', {});
    } catch (e) {
      Map<String, dynamic> res = {};
      res['status'] = false;
      res['remarks'] = e.toString();
      return GlobalResponse.fromJson(res);
    }
  }

  Future<GlobalResponse> apiBarang(BuildContext ctx) async {
    try {
      return await fetchPost(ctx, urlBarang, '', {});
    } catch (e) {
      Map<String, dynamic> res = {};
      res['status'] = false;
      res['remarks'] = e.toString();
      return GlobalResponse.fromJson(res);
    }
  }
}
