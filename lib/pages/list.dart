// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:cbk/controllers/ctrl.dart';
import 'package:cbk/models/model_response.dart';
import 'package:cbk/models/model_transaction.dart';
import 'package:cbk/pages/page_list.dart';
import 'package:cbk/pages/widgets/widget_progress.dart';
import 'package:cbk/pages/widgets/widget_snackbar.dart';
import 'package:cbk/style/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PageList extends StatefulWidget {
  const PageList({super.key});

  @override
  State<PageList> createState() => _PageListState();
}

class _PageListState extends State<PageList> {
  Ctrl ctrl = Get.put(Ctrl());
  TextEditingController ctrlKodeBarang = TextEditingController();
  TextEditingController ctrlKondisi = TextEditingController();
  TextEditingController ctrlLokasi = TextEditingController();
  TextEditingController ctrlQty = TextEditingController();
  Timer? timer;
  List<TransactionModel> data = [];
  bool isLoading = true;
  bool form = false;
  String btnName = 'Tambah';
  int id = 0;
  String idBarang = '';
  String idLokasi = '';

  List<GeneralList> lokasiModel = [];
  List<GeneralList> kondisiModel = [];
  List<GeneralList> barangModel = [];

  void getData() async {
    setState(() {
      isLoading = true;
      idBarang = '';
      form = false;
      ctrlKodeBarang.text = "";
      idLokasi = "";
      ctrlLokasi.text = "";
      ctrlKondisi.text = "";
      ctrlQty.text = "";
      btnName = 'Tambah';
    });
    GlobalResponse res = await ctrl.actionList(context);
    if (!res.status) {
      WidgetSnackbar(context: context, message: res.remarks, warna: res.status ? "hijau" : "merah");
    } else {
      setState(() {
        data = res.transactionModel!;
      });
    }
    setState(() {
      isLoading = false;
    });
    kondisiModel = [];
    kondisiModel.add(GeneralList(id: 'Baru', title: 'Baru', subtitle: ''));
    kondisiModel.add(GeneralList(id: 'Bekas', title: 'Bekas', subtitle: ''));
  }

  void getLokasi() async {
    GlobalResponse res = await ctrl.actionLokasi(context);
    if (!res.status) {
      WidgetSnackbar(context: context, message: res.remarks, warna: res.status ? "hijau" : "merah");
    } else {
      setState(() {
        for (var e in res.lokasiModel!) {
          lokasiModel.add(GeneralList(id: e.id.toString(), title: e.lokasiName, subtitle: e.lokasiName));
        }
      });
    }
  }

  void getBarang() async {
    GlobalResponse res = await ctrl.actionBarang(context);
    if (!res.status) {
      WidgetSnackbar(context: context, message: res.remarks, warna: res.status ? "hijau" : "merah");
    } else {
      setState(() {
        for (var e in res.barangModel!) {
          print(e.id);
          barangModel.add(GeneralList(id: e.id.toString(), title: e.kodeBarang, subtitle: e.tipeName));
        }
      });
    }
  }

