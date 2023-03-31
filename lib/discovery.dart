import 'package:flutter/cupertino.dart';
import 'preview.dart';

class discovery extends StatefulWidget {
  const discovery({Key? key}) : super(key: key);

  @override
  State<discovery> createState() => _discoveryState();
}

class _discoveryState extends State<discovery> {
  Color base = Color.fromRGBO(19, 42, 19, 0.9);


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          child: Preview(listName: 0),
          decoration: BoxDecoration(
            color: base,
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: 370,
          width: 370,
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.all(20),
        ),
        Container(
          child: Text("London Ontario Neighboorhood Changed???"),
        ),
        Container(
          child: Preview(listName: 1),
          decoration: BoxDecoration(
            color: base,
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: 370,
          width: 370,
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.all(20),
        ),
        Container(
          child: Text("What if there were only houses?")
        ),
        Container(
          child: Preview(listName: 2),
          decoration: BoxDecoration(
            color: base,
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: 370,
          width: 370,
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.all(20),
        ),
        Container(
          child: Text("This is the limit of my creativity..."),
        )
      ]
    );
  }
}
