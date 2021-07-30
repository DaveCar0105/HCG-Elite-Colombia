import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Future<Widget> alertDialogInternet(BuildContext context){
  return showDialog(
          context: context,
          builder: (BuildContext cont) => AlertDialog(
                title: 
                Column(
                  children: [
                    Icon(Icons.help_center_outlined),
                    Text("Error de internet")
                  ],
                ),
                content: Text("Su conexión de internet presenta fallas!!"),
                actions: [
                  CupertinoDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("ok"))
                ],
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(25)
                ),
            )
          );
}
