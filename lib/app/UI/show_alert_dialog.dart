
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showAlertDialog(
    @required BuildContext context,
    @required String title,
    @required String content,
    @required String defaultActionText,
    ) async {
  
  return await showDialog(context: context, builder: (context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      elevation: 10.0,
      actions: [
        FlatButton(onPressed:(){
          Navigator.pop(context);
        }, child: Text(defaultActionText))
      ],
    );
  },);

}