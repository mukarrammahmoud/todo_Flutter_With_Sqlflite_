import 'package:flutter/material.dart';
import 'package:todo/DB.dart';
import 'package:todo/screen/login.dart';
import 'package:todo/widget/custtomButton.dart';
import 'package:todo/widget/textFaild.dart';

import '../widget/awesomDialog.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _LoginState();
}

class _LoginState extends State<SignUp> {
  int respone = 0;
  addData() async {
    respone = await sqlDb.insertData(
        "insert into Setteing (name,desc,pass) values ('${user.text}','${desc.text}','${password.text}')");
    if (respone > 0) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) {
          return const Login();
        },
      ));
    }
  }

  SqlDb sqlDb = SqlDb();
  TextEditingController user = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController desc = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
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
                    height: 10,
                  ),
                  const Center(
                    child: Text(
                      "signUp",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: Text(
                      "SignUp to continue using the app",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CusttomFaild(
                      hintText: "User Name",
                      title: "User :",
                      controller: password),
                  const SizedBox(
                    height: 10,
                  ),
                  CusttomFaild(
                      hintText: "Enter Password",
                      title: "Password :",
                      controller: user),
                  const SizedBox(
                    height: 10,
                  ),
                  CusttomFaild(
                      hintText: "About You", title: "Desc :", controller: desc),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            CusttomButton(
              title: "SignUp",
              onPressed: () {
                if (formstate.currentState!.validate()) {
                  addData();
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) {
                    return Login();
                  },
                ));
              },
              child: const Center(
                child: Text.rich(TextSpan(children: [
                  TextSpan(text: " Have Account ?"),
                  TextSpan(
                      text: " Login",
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold)),
                ])),
              ),
            )
          ],
        ),
      ),
    );
  }
}
