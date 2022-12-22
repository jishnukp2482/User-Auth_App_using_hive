import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_using_hive/db/database.dart';
import 'package:login_using_hive/models/usermodel.dart';
import 'package:login_using_hive/screens/login.dart';
import 'package:rive/rive.dart';

class signup extends StatelessWidget {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmpasswordcontroller = TextEditingController();
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
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                            controller: _emailcontroller,
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
                            controller: _passwordcontroller,
                            decoration: InputDecoration(
                                hintText: "password",
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
                            controller: _confirmpasswordcontroller,
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
                            onPressed: () {
                              validatesignup();
                            },
                            child: const Text(
                              "Signup",
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
                              Get.to(() => login(),
                                  transition: Transition.fade);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have an account?",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w200),
                                ),
                                const Text(
                                  "Login",
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

  bool checkpassword(String password, String confirmpassword) {
    if (password == confirmpassword) {
      if (password.length < 6) {
        Get.snackbar("Error", "password must contain 6 characters",
            colorText: Colors.red, backgroundColor: Colors.white);
        return false;
      } else {
        return true;
      }
    } else {
      Get.snackbar(
          "password mismatch", "password and confirm password are not same",
          colorText: Colors.red, backgroundColor: Colors.white);
      return false;
    }
  }

  void validatesignup() async {
    final email = _emailcontroller.text.trim();
    final password = _passwordcontroller.text.trim();
    final confirmpassword = _confirmpasswordcontroller.text.trim();
    final emailvalidated = EmailValidator.validate(email);
    final passwordvalidated = checkpassword(password, confirmpassword);
    if (email != '' && password != '' && confirmpassword != '') {
      if (emailvalidated == true) {
        if (passwordvalidated == true) {
          final user = usermodel(email: email, password: password);
          await Dbfuction.instance.usersignup(user);
          Get.back();
          Get.snackbar("Success", "Account created successfully",
              colorText: Colors.blue, backgroundColor: Colors.white);
          print("success");
        } else {
          Get.snackbar("Failed", "Account not created",
              colorText: Colors.red, backgroundColor: Colors.white);
        }
      } else {
        Get.snackbar("error", "please enter a valid email",
            colorText: Colors.red, backgroundColor: Colors.white);
      }
    } else {
      Get.snackbar("error", "Fields cannot be empty",
          colorText: Colors.red, backgroundColor: Colors.white);
    }
  }
}
