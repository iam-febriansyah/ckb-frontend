import 'dart:async';

import 'package:cbk/helpers/constant.dart';
import 'package:cbk/pages/list.dart';
import 'package:cbk/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool connected = true;

  getData() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () async {
      Get.offAll(const PageList());
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(statusBarColor: ColorsTheme.primary1, statusBarBrightness: Brightness.light));
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 1,
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                  Align(
                      alignment: Alignment.center,
                      child: SizedBox(width: MediaQuery.of(context).size.width * 0.4, child: Image.asset("assets/images/launcher.png"))),
                  Text(
                    Constant.appName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: ColorsTheme.text1,
                      fontSize: 42,
                      fontFamily: "Sansation Light",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                  Text(
                    "Powered by\n${Constant.yourCompany}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: ColorsTheme.text1,
                      fontSize: 12,
                      fontFamily: "Sansation Light",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )));
  }
}
