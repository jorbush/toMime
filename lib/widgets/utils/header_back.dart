import 'package:flutter/material.dart';
import 'package:to_mime/widgets/utils/cartoon_text.dart';

class HeaderBack extends StatelessWidget {
  final String text;

  const HeaderBack({this.text = null});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(0, mediaQuery.size.height * 0.07, 0, 0),
      child: Stack(
        children: [
          Row(children: [
            Padding(
              padding:
                  EdgeInsets.fromLTRB(mediaQuery.size.width * 0.02, 0, 0, 0),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.white,
              ),
            ),
          ]),
          if (text != null)
            Padding(
              padding:
                  EdgeInsets.fromLTRB(0, mediaQuery.size.height * 0.04, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CartoonText(text: text, textSize: 40.0),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
