import 'package:flutter/material.dart';
import 'package:todo/DB.dart';
import 'package:todo/screen/home_screen.dart';

import '../widget/CusttomText.dart';
import '../widget/custtomDiveder.dart';
import 'addHW.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? query;
  Future readdata() async {
    nameSearch = [];
    List<Map> respone = await sqlDb.readData(
        "select Lec.name,HW.id,HW.idLec,HW.content,HW.DelTIme,Hw.fav  from Lec join HW on Lec.id=HW.idLec where Lec.name || HW.content like '%${searchText.text}%'");

    nameSearch.addAll(respone);

    // List<Map> respone2 = await sqlDb.readData(
    //     "select name from Lec inner join HW on Lec.id=HW.idLec where Lec.id=HW.idLec");
    // nameSearch.addAll(respone2);
    print("========$nameSearch");
  }

  TextEditingController searchText = TextEditingController();
  SqlDb sqlDb = SqlDb();
  List nameSearch = [];
  // List noteSearch = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              searchText.text = "";
              nameSearch = [];

              setState(() {});
            },
            icon: const Icon(
              Icons.close,
              size: 25,
            )),
        title: TextField(
          onChanged: (value) {
            setState(() {
              query = value;
              readdata();
            });
          },
          cursorColor: Colors.amber,
          controller: searchText,
          decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.tealAccent)),
            focusColor: Colors.amber,
            hintText: "Search",
            hintStyle: TextStyle(
                color: Colors.tealAccent, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (context) {
                    return HomeScreen();
                  },
                ), (route) => false);
              },
              icon: const Icon(
                Icons.turn_right,
                size: 25,
              ))
        ],
      ),
      body: nameSearch.isEmpty || searchText.text == ""
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Not Found",
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Transform.rotate(
                    angle: 45,
                    child: const Icon(
                      Icons.warning_rounded,
                      color: Colors.amber,
                      size: 40,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: nameSearch.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return HomeWork(
                              idLec: nameSearch[index]["idLec"],
                              nameLec: nameSearch[index]["name"],
                              content: nameSearch[index]["content"],
                              deltime: nameSearch[index]["Deltime"],
                              fav: nameSearch[index]["fav"],
                              id: nameSearch[index]["id"]);
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    custtomTextSubTitle(
                                        nameSearch[index]["name"].toString()),
                                    custtomTextSubTitle(
                                        nameSearch[index]["content"]),
                                    custtomTextSubTitle(
                                        nameSearch[index]["Deltime"]),
                                    Checkbox(
                                      value: nameSearch[index]["fav"] == 1
                                          ? true
                                          : false,
                                      onChanged: (value) {},
                                    )
                                  ],
                                ),
                              ),
                              const CusttomDivider(),
                            ]),
                      ),
                    ));
              },
            ),
    );
  }
}
