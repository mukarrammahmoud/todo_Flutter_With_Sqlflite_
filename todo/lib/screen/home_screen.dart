import 'package:flutter/material.dart';

import 'package:todo/screen/addLec.dart';
import 'package:todo/screen/addTask.dart';
import 'package:todo/screen/custtomSearchPage.dart';

import 'package:todo/showData/showHW.dart';
import 'package:todo/showData/showLec.dart';
import 'package:todo/showData/showTask.dart';

import 'package:todo/widget/custtomDrawer.dart';
import 'package:todo/widget/custumFloating.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> scafeldKey = GlobalKey();

  int selctedItem = 0;

  @override
  void initState() {
    super.initState();
  }

//---------- This method return page by selItem-------
  Widget showpage() {
    if (selctedItem == 0) {
      return const ShowLec();
    } else if (selctedItem == 1) {
      return const ShowHW();
    }
    return const ShowTask();
  }

  //-----this method return title of page by selItem------------
  String get titlePage {
    if (selctedItem == 0) {
      return "Lecture";
    } else if (selctedItem == 1) {
      return "Home Work";
    }
    return "Task";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafeldKey,
      drawer: const CusttomDrawer(),
      floatingActionButton: CusttomFloatingButton(
          selItem: selctedItem,
          onPressed: () {
            switch (selctedItem) {
              case 0:
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const AddLec(
                      name: "",
                      day: "sun",
                      ftime: "",
                      totime: "",
                      cls: "",
                      id: 0,
                    );
                  },
                ));
                break;

              case 2:
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const Task(
                        name: "", appoint: "", time: "", fav: 0, id: 0);
                  },
                ));
                break;
            }
          },
          icon: const Icon(
            Icons.add_comment,
            color: Colors.white,
          )),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.pinkAccent,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 18,
          unselectedFontSize: 15,
          selectedIconTheme: const IconThemeData(color: Colors.green, size: 26),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          currentIndex: selctedItem,
          onTap: (value) {
            setState(() {
              selctedItem = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.class_,
                ),
                label: "Lec"),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_home_work),
              label: "HW",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.task),
              label: "Task",
            ),
          ]),
      appBar: AppBar(
        centerTitle: true,
        title: Text(titlePage),
        actions: [
          Visibility(
            visible: selctedItem == 1 ? true : false,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  color: Colors.grey[700]),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const SearchPage();
                  }));
                },
                icon: const Icon(Icons.search),
              ),
            ),
          )
        ],
      ),
      body: showpage(),
    );
  }
}
