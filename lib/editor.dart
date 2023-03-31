import 'package:flutter/material.dart';
import 'data.dart';
import 'preview.dart';
import 'draggable.dart';


class Editor_Home extends StatefulWidget {
  const Editor_Home({Key? key}) : super(key: key);

  @override
  State<Editor_Home> createState() => _Editor_HomeState();
}

class _Editor_HomeState extends State<Editor_Home> {
  int index = 0;
  final _buildBody = const <Widget> [Editor(), Preview(listName: 2)];

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('My City: Editor'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        drawer: Drawer(
        ),
        bottomNavigationBar: BottomNavigationBar(
            elevation: 20,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Editor',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          currentIndex: index,
          onTap: (x) {
            setState(() {
              index = x;
            });
          }
          ),
        body: _buildBody[index],
    );
  }
}


class Editor extends StatefulWidget {
  const Editor({Key? key}) : super(key: key);

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  double size = 55.0;
  Color base = Color.fromRGBO(19, 42, 19, 0.9);
  Color light = Color.fromRGBO(236, 243, 158, 1.0);
  Color Celeste = Color.fromRGBO(181, 146, 160, 1.0);

  List<dragTarget> getTargets(int count, int increment){
    List<dragTarget> list = [];

    for (int i = count; i < count + increment; i++){
      String image = imageList[1][i];
      var newItem = dragTarget(path: "$image");

      list.add(newItem);
    }

    return list;
  }

  List<Widget> getRows(){
    List<Row> rows = [];
    int count = 0;
    int increment = 8;
    int numRows = 11;

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: base,
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Draggable(
                data: 'assets/road-vert.png',
                feedback: Container(
                    decoration: BoxDecoration(
                      color: light,
                      border: Border.all(
                        color: Celeste,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    width: size,
                    height: size,
                    padding: EdgeInsets.all(3.0),
                    transform: Matrix4.rotationZ(0.2),
                    child: Image.asset('assets/road-vert.png')
                ),
                child: Container(
                    decoration: BoxDecoration(
                      color: light,
                      border: Border.all(
                        color: Celeste,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(3.0),
                    height: size,
                    width: size,
                    child: Image.asset('assets/road-vert.png')
                ),
              ),
              Draggable(
                data: 'assets/road-hori.png',
                feedback: Container(
                    decoration: BoxDecoration(
                      color: light,
                      border: Border.all(
                        color: Celeste,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(3.0),
                    width: size,
                    height: size,
                    transform: Matrix4.rotationZ(0.2),
                    child: Image.asset('assets/road-hori.png')
                ),
                child: Container(
                    decoration: BoxDecoration(
                      color: light,
                      border: Border.all(
                        color: Celeste,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(3.0),
                    height: size,
                    width: size,
                    child: Image.asset('assets/road-hori.png')
                ),
              ),
              Draggable(
                data: 'assets/house.png',
                feedback: Container(
                    decoration: BoxDecoration(
                      color: light,
                      border: Border.all(
                        color: Celeste,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(3.0),
                    width: size,
                    height: size,
                    transform: Matrix4.rotationZ(0.2),
                    child: Image.asset('assets/house.png')
                ),
                child: Container(
                    decoration: BoxDecoration(
                      color: light,
                      border: Border.all(
                        color: Celeste,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(3.0),
                    height: size,
                    width: size,
                    child: Image.asset('assets/house.png')
                ),
              ),
              Draggable(
                data: 'assets/building.png',
                feedback: Container(
                    decoration: BoxDecoration(
                      color: light,
                      border: Border.all(
                        color: Celeste,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(3.0),
                    width: size,
                    height: size,
                    transform: Matrix4.rotationZ(0.2),
                    child: Image.asset('assets/building.png')
                ),
                child: Container(
                    decoration: BoxDecoration(
                      color: light,
                      border: Border.all(
                        color: Celeste,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(3.0),
                    height: size,
                    width: size,
                    child: Image.asset('assets/building.png')
                ),
              ),
              Draggable(
                data: 'assets/park.png',
                feedback: Container(
                    decoration: BoxDecoration(
                      color: light,
                      border: Border.all(
                        color: Celeste,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(3.0),
                    width: size,
                    height: size,
                    transform: Matrix4.rotationZ(0.2),
                    child: Image.asset('assets/park.png')
                ),
                child: Container(
                    decoration: BoxDecoration(
                      color: light,
                      border: Border.all(
                        color: Celeste,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(3.0),
                    height: size,
                    width: size,
                    child: Image.asset('assets/park.png')
                ),
              ),
              Draggable(
                data: 'assets/intersection.png',
                feedback: Container(
                    decoration: BoxDecoration(
                      color: light,
                      border: Border.all(
                        color: Celeste,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(3.0),
                    width: size,
                    height: size,
                    transform: Matrix4.rotationZ(0.2),
                    child: Image.asset('assets/intersection.png')
                ),
                child: Container(
                    decoration: BoxDecoration(
                      color: light,
                      border: Border.all(
                        color: Celeste,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(3.0),
                    height: size,
                    width: size,
                    child: Image.asset('assets/intersection.png')
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 10.0,
        ),
        ...getRows(),
      ],
    );
  }
}