import 'package:flutter/material.dart';
import 'package:tusk_force/Profile/Reviews/about_me_page.dart';
import 'package:tusk_force/Profile/Reviews/by_me_page.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        title: Text('My Reviews'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'By Me'),
            Tab(text: 'About Me'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ByMePage(),
          AboutMePage(),
        ],
      ),
    );
  }
}
