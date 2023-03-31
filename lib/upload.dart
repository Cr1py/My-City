import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  late File _imageFile;
  final picker = ImagePicker();
  bool _isUploading = false;
  final TextEditingController _titleController = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  Future<void> _uploadImage() async {
    setState(() {
      _isUploading = true;
    });
    try {
      final title = _titleController.text.trim();
      final storage = FirebaseStorage.instance;
      final ref = storage.ref().child('images/$title.png');
      final task = ref.putFile(_imageFile);

      final snapshot = await task.whenComplete(() {});
      final url = await snapshot.ref.getDownloadURL();

      // TODO: save the url and title to Firebase Database

      setState(() {
        _isUploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image uploaded successfully!')),
      );
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: $e')),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () => _pickImage(ImageSource.gallery),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey),
                ),
                child: _imageFile == null
                    ? Icon(Icons.add_photo_alternate)
                    : Image.file(_imageFile),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isUploading ? null : _uploadImage,
              child: Text(_isUploading ? 'Uploading...' : 'Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
