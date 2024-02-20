// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/widget/custtomButton.dart';
import 'package:todo/widget/textFaild.dart';

import '../showData/method/methodDelete.dart';
import '../widget/awesomDialog.dart';
import 'home_screen.dart';

class Settings extends StatefulWidget {
  const Settings(
      {super.key,
      required this.name,
      required this.desc,
      required this.id,
      required this.image});
  final String name;
  final String desc;
  final String image;
  final int id;
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  File? file;
  Uint8List? imageByte;
  String? encodedImage;
  Image? image;
  //-------------------getdat from DB
  getDataSett() async {
    List respone = await sqlDb.readData('''
select * from Setteing
  
''');

    if (respone.isNotEmpty) {
      if (respone[0]["image"] == null) return;
      file = File(respone[0]['image']);

      if (file == null) return;

      setState(() {});
    } else {
      return;
    }
  }

  //-------------------------
  getImage(String choice) async {
    final ImagePicker picker = ImagePicker();
    if (choice == "camira") {
      final XFile? imagec = await picker.pickImage(source: ImageSource.camera);
      setState(() {});
      if (imagec != null) {
        file = File(imagec.path);
        image = null;
        setState(() {});
      }
    } else {
      final XFile? imageG = await picker.pickImage(source: ImageSource.gallery);
      setState(() {});
      if (imageG != null) {
        file = File(imageG.path);
        image = null;
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    getDataSett();

    name.text = widget.name;
    desc.text = widget.desc;
    encodedImage = widget.image;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                CusttomFaild(
                  hintText: "Enter Your Name",
                  title: "Name ",
                  controller: name,
                ),
                CusttomFaild(
                  hintText: "Enter Description About You",
                  title: "Desc :",
                  controller: desc,
                ),
              ],
            ),
          ),
          CusttomButton(
            title: "Upload Image",
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.all(18),
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 97, 87, 57),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {
                              getImage("camira");
                            },
                            icon: const Icon(Icons.camera_alt)),
                        IconButton(
                            onPressed: () {
                              getImage("gallary");
                            },
                            icon: const Icon(Icons.image_rounded)),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          InteractiveViewer(
            maxScale: 4.5,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(500),
                  child: image ??
                      (file == null
                          ? Image.asset(
                              "images/google.jpg",
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              file!,
                              height: 300,
                              fit: BoxFit.fitWidth,
                            ))),
            ),
          ),
          CusttomButton(
            title: "Save",
            onPressed: () async {
              int respone = await sqlDb.insertData('''update Setteing set 
                  name='${name.text}',
                  desc='${desc.text}',
                 
                  image='${file!.path}'
                  
                   where id=1''');

              if (respone > 0) {
                await awesomdialogInfo(context, "Edit Successfully", "Edit");

                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (context) {
                    return const HomeScreen();
                  },
                ), (route) => false);
              } else {
                int respone = await sqlDb.insertData(
                    "insert into Setteing (name,desc, image) values ('${name.text}','${desc.text}','${file!.path}')");

                if (respone > 0) {
                  await awesomdialogInfo(context, "Add Successfully", "Add");

                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                    builder: (context) {
                      return const HomeScreen();
                    },
                  ), (route) => false);
                }
              }
            },
          ),
          const SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }
}
