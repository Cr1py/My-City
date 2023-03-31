import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Post {
  String? key;
  String? title;
  String? description;
  String? imgUrl;
  String? author;
  int? votes;
  int? timestamp;

  Post({
    this.key,
    required this.title,
    required this.description,
    required this.imgUrl,
    required this.author,
    required this.votes,
    required this.timestamp,
  });

  Post.fromSnapshot(DataSnapshot snapshot) {
    key = snapshot.key;
    title = snapshot.value['title'];
    description = snapshot.value['description'];
    imgUrl = snapshot.value['imgUrl'];
    author = snapshot.value['author'];
    votes = snapshot.value['votes'];
    timestamp = snapshot.value['timestamp'];
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'imgUrl': imgUrl,
      'author': author,
      'votes': votes,
      'timestamp': timestamp,
    };
  }

}

class PostTile extends StatefulWidget {
  final Post post;

  PostTile({required this.post});

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  final DatabaseReference dbRef =
  FirebaseDatabase.instance.reference().child('posts');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to the post's details page

      },
      child: Card(
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Text(
                widget.post.title!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            CachedNetworkImage(
              imageUrl: widget.post.imgUrl!,
              fit: BoxFit.cover,
              height: 200,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                widget.post.description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'by ${widget.post.author}',
                    style: TextStyle(fontSize: 12),
                  ),
                  Row(
                    children: [
                      Icon(Icons.arrow_upward_outlined, size: 16),
                      SizedBox(width: 4),
                      Text(
                        '${widget.post.votes}',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
