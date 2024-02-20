// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:todo/DB.dart';
import 'package:todo/screen/home_screen.dart';
import 'package:todo/widget/awesomDialog.dart';
import 'package:todo/widget/custtomButton.dart';
import 'package:todo/widget/custtomDateDialog.dart';
import 'package:todo/widget/custtomDiveder.dart';

import 'package:todo/widget/textFaild.dart';

class HomeWork extends StatefulWidget {
  const HomeWork(
      {super.key,
      required this.idLec,
      required this.nameLec,
      required this.content,
      required this.deltime,
      required this.fav,
      required this.id});
  final int idLec;
  final String nameLec;
  final String content;
  final String deltime;
  final int fav;
  final int id;

  @override
  State<HomeWork> createState() => _HomeWorkState();
}

class _HomeWorkState extends State<HomeWork> {
  SqlDb sqlDb = SqlDb();
  final GlobalKey<FormState> formKey = GlobalKey();
  addHW() async {
    int response = await sqlDb.insertData(
        "insert into HW (idLec,content,Deltime,fav) values (${widget.idLec},'${content.text}','$date',${widget.fav})");
    if (response > 0) {
      await awesomdialogInfo(context, "Add Successfully", "Add");

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (context) {
          return const HomeScreen();
        },
      ), (route) => false);
    }
  }

  //==========update data======
  updatedata() async {
    int respone = await sqlDb.updateData('''
      update HW set 
       idLec='${widget.idLec}',
      content='${content.text}',
      Deltime='$date',
     fav='${widget.fav}'
       
     where id=${widget.id}

    ''');

    if (respone > 0) {
      await awesomdialogInfo(context, "Edit Successfully", "Editing");

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (context) {
          return const HomeScreen();
        },
      ), (route) => false);
    }
  }

  TextEditingController content = TextEditingController();
  TextEditingController name = TextEditingController();

  @override
  void initState() {
    if (widget.id > 0) {
      content.text = widget.content;
      name.text = widget.nameLec;
      date = widget.deltime;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Work "),
        centerTitle: true,
      ),
      body: ListView(children: [
        CusttomFaild(
           
            hintText: widget.nameLec,
            title: "Name :",
            controller: name),
        Form(
          key: formKey,
          child: CusttomFaild(
             
              hintText: "Content",
              title: "Content :",
              controller: content),
        ),
        const ShowDate(),
        const SizedBox(height: 30),
        const CusttomDivider(),
        CusttomButton(
          title: widget.id == 0 ? "Add" : "Edit",
          onPressed: () {
            if (formKey.currentState!.validate()) {
              widget.id == 0 ? addHW() : updatedata();
            } else {}
          },
        ),
      ]),
    );
  }
}
