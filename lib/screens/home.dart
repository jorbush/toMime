import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_mime/widgets/cartoon_text.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 180, 255, 1),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/backgrounds/sky1.png'),
              fit: BoxFit.cover,
            )),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        color: Colors.black,
                        iconSize: 36.0,
                        onPressed: () {
                          Navigator.pushNamed(context, '/settings');
                          print('opening settings');
                        },
                        icon: Icon(Icons.settings),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(36, 10, 36, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CartoonText(
                        text: "TO MIME",
                        textSize: 40.0,
                        fontFamily: 'Pacifico',
                        strokeWidth: 5,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: mediaQuery.size.height * 0.65,
                  child: Container(
                    width: 500.0,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/form');
                      },
                      child: null,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CartoonText(
                          text: "TAP TO START",
                          textSize: 29.0,
                          strokeWidth: 2,
                        )),
                    Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 40.0,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
