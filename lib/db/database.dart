import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_using_hive/models/usermodel.dart';

class Dbfuction {
  //singleton --factory constructor
  Dbfuction.internal();

  static Dbfuction instance = Dbfuction.internal();
  factory Dbfuction() {
    return instance;
  }
// add users
  Future<void> usersignup(usermodel user) async {
    final db = await Hive.openBox<usermodel>("user");
    db.put(user.id, user);
  }

//getusers
  Future<List<usermodel>> getusers() async {
    final db = await Hive.openBox<usermodel>("user");
    return db.values.toList();
  }
}
