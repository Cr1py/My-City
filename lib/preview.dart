import 'package:flutter/material.dart';
import 'data.dart';
import 'small_target.dart';

class Preview extends StatefulWidget {
  final int listName;

  const Preview({Key? key, required this.listName}) : super(key: key);

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  List<smallTarget> getTargets(int count, int increment){
    List<smallTarget> list = [];

    for (int i = count; i < count + increment; i++){
      String image = imageList[widget.listName][i];
      var newItem = smallTarget(path: "$image");

      list.add(newItem);
    }

    return list;
  }

  List<Widget> getRows(){
    List<Row> rows = [];
    int count = 0;
    int increment = 8;
    int numRows = 8;

    for (int i = 0; i < numRows; i++) {
      List targets = getTargets(count, increment);
      var newRow = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...targets,
        ],
      );
      rows.add(newRow);
      count = count + increment;
    }
    return rows;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.0,
      height: 350.0,
      child: Column(
        children: [
          ...getRows(),
        ],
      ),
    );
  }
}


