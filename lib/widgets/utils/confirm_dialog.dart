import 'package:flutter/material.dart';
import 'cartoon_text.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      backgroundColor: Color.fromRGBO(0, 180, 255, 1),
      contentPadding: EdgeInsets.fromLTRB(
          0,
          MediaQuery.of(context).size.height * 0.04,
          0,
          MediaQuery.of(context).size.height * 0.025),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CartoonText(
            text: 'Are you sure?',
            textSize: 24.0,
            strokeWidth: 1.5,
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        TextButton(
          //Color.fromRGBO(0, 180, 255, 1)
          child: CartoonText(
            text: 'No',
            textSize: 20,
            strokeWidth: 1,
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          child: CartoonText(
            text: 'Yes',
            textSize: 20,
            strokeWidth: 1,
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
