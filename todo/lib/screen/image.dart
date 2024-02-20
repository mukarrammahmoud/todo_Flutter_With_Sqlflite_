import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/DB.dart';

class ImageDB extends StatefulWidget {
  const ImageDB({super.key});

  @override
  State<ImageDB> createState() => _ImageDBState();
}

class _ImageDBState extends State<ImageDB> {
  SqlDb sqlDb = SqlDb();
  File? file;
  getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagec = await picker.pickImage(source: ImageSource.camera);
    file = File(imagec!.path);
    print(file);
    setState(() {});
  }

  writeData() async {
    int respone = await sqlDb
        .insertData("insert into images (image) values('${file!.path}')");
    if (respone > 0) {
      print("==========================successfully");
    }
  }

  List? resopne;
  getImageDB() async {
    resopne = await sqlDb.readData("select image from images");
    file = File(resopne![1]["image"]);
    setState(() {});
    print(file);
    print(resopne);
  }

  @override
  void initState() {
    getImageDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            ElevatedButton(
                onPressed: () {
                  getImage();
                  setState(() {});
                },
                child: Text("Load")),
            if (file != null) Image.file(File(file!.path)),
            ElevatedButton(
                onPressed: () {
                  writeData();
                },
                child: Text("save")),
          ],
        ),
      ),
    );
  }
}
