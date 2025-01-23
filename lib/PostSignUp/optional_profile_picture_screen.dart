import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

import '../Services/global_methods.dart';

class OptionalProfilePictureScreen extends StatefulWidget {
  const OptionalProfilePictureScreen({super.key});

  @override
  State<OptionalProfilePictureScreen> createState() =>
      _OptionalProfilePictureScreenState();
}

class _OptionalProfilePictureScreenState
    extends State<OptionalProfilePictureScreen> with TickerProviderStateMixin {
  File? imageFile;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  String? imageUrl;

  void _showImageDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              title: Text(
                'Choose an option',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade900,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(color: Colors.deepPurple.shade100),
                  ListTile(
                    leading: Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.deepPurple.shade900,
                    ),
                    title: Text(
                      'Take a Picture',
                      style: TextStyle(
                        color: Colors.deepPurple.shade900,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      _getFromCamera();
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.photo_library_rounded,
                      color: Colors.deepPurple.shade900,
                    ),
                    title: Text(
                      'Gallery',
                      style: TextStyle(
                        color: Colors.deepPurple.shade900,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      _getFromGallery();
                    },
                  ),
                ],
              ),
            ));
  }

  void _getFromCamera() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxHeight: 1080,
      maxWidth: 1080,
      // aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }

  void _submitImage() async {
    if (imageFile != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        final User? user = _auth.currentUser;
        final _uid = user!.uid;

        if (imageFile != null) {
          final ref = FirebaseStorage.instance
              .ref()
              .child('userImages')
              .child('$_uid.jpg');
          await ref.putFile(imageFile!);
          imageUrl = await ref.getDownloadURL();
          FirebaseFirestore.instance.collection('users').doc(_uid).update(({
                'profile': imageUrl,
              }));
        }
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        GlobalMethods.showErrorDialog(error: error.toString(), ctx: context);
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Set Profile Picture")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Would you like to set a profile picture?',
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'This is optional, and you can always add or change it later.',
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: _showImageDialog,
              child: CircleAvatar(
                radius: 120,
                backgroundColor: Colors.lightBlue.shade100,
                backgroundImage:
                    imageFile != null ? FileImage(imageFile!) : null,
                child: imageFile == null
                    ? Icon(Icons.add_a_photo_rounded,
                        size: 60, color: Colors.grey.shade700)
                    : null,
              ),
            ),
            SizedBox(height: 20),
            Text(
              imageFile == null
                  ? 'Tap the circle to upload a profile picture'
                  : '',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.deepPurple,
                      )
                    : FloatingActionButton(
                        onPressed: () {
                          _submitImage();

                          // Navigate to the next screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NextScreen(
                                  data: {}), // Replace with your next screen
                            ),
                          );
                        },
                        child: const Icon(Icons.arrow_forward,
                            color: Colors.white),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Dummy placeholder for the next screen
class NextScreen extends StatelessWidget {
  final Map<String, String> data;

  const NextScreen({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Next Screen")),
      body: Center(
        child: Text("Data: ${data.toString()}"),
      ),
    );
  }
}
