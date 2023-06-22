// ignore_for_file: file_names

import 'package:hive/hive.dart';

part '02_user.g.dart';

@HiveType(typeId: 1)
class SqlUser extends HiveObject {
  @HiveField(0)
  String userId;

  @HiveField(1)
  String email;

  @HiveField(2)
  String isOnline;

  @HiveField(3)
  String fullname;

  @HiveField(4)
  String status;

  @HiveField(5)
  int? color;

  SqlUser(
      {required this.userId,
      required this.email,
      required this.isOnline,
      required this.fullname,
      required this.status,
      this.color});
}
