// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo/screen/addTask.dart';
import 'package:todo/showData/method/methodDelete.dart';
import 'package:todo/widget/awesomDialog.dart';

import '../DB.dart';
import '../widget/CusttomText.dart';
import '../widget/custtomDiveder.dart';

class ShowTask extends StatefulWidget {
  const ShowTask({super.key});

  @override
  State<ShowTask> createState() => _ShowTaskState();
}

class _ShowTaskState extends State<ShowTask> {
  bool checkStau = false;
  StreamController<List<Map<String, dynamic>>> dataStreamcon =
      StreamController<List<Map<String, dynamic>>>();
  Stream<List<Map<String, dynamic>>> get dataStream => dataStreamcon.stream;
  getDataTask() async {
    List<Map<String, dynamic>> respone =
        await sqldb.readData("select * from Task");

    dataStreamcon.add(respone);

    if (mounted) {
      setState(() {});
    }
  }

  SqlDb sqldb = SqlDb();

  @override
  void initState() {
    getDataTask();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List>(
      stream: dataStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return Task(
                        name: snapshot.data![index]["name"],
                        appoint: snapshot.data![index]["appointment"],
                        time: snapshot.data![index]["time"],
                        fav: snapshot.data![index]["fav"],
                        id: snapshot.data![index]["id"],
                      );
                    },
                  ));
              
                
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromARGB(189, 52, 161, 188),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                custtomText("Name"),
                                custtomText("Appointment"),
                                custtomText("Time"),
                                custtomText("Favorite"),
                              ],
                            ),
                          ),
                        ),
                        const CusttomDivider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              custtomTextSubTitle(
                                  snapshot.data![index]["name"]),
                              custtomTextSubTitle(
                                  snapshot.data![index]["appointment"]),
                              custtomTextSubTitle(
                                  snapshot.data![index]["time"]),
                              Checkbox(
                                value: snapshot.data![index]["fav"] == 1
                                    ? true
                                    : false,
                                onChanged: (value) async {
                                 
                                  if (value == true) {
                                    int respone = await sqldb.updateData('''
                                    update Task set 
                                    name="${snapshot.data![index]["name"]}",
                                    
                                    time="${snapshot.data![index]["time"]}",
                                    appointment="${snapshot.data![index]["appointment"]}",
                                     fav=1
                                     where id=${snapshot.data![index]["id"]}
                                    ''');
                                    setState(() {
                                      getDataTask();
                                     
                                    });
                                  } else {
                                    sqldb.updateData('''
                                    update Task set 
                                    name="${snapshot.data![index]["name"]}",
                                    appointment="${snapshot.data![index]["appointment"]}",
                                    time="${snapshot.data![index]["time"]}",
                                     fav=0
                                     where id=${snapshot.data![index]["id"]}
                                    ''');
                                    setState(() {
                                      getDataTask();
                                    });
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                        const CusttomDivider(),
                        IconButton(
                            onPressed: () async {
                              awesomdialog(context, () async {
                                int res = await deleteData(
                                    "delete from Task where id=${snapshot.data![index]["id"]}");

                                if (res > 0) {
                                  awesomdialogInfo(context,
                                      "Deleted Successfully", "Delete");
                                  getDataTask();
                                }
                              }, "Are You Sure From Deleteing", "Delete");
                            },
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return custtomText("Empty");
      },
    );
  }
}
