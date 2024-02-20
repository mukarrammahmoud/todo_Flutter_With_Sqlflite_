// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:todo/DB.dart';

import 'package:todo/widget/cuattomTime.dart';
import 'package:todo/widget/custtomButton.dart';
import 'package:todo/widget/custtomDay.dart';
import 'package:todo/widget/custtomDiveder.dart';
import 'package:todo/widget/textFaild.dart';

import '../widget/awesomDialog.dart';
import 'home_screen.dart';

class AddLec extends StatefulWidget {
  const AddLec(
      {super.key,
      required this.name,
      required this.day,
      required this.ftime,
      required this.totime,
      required this.cls,
      required this.id});
  final String name;
  final String day;
  final String ftime;
  final String totime;
  final String cls;
  final int id;

  @override
  State<AddLec> createState() => _AddLecState();
}

class _AddLecState extends State<AddLec> {
  SqlDb sqlDb = SqlDb();
  final GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<ScaffoldState> globalKey = GlobalKey();
  TextEditingController lecName = TextEditingController();
  TextEditingController className = TextEditingController();
//------------------------add---------------
  addLec() async {
    int response = await sqlDb.insertData(
        "insert into Lec (name,day,fromTime,toTime,class) values ('${lecName.text}','$selectedItem','$fTime','$tTime','${className.text}')");

    await awesomdialogInfo(context, "Add Successfully", "Add");

    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      builder: (context) {
        return const HomeScreen();
      },
    ), (route) => false);
    print(response);
  }

//--------------------------------------update-----------
  updatedata() async {
    int respone = await sqlDb.updateData('''
      update Lec set 
       name='${lecName.text}',
      day='$selectedItem',
      fromTime='$fTime',
     toTime='$tTime',
       class='${className.text}' 
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

  @override
  void initState() {
    lecName.text = widget.name;
    selectedItem = widget.day;
    fTime = widget.ftime;
    tTime = widget.totime;
    className.text = widget.cls;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
        appBar: AppBar(
          title: const Text("Add Lecture"),
        ),
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              CusttomFaild(
                
                controller: lecName,
                hintText: "Enter Name Of Lecture",
                title: "Lecture",
              ),
              const Row(
                children: [
                  Expanded(flex: 1, child: CusttomTimeDialog(title: "From:")),
                  Expanded(flex: 1, child: CusttomTimeDialog(title: "To:")),
                ],
              ),
              CusttomDay(
                title: "Day",
              ),
              CusttomFaild(
            
                controller: className,
                hintText: "Enter The Class",
                title: "Class",
              ),
              const CusttomDivider(),
              CusttomButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    widget.id == 0 ? addLec() : updatedata();
                  } else {}
                },
                title: widget.id == 0 ? "Add" : "Edit",
              )
            ],
          ),
        ));
  }
}
