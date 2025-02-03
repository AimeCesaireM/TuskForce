import 'package:flutter/material.dart';

class ReportABugScreen extends StatelessWidget {
  const ReportABugScreen({super.key});

  void _submitBugReport() {
    // Handle bug report submission
  }

  void _uploadScreenshot() {
    // Handle screenshot upload
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bug Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Description:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
                hintText: 'Please describe the bug.',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Reproduction:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
                hintText: 'How can we reproduce the bug?',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Upload a screenshot (optional):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: _uploadScreenshot,
              icon: Icon(Icons.upload_outlined),
              label: Text('Upload'),
            ),
            SizedBox(height: 40),
            Center(
              child: OutlinedButton(
                onPressed: _submitBugReport,
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(color: Colors.black),
                  ),
                ),
                child: Text('Submit Bug Report'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}