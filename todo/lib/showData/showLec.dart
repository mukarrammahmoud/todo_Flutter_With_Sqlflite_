// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo/screen/addHW.dart';
import 'package:todo/screen/addLec.dart';
import 'package:todo/showData/method/methodDelete.dart';
import 'package:todo/widget/CusttomText.dart';
import 'package:todo/widget/custtomDiveder.dart';

import '../DB.dart';
import '../widget/awesomDialog.dart';

class ShowLec extends StatefulWidget {
  const ShowLec({super.key});

  @override
  State<ShowLec> createState() => _ShowLecState();
}

class _ShowLecState extends State<ShowLec> {
  StreamController<List<Map<String, dynamic>>> dataStreamcon =
      StreamController<List<Map<String, dynamic>>>();
  Stream<List<Map<String, dynamic>>> get dataStream => dataStreamcon.stream;

  getDataLec() async {
    List<Map<String, dynamic>> respone =
        await sqldb.readData("select * from Lec");
    dataStreamcon.add(respone);
    print(respone);
    if (mounted) {
      setState(() {});
    }
  }

  SqlDb sqldb = SqlDb();

  @override
  void initState() {
    getDataLec();
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
                print("=============");
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromARGB(189, 52, 161, 188),
                  ),
                  child: InkWell(
                    onLongPress: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return AddLec(
                            name: snapshot.data![index]["name"] ?? " ",
                            day: snapshot.data![index]["day"] ?? "Sun",
                            ftime: snapshot.data![index]["fromTime"],
                            totime: snapshot.data![index]["toTime"],
                            cls: snapshot.data![index]["class"] ?? " ",
                            id: snapshot.data![index]["id"],
                          );
                        },
                      ));
                    },
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return HomeWork(
                            idLec: snapshot.data![index]["id"],
                            nameLec: snapshot.data![index]["name"],
                            id: 0,
                            fav: 0,
                            content: "",
                            deltime: "",
                          );
                        },
                      ));
                    },
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  custtomText("Name"),
                                  custtomText("Day"),
                                  custtomText("FromTime"),
                                  custtomText("ToTime"),
                                  custtomText("Class"),
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
                                    snapshot.data![index]["day"]),
                                custtomTextSubTitle(
                                    snapshot.data![index]["fromTime"]),
                                custtomTextSubTitle(
                                    snapshot.data![index]["toTime"]),
                                custtomTextSubTitle(
                                    snapshot.data![index]["class"]),
                              ],
                            ),
                          ),
                          const CusttomDivider(),
                          IconButton(
                              onPressed: () async {
                                awesomdialog(context, () async {
                                  int res = await deleteData(
                                      "delete from Lec where id=${snapshot.data![index]["id"]}");

                                  if (res > 0) {
                                    awesomdialogInfo(context,
                                        "Deleted Successfully", "Delete");
                                    getDataLec();
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
        });
  }
}
