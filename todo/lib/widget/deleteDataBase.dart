// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

import 'package:todo/DB.dart';
import 'package:todo/widget/awesomDialog.dart';

// ignore: must_be_immutable
class DeletDataBase extends StatelessWidget {
  DeletDataBase({super.key});
  SqlDb sqlDb = SqlDb();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () async {
                await awesomdialog(context, () async {
                  await sqlDb.deleteMyDataBase();

                  await awesomdialogInfo(
                      context, "Delete Done Restart Your App", "Delete");
                  // Restart.restartApp();
                }, "Are You Sure From Delete DataBase", "Delete All Data");
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
                size: 23,
              )),
          const Text(
            "Delete DataBase",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
