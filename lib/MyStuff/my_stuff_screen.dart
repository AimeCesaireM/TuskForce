import 'package:flutter/material.dart';
import 'package:tusk_force/MyStuff/Messages/messages_page.dart';
import 'package:tusk_force/MyStuff/Requests/requests_page.dart';
import 'package:tusk_force/MyStuff/Saved/saved_page.dart';

import 'Offers/offers_page.dart';

class MyStuffScreen extends StatefulWidget {
  const MyStuffScreen({super.key});

  @override
  State<MyStuffScreen> createState() => _MyStuffScreenState();
}

class _MyStuffScreenState extends State<MyStuffScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                TabBar(
                  tabAlignment: TabAlignment.start,
                  controller: _tabController,
                  isScrollable: true,
                  tabs: [
                    Tab(text: 'Messages'),
                    Tab(text: 'Requests'),
                    Tab(text: 'Offers'),
                    Tab(text: 'Saved'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MessagesPage(),
          RequestsPage(),
          OffersPage(),
          SavedPage(),
        ],
      ),
    );
  }
}
