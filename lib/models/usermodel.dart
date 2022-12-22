import 'package:hive_flutter/hive_flutter.dart';
part 'usermodel.g.dart';
@HiveType(typeId: 1)
class usermodel {
  @HiveField(0)
  final String email;
  @HiveField(1)
  final String password;
  @HiveField(2)
  String? id;
  usermodel({required this.email, required this.password}) {
    id = DateTime.now().microsecondsSinceEpoch.toString();
  }
}
