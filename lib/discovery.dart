import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'preview.dart';

class discovery extends StatefulWidget {
  const discovery({Key? key}) : super(key: key);

  @override
  State<discovery> createState() => _discoveryState();
}

class _discoveryState extends State<discovery> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          alignment: Alignment.center,
          child: Preview(listName: 0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black87,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: 370,
          width: 370,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          margin: EdgeInsets.all(20),
        ),
        Container(
          alignment: Alignment.center,
          child: Text("London Ontario Neighboorhood Changed???",
            style: GoogleFonts.lato(
              fontSize: 19,
              color: Colors.black,
              fontWeight: FontWeight.w900),
            ),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 30)
        ),
        Container(
          alignment: Alignment.center,
          child: Preview(listName: 1),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black87,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: 370,
          width: 370,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          margin: EdgeInsets.all(20),
        ),
        Container(
          alignment: Alignment.center,
          child: Text("Main Street Science world: Vancouver",
            style: GoogleFonts.lato(
            fontSize: 19,
            color: Colors.black,
            fontWeight: FontWeight.w900)),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 30)
        ),
        Container(
          alignment: Alignment.center,
          child: Preview(listName: 2),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black87,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: 370,
          width: 370,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          margin: EdgeInsets.all(20),
        ),
        Container(
            alignment: Alignment.center,
            child: Text("My fun project!",
                style: GoogleFonts.lato(
                    fontSize: 19,
                    color: Colors.black,
                    fontWeight: FontWeight.w900)),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 30)
        ),
      ]
    );
  }
}
