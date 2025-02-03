import 'package:flutter/material.dart';
import 'package:tusk_force/Post/new_offer_page.dart';
import 'package:tusk_force/Post/new_request_page.dart';

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
          leading: IconButton(
              onPressed: Navigator.of(context).canPop()
                  ? Navigator.of(context).pop
                  : null,
              icon: Icon(
                Icons.close_outlined,
                color: Colors.black,
              )),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(20.0),
            child: TabBar(
              tabs: [
                Tab(text: 'New Request'),
                Tab(text: 'New Offer'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            NewRequestPage(),
            NewOfferPage(),
          ],
        ),
      ),
    );
  }
}
