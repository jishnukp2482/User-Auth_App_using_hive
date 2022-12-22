import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_using_hive/db/database.dart';
import 'package:login_using_hive/models/usermodel.dart';
import 'package:login_using_hive/screens/login.dart';
import 'package:rive/rive.dart';

class home extends StatelessWidget {
  home({required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    Future<bool> showexitpopup() async {
      return await showDialog(
              context: context,
              builder: ((context) => AlertDialog(
                    title: const Text("Exit app"),
                    content: const Text("Do you want to exit App?"),
                    actions: [
                      ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("No")),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text("Yes"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                      )
                    ],
                  ))) ??
          false;
    }

    return WillPopScope(
      child: Scaffold(
        body: Container(
          child: Stack(children: [
            const RiveAnimation.asset(
              "assets/rive/shapes.riv",
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 300,
              left: 50,
              child: Text(
                "welcome $email",
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ]),
        ),
      ),
      onWillPop: showexitpopup,
    );
  }
}
