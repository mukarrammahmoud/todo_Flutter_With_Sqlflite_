import 'package:flutter/material.dart';
import 'package:todo/DB.dart';
import 'package:todo/screen/home_screen.dart';
import 'package:todo/widget/cuattomTime.dart';
import 'package:todo/widget/custtomButton.dart';
import 'package:todo/widget/custtomDateDialog.dart';
import 'package:todo/widget/custtomDiveder.dart';
import 'package:todo/widget/textFaild.dart';

import '../widget/awesomDialog.dart';

class Task extends StatefulWidget {
  const Task(
      {super.key,
      required this.name,
      required this.appoint,
      required this.time,
      required this.fav,
      required this.id});
  final String name;
  final String appoint;
  final String time;
  final int fav;
  final int id;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  TextEditingController nameTask = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  SqlDb sqlDb = SqlDb();
  int fav = 0;
  //-----------------method Edit Data -------------------------------
  updatedata() async {
    int respone = await sqlDb.updateData('''
     update Task set 
     name='${nameTask.text}',
     appointment='$date',
     time='$tTime',
     fav=$fav
     where id=${widget.id}

''');

    if (respone > 0) {
      // ignore: use_build_context_synchronously
      await awesomdialogInfo(context, "Edit Successfully", "Editing");

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (context) {
          return const HomeScreen();
        },
      ), (route) => false);
    }
  }

//----------------------------------method Add Data-------------------------------------------------
  addTask() async {
    int response = await sqlDb.insertData(
        "insert into Task (name,appointment,time,fav) values ('${nameTask.text}','$date','$tTime','$fav')");
    if (response > 0) {
      // ignore: use_build_context_synchronously
      await awesomdialogInfo(context, "Add Successfully", "Add");

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (context) {
          return const HomeScreen();
        },
      ), (route) => false);
    }
  }

  @override
  void initState() {
    if (widget.id > 0) {
      print("----${widget.appoint}");
      nameTask.text = widget.name;
      tTime = widget.time;
      date = widget.appoint;
      fav = widget.fav;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task"),
      ),
      body: ListView(
        children: [
          Form(
            key: formKey,
            child: CusttomFaild(
              
                hintText: "Enter Your Task",
                title: "Task : ",
                controller: nameTask),
          ),
          const CusttomTimeDialog(title: "Time :"),
          const ShowDate(),
          const SizedBox(
            height: 30,
          ),
          const CusttomDivider(),
          CusttomButton(
            title: widget.id == 0 ? "Add" : "Edit",
            onPressed: () {
              if (formKey.currentState!.validate()) {
                widget.id == 0 ? addTask() : updatedata();
              } else {}
            },
          )
        ],
      ),
    );
  }
}