  void add() async {
    if (idBarang == '') {
      WidgetSnackbar(context: context, message: 'harap pilih barang', warna: "merah");
      return;
    }
    if (ctrlKondisi.text == '') {
      WidgetSnackbar(context: context, message: 'harap pilih kondisi', warna: "merah");
      return;
    }
    if (idLokasi == '') {
      WidgetSnackbar(context: context, message: 'harap pilih lokasi', warna: "merah");
      return;
    }
    if (ctrlQty.text == '') {
      WidgetSnackbar(context: context, message: 'harap isi kuantit', warna: "merah");
      return;
    }
    showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) => const WidgetProgressSubmit());
    GlobalResponse res = await ctrl.actionAdd(context, idBarang, ctrlKondisi.text, idLokasi, ctrlQty.text);
    if (!res.status) {
      WidgetSnackbar(context: context, message: res.remarks, warna: res.status ? "hijau" : "merah");
    } else {
      Navigator.pop(context);
      WidgetSnackbar(context: context, message: 'Berhasil menambahkan data', warna: "hijau");
      getData();
    }
  }

  void edit() async {
    if (idBarang == '') {
      WidgetSnackbar(context: context, message: 'harap pilih barang', warna: "merah");
      return;
    }
    if (ctrlKondisi.text == '') {
      WidgetSnackbar(context: context, message: 'harap pilih kondisi', warna: "merah");
      return;
    }
    if (idLokasi == '') {
      WidgetSnackbar(context: context, message: 'harap pilih lokasi', warna: "merah");
      return;
    }
    if (ctrlQty.text == '') {
      WidgetSnackbar(context: context, message: 'harap isi kuantit', warna: "merah");
      return;
    }
    setState(() {
      isLoading = true;
    });
    GlobalResponse res = await ctrl.actionEdit(context, id.toString(), idBarang, ctrlKondisi.text, idLokasi, ctrlQty.text);
    if (!res.status) {
      WidgetSnackbar(context: context, message: res.remarks, warna: res.status ? "hijau" : "merah");
    } else {
      WidgetSnackbar(context: context, message: 'Berhasil mengedit data', warna: "hijau");
      getData();
    }
  }

  void hapus() async {
    GlobalResponse res = await ctrl.actionDelete(context, id.toString());
    if (!res.status) {
      WidgetSnackbar(context: context, message: res.remarks, warna: res.status ? "hijau" : "merah");
    } else {
      WidgetSnackbar(context: context, message: 'Berhasil mengapus data', warna: "hijau");
      getData();
    }
  }

  @override
  void initState() {
    getData();
    getLokasi();
    getBarang();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(statusBarColor: ColorsTheme.primary1, statusBarBrightness: Brightness.light));
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "List Barang",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: ColorsTheme.primary1,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 4, right: 16),
              child: InkWell(
                onTap: () {
                  getData();
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white),
                  ),
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 4, right: 16),
              child: InkWell(
                onTap: () {
                  setState(() {
                    form = true;
                  });
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
          child: isLoading
              ? const CupertinoActivityIndicator()
              : Column(
                  children: [
                    form
                        ? Container(
                            child: Column(
                              children: [
                                //barang
                                InkWell(
                                  onTap: () async {
                                    GeneralList b = await Get.to(PageListData(
                                      datas: barangModel,
                                      title: "Barang",
                                    ));
                                    setState(() {
                                      idBarang = b.title.toString();
                                      ctrlKodeBarang.text = "${b.title} ${b.subtitle}";
                                    });
                                  },
                                  child: TextField(
                                    controller: ctrlKodeBarang,
                                    enabled: false,
                                    decoration: const InputDecoration(hintText: 'Barang'),
                                  ),
                                ),

                                //lokasi
                                InkWell(
                                  onTap: () async {
                                    GeneralList b = await Get.to(PageListData(
                                      datas: lokasiModel,
                                      title: "Lokasi",
                                    ));
                                    setState(() {
                                      idLokasi = b.id.toString();
                                      ctrlLokasi.text = "${b.title} ${b.subtitle}";
                                    });
                                  },
                                  child: TextField(
                                    controller: ctrlLokasi,
                                    enabled: false,
                                    decoration: const InputDecoration(hintText: 'Lokasi'),
                                  ),
                                ),

                                //kondisi
                                InkWell(
                                  onTap: () async {
                                    GeneralList b = await Get.to(PageListData(
                                      datas: kondisiModel,
                                      title: "Kondisi",
                                    ));
                                    setState(() {
                                      ctrlKondisi.text = "${b.id}";
                                    });
                                  },
                                  child: TextField(
                                    controller: ctrlKondisi,
                                    enabled: false,
                                    decoration: const InputDecoration(hintText: 'Kondisi'),
                                  ),
                                ),
                                TextField(
                                  controller: ctrlQty,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(hintText: 'Kuantiti'),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.055,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (btnName != 'Update') {
                                          add();
                                        } else {
                                          edit();
                                        }
                                      },
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(ColorsTheme.primary1),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ))),
                                      child: Text(
                                        btnName,
                                        style: const TextStyle(color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          )
                        : Container(),
                    ListView.builder(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: data.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          TransactionModel item = data[index];
                          return InkWell(
                            onTap: () {
                              Navigator.pop(context, item);
                            },
                            child: card(item),
                          );
                        }),
                  ],
                ),
        )));
  }

  Widget card(TransactionModel item) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.barangName, style: const TextStyle(fontSize: 16, color: ColorsTheme.primary1)),
                  Text(
                    item.barangName.toUpperCase(),
                    style: const TextStyle(fontSize: 14, color: ColorsTheme.text1),
                  ),
                  Text(
                    item.tipeName.toUpperCase(),
                    style: const TextStyle(fontSize: 14, color: ColorsTheme.text1),
                  ),
                  Row(
                    children: [
                      Text(
                        "Kuantiti : ${item.qty}",
                        style: const TextStyle(fontSize: 14, color: ColorsTheme.text1),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Lokasi : ${item.lokasiName}",
                        style: const TextStyle(fontSize: 14, color: ColorsTheme.text1),
                      ),
                    ],
                  ),
                  const Divider()
                ],
              ),
            ),
            InkWell(
              child: Icon(Icons.edit, color: Colors.green[800]),
              onTap: () {
                setState(() {
                  id = item.id;
                  form = true;
                  btnName = "Update";
                  idBarang = item.kodeBarang.toString();
                  ctrlKodeBarang.text = "${item.kodeBarang} ${item.barangName}";
                  idLokasi = item.lokasi.toString();
                  ctrlLokasi.text = "${item.lokasiName}";
                  ctrlKondisi.text = "${item.kondisi}";
                  ctrlQty.text = "${item.qty}";
                });
              },
            ),
            InkWell(
              child: const Icon(Icons.close, color: ColorsTheme.primary1),
              onTap: () {
                setState(() {
                  id = item.id;
                  form = false;
                });
                hapus();
              },
            )
          ],
        ));
  }
}
