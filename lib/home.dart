import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycity/viewpost.dart';
import 'editor.dart';
import 'discovery.dart';


import 'post.dart';
import 'login.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      initialRoute: '/',
      routes: {
        'homepage': (context) => HomePage(),
        'login': (context) => Login(),
      },
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  final DatabaseReference dbRef = FirebaseDatabase.instance.reference().child('posts');
  final _buildBody = const <Widget> [Home_Page(), Editor()];
  final _AppBarTitle = const <String> ["Discovery", "Editor", "Settings"];
  bool isHome = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text('${_AppBarTitle[index]}'),
        actions: [
          isHome
              ? IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                _showSearchDialog(context);
              });
            },
          )
              : Container(),
          isHome
              ? IconButton(
            icon: Icon(Icons.filter_list), // by votes
            onPressed: () {
              setState(() {
                dbRef.orderByChild('votes').once();
                Navigator.pop(context);
              });
            },
          )
              : Container(),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _signOut(context);
            },
          ),
        ],
      ),

      body: _buildBody[index],

      // TODO: bottom nav bar
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
              if(x == 0){
                isHome = true;
              } else if (x == 1){
                isHome = false;
              }
            });
          }
      ),

    );
  }

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => Login()));
  }

  Future<void> _showSearchDialog(BuildContext context) async {
    String? query = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Search by title'),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Enter a search term',
            ),
            onChanged: (value) {},
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Search'),
              onPressed: () {
                Navigator.pop(context, 'search');
              },
            ),
          ],
        );
      },
    );
    if (query != null && query.isNotEmpty) {
      dbRef
          .orderByChild('title')
          .startAt(query)
          .endAt(query + '\uf8ff')
          .once()
          .then((DataSnapshot snapshot) {
        setState(() {
          // Update the grid view with the search results
          Navigator.pop(context);
          List<Post> searchResults = [];
          Map<dynamic, dynamic> values = snapshot.value;
          if (values != null) {
            values.forEach((key, values) {
              Post post = Post.fromSnapshot(values);
              searchResults.add(post);
            });
          }
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Search Results'),
                content: Container(
                  width: double.maxFinite,
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(8.0),
                    itemCount: searchResults.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return PostTile(post: searchResults[index]);
                    },
                  ),
                ),
              );
            },
          );
        });
      });
    }
  }
}


class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {


  @override
  Widget build(BuildContext context) {
    return const discovery();
  }
}