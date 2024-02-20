// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:todo/DB.dart';
import 'package:todo/screen/custtomSearchPage.dart';
import 'package:todo/screen/home_screen.dart';
import 'package:todo/screen/sign.dart';

import 'package:todo/widget/awesomDialog.dart';
import 'package:todo/widget/custtomButton.dart';
import 'package:todo/widget/textFaild.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  getuserAndPass() async {
    data = await sqlDb.readData(
        "Select * from Setteing where name='${user.text}' and pass='${password.text}'");

    if (data.isNotEmpty) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) {
          return const HomeScreen();
        },
      ));
      return;
    }
    awesomdialogInfo(context, "Faild Login", "Login");
  }

  TextEditingController user = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  SqlDb sqlDb = SqlDb();
  List data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
              key: formstate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Center(
                    child: Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Center(
                    child: Text(
                      "Login to continue using the app",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CusttomFaild(
                    hintText: "Enter Your Name",
                    title: " Name :",
                    controller: user,
                  ),
                  CusttomFaild(
                    hintText: "Enter password",
                    title: " Password :",
                    controller: password,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            CusttomButton(title: "Login", onPressed: getuserAndPass),
            const SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const SignUp();
                  },
                ));
              },
              child: const Center(
                child: Text.rich(TextSpan(children: [
                  TextSpan(text: "Don't Have Account ?"),
                  TextSpan(
                      text: " Register",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold)),
                ])),
              ),
            )
          ],
        ),
      ),
    );
  }
}
