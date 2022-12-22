import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_using_hive/db/database.dart';
import 'package:login_using_hive/screens/home.dart';
import 'package:login_using_hive/screens/signup.dart';
import 'package:rive/rive.dart';
import 'package:login_using_hive/models/usermodel.dart';

class login extends StatelessWidget {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            const RiveAnimation.asset(
              "assets/rive/shapes.riv",
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 150,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: Colors.transparent.withOpacity(0.2)),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                            controller: emailcontroller,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 16,
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            obscureText: true,
                            obscuringCharacter: "*",
                            controller: passwordcontroller,
                            decoration: InputDecoration(
                                hintText: "password",
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 16,
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          height: 40,
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () async {
                              final list = await Dbfuction.instance.getusers();
                              checkusers(list);
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextButton(
                            onPressed: () {
                              Get.to(() => signup(),
                                  transition: Transition.fade);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Dont have an account?",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w200),
                                ),
                                const Text(
                                  "Signup",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> validatelogin(String email, String password) async {
    if (email != "" && password != "") {
      return true;
    } else {
      return false;
    }
  }

  Future<void> checkusers(List<usermodel> userlist) async {
    final email = emailcontroller.text.trim();
    final password = passwordcontroller.text.trim();
    bool userfound = false;
    final validated = await validatelogin(email, password);
    if (validated == true) {
      await Future.forEach(userlist, (user) {
        if (user.email == email && user.password == password) {
          userfound = true;
        } else {
          userfound = false;
        }
      });
      if (userfound == true) {
        Get.offAll(() => home(email: email), transition: Transition.fadeIn);
        Get.snackbar("success", "Logged in  as $email",
            colorText: Colors.blue, backgroundColor: Colors.white);
      } else {
        Get.snackbar("error", "incorrect username or password",
            colorText: Colors.red, backgroundColor: Colors.white);
      }
    } else {
      Get.snackbar("error", "fields cannot be empty",
          colorText: Colors.red, backgroundColor: Colors.white);
    }
  }
}
