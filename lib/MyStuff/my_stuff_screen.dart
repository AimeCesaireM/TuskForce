import 'package:flutter/material.dart';

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
        title: Text(
          'My Stuff',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(0.0),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                TabBar(
                  tabAlignment: TabAlignment.start,
                  controller: _tabController,
                  isScrollable: true,
                  padding: EdgeInsets.all(0.0),
                  tabs: [
                    Tab(text: 'Messages'),
                    Tab(text: 'Requests'),
                    Tab(text: 'Offers'),
                    Tab(text: 'Lists'),
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
          Center(child: Text('Messages Page')),
          Center(child: Text('My Requests Page')),
          Center(child: Text('My Offers Page')),
          Center(child: Text('My Lists Page')),
        ],
      ),
    );
  }
}
