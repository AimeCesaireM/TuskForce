import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'New Request'),
              Tab(text: 'New Offer'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text('New Request')),
            Center(child: Text('New Offer')),
          ],
        ),
      ),
    );
  }
}