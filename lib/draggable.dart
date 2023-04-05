import 'package:flutter/material.dart';

class dragTarget extends StatefulWidget {
  final String path;

  const dragTarget({Key? key,required this.path}): super(key: key);

  @override
  State<dragTarget> createState() => _dragTargetState();
}

class _dragTargetState extends State<dragTarget> {
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
          height: 45.0,
          width: 45.0,
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
