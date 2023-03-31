import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycity/viewpost.dart';

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
  final DatabaseReference dbRef = FirebaseDatabase.instance.reference().child('posts');

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Discovery'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                _showSearchDialog(context);
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list), // by votes
            onPressed: () {
              setState(() {
                dbRef.orderByChild('votes').once();
                Navigator.pop(context);
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _signOut(context);
            },
          ),
        ],
      ),

      body: Center(
        child: FutureBuilder(
          future: dbRef.once(),
          builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
            if (snapshot.hasData) {
              List<Post> posts = [];
              Map<dynamic, dynamic> values = snapshot.data!.value;
              if (values != null) {
                values.forEach((key, value) {
                  posts.add(Post.fromSnapshot(value));
                });
              }
              return StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostDetailScreen(post: posts[index]),
                          ),
                        );
                      },
                      child: CachedNetworkImage(
                        imageUrl: posts[index].imgUrl!,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                staggeredTileBuilder: (int index) => StaggeredTile.count(2, index.isEven ? 3 : 2),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),

      // TODO: bottom nav bar

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
