import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../DB.dart';
import '../main.dart';
import '../screen/Setting.dart';

import 'deleteDataBase.dart';

class CusttomDrawer extends StatefulWidget {
  const CusttomDrawer({super.key});

  @override
  State<CusttomDrawer> createState() => _CusttomDrawerState();
}

bool statu = false;
SqlDb sqlDb = SqlDb();

class _CusttomDrawerState extends State<CusttomDrawer> {
  File? file;

  Image? image;
  List? respone;
  String? encodedIma;
  imgInFile() async {
    final imgByte = await rootBundle.load("images/google.jpg");
    final bytes = imgByte.buffer.asUint8List();
    encodedIma = base64.encode(bytes);
  }

  getDataSett() async {
    respone = await sqlDb.readData('''
select * from Setteing

''');
    if (respone!.isNotEmpty) {
      setState(() {});
      print("============$respone");
      if (respone![0]["image"] == null) return;

      file = await File(respone![0]['image']);

      setState(() {});
    }
  }

  @override
  void initState() {
    imgInFile();
    getDataSett();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (respone != null) {
      return Drawer(
        child: ListView(children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(17),
                width: 70,
                height: 70,
                child: Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: image ??
                        (file == null
                            ? Image.asset(
                                "images/google.jpg",
                              )
                            : Image.file(file!)),
                  ),
                  Positioned(
                    bottom: 2,
                    right: 1,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green),
                      child: IconButton(
                        icon: const Icon(
                          Icons.add_a_photo_sharp,
                          size: 18,
                        ),
                        onPressed: () async {
                          // await getImage();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return Settings(
                                image: respone![0]["image"].toString(),
                                id: respone![0]["id"],
                                name: respone![0]["name"],
                                desc: respone![0]["desc"],
                              );
                            },
                          ));
                        },
                      ),
                    ),
                  )
                ]),
              ),
              Expanded(
                child: ListTile(
                  title: Text("${respone![0]["name"]}"),
                  subtitle: Text(respone![0]["desc"]),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.all(26.0),
            child: ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.orange,
              ),
              title: Text("Settings"),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: SwitchListTile(
              onChanged: (value) {
                setState(() {
                  statu = value;
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                    builder: (context) {
                      return MyApp();
                    },
                  ), (route) => false);
                });
              },
              value: statu,
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.mode_night,
                    color: Colors.black45,
                  ),
                  Text("Mode Night"),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          DeletDataBase(),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              SystemNavigator.pop();
            },
            child: Card(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.logout,
                      size: 25,
                      color: Colors.pinkAccent,
                    ),
                    Text(
                      "Logout",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      );
    }
    return Drawer(
      child: ListView(children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.all(17),
              width: 70,
              height: 70,
              child: Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: (file == null
                      ? Image.asset(
                          "images/google.jpg",
                        )
                      : Image.file(file!)),
                ),
                Positioned(
                  bottom: 2,
                  right: 1,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green),
                    child: IconButton(
                      icon: const Icon(
                        Icons.add_a_photo_sharp,
                        size: 18,
                      ),
                      onPressed: () async {
                        // await getImage();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return Settings(
                              image: "$encodedIma",
                              id: 1,
                              name: "",
                              desc: "",
                            );
                          },
                        ));
                      },
                    ),
                  ),
                )
              ]),
            ),
            const Expanded(
              child: ListTile(
                title: Text("Your Name"),
                subtitle: Text("About You"),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        const Padding(
          padding: EdgeInsets.all(26.0),
          child: ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.orange,
            ),
            title: Text("Settings"),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: SwitchListTile(
            onChanged: (value) {
              setState(() {
                statu = value;
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (context) {
                    return MyApp();
                  },
                ), (route) => false);
              });
            },
            value: statu,
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.mode_night,
                  color: Colors.black45,
                ),
                Text("Mode Night"),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        DeletDataBase(),
        const SizedBox(
          height: 30,
        ),
        InkWell(
          onTap: () {
            SystemNavigator.pop();
          },
          child: Card(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.logout,
                    size: 25,
                    color: Colors.pinkAccent,
                  ),
                  Text(
                    "Logout",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
