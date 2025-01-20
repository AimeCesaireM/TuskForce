import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

class OptionalProfilePictureScreen extends StatefulWidget {
  final Map<String, String> data;

  const OptionalProfilePictureScreen({required this.data, super.key});

  @override
  State<OptionalProfilePictureScreen> createState() => _OptionalProfilePictureScreenState();
}

class _OptionalProfilePictureScreenState extends State<OptionalProfilePictureScreen> {
  File? _profilePicture;

  Future<void> _pickAndCropImage() async {
    try {
      // Open the image picker
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        // Crop the image in a circular shape
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          // cropStyle: CropStyle.circle,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),

          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Profile Picture',
              toolbarColor: Colors.deepPurple,
              toolbarWidgetColor: Colors.white,
              lockAspectRatio: true,
            ),
            IOSUiSettings(
              title: 'Crop Profile Picture',
            ),
          ],
        );

        if (croppedFile != null) {
          setState(() {
            _profilePicture = File(croppedFile.path);
          });
        }
      }
    } catch (e) {
      // Handle errors if any
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick or crop image: $e')),
      );
    }
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
              onTap: _pickAndCropImage,
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.lightBlue.shade100,
                backgroundImage: _profilePicture != null
                    ? FileImage(_profilePicture!)
                    : null,
                child: _profilePicture == null
                    ? Icon(Icons.add_a_photo_rounded, size: 60, color: Colors.grey.shade700)
                    : null,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Tap the circle to upload a profile picture',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    final profileData = {
                      ...widget.data,
                      if (_profilePicture != null) 'profilePicture': _profilePicture!.path,
                    };

                    // Navigate to the next screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NextScreen(data: profileData), // Replace with your next screen
                      ),
                    );
                  },
                  child: const Icon(Icons.arrow_forward, color: Colors.white),
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
