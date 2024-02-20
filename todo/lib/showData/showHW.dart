// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo/screen/addHW.dart';

import '../DB.dart';
import '../widget/CusttomText.dart';
import '../widget/awesomDialog.dart';
import '../widget/custtomDiveder.dart';

import 'method/methodDelete.dart';

class ShowHW extends StatefulWidget {
  const ShowHW({super.key});

  @override
  State<ShowHW> createState() => _ShowHWState();
}

class _ShowHWState extends State<ShowHW> {
  SqlDb sqlDb = SqlDb();
  StreamController<List<Map<String, dynamic>>> dataStreamcon =
      StreamController<List<Map<String, dynamic>>>();
  Stream<List<Map<String, dynamic>>> get dataStream => dataStreamcon.stream;

  getNameLec() async {
    List<Map<String, dynamic>> respone = await sqlDb.readData(
        // "select Lec.name,HW.idLec,HW.id,HW.content,HW.Deltime,HW.fav from HW  join Lec on Lec.id=HW.idLec ");
        "select HW.*,Lec.name  from HW inner join Lec on HW.idLec=Lec.id ");
    // "select * from HW");

    dataStreamcon.add(respone);

    print(respone);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    getNameLec();

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
                        return HomeWork(
                            idLec: snapshot.data![index]["idLec"],
                            nameLec: snapshot.data![index]["name"],
                            content: snapshot.data![index]["content"],
                            deltime: snapshot.data![index]["Deltime"],
                            fav: snapshot.data![index]["fav"],
                            id: snapshot.data![index]["id"]);
                      },
                    ));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  custtomText("Name"),
                                  custtomText("Content"),
                                  custtomText("DelyTime"),
                                  custtomText("Done"),
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
                                    snapshot.data![index]["name"].toString()),
                                custtomTextSubTitle(
                                    snapshot.data![index]["content"]),
                                custtomTextSubTitle(
                                    snapshot.data![index]["Deltime"]),
                                Checkbox(
                                  value: snapshot.data![index]["fav"] == 1
                                      ? true
                                      : false,
                                  onChanged: (value) async {
                                    print(snapshot);

                                    if (value == true) {
                                      int respone = await sqlDb.updateData('''
                                    update HW set 
                                    content="${snapshot.data![index]["content"]}",                   
                                   
                                    Deltime="${snapshot.data![index]["Deltime"]}",
                                     fav=1
                                     where id=${snapshot.data![index]["id"]}
                                    ''');
                                      setState(() {
                                        getNameLec();
                                        print("============$respone");
                                      });
                                    } else {
                                      sqlDb.updateData('''
                                    update HW set 
                                    content="${snapshot.data![index]["content"]}",                   
                                   
                                    Deltime="${snapshot.data![index]["Deltime"]}",
                                     fav=0
                                     where id=${snapshot.data![index]["id"]}
                                    ''');
                                      setState(() {
                                        getNameLec();
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
                                      "delete from HW where id=${snapshot.data![index]["id"]}");

                                  if (res > 0) {
                                    awesomdialogInfo(context,
                                        "Deleted Successfully", "Delete");
                                    getNameLec();
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

