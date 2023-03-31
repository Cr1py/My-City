import 'package:flutter/material.dart';

class smallTarget extends StatefulWidget {
  final String path;

  const smallTarget({Key? key,required this.path}): super(key: key);

  @override
  State<smallTarget> createState() => _smallTargetState();
}

class _smallTargetState extends State<smallTarget> {
  late String image = widget.path;

  @override
  Widget build(BuildContext context) {
    return DragTarget(
        builder: (
            BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,
            ) {
          return Container(
            height: 25.0,
            width: 25.0,
            color: Color(0xF72585),
            child: Image.asset('$image'),
          );
        },
        onAccept: (String data) {
          setState(() {
            image = data;
          });
        });
  }
}
