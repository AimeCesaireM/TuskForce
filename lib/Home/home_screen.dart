import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tusk_force/Home/tusk_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isListView = true;
  final ScrollController _scrollController = ScrollController();
  List<int> items = List.generate(20, (index) => index); // Initial items
  bool _showScrollToTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreItems();
    }
    setState(() {
      _showScrollToTopButton = _scrollController.position.pixels > 500;
    });
  }

  void _loadMoreItems() {
    setState(() {
      items.addAll(List.generate(20, (index) => items.length + index));
    });
  }

  void _toggleView() {
    setState(() {
      isListView = !isListView;
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(isListView ? Icons.grid_view : Icons.list),
            onPressed: _toggleView,
          ),
        ],
      ),
      body: Stack(
        children: [
          isListView ? _buildListView() : _buildGridView(),
          if (_showScrollToTopButton)
            Positioned(
              right: 16,
              top: MediaQuery.of(context).size.height / 2 -
                  28, // Adjust for FAB size
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                onPressed: _scrollToTop,
                backgroundColor: Colors.white,
                child: Icon(Icons.arrow_upward),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return TuskWidget(
            tuskTitle: 'Title',
            tuskDescription: 'Description',
            tuskPrice: 'Price',
            tuskID: 'ID',
            tuskCategory: 'Category',
            uploaderEmail: 'uploaderEmail',
            uploaderName: 'uploaderName',
            uploaderID: 'uploaderID',
            tuskImage: 'tuskImage',
            uploaderProfilePhoto: 'uploaderProfilePhoto',
            isService: 'isService',
            tuskTags: [],
            isListView: isListView);
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      controller: _scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return TuskWidget(
          tuskTitle: 'Title',
          tuskDescription: 'Description',
          tuskPrice: 'Price',
          tuskID: 'ID',
          tuskCategory: 'Category',
          uploaderEmail: 'uploaderEmail',
          uploaderName: 'uploaderName',
          uploaderID: 'uploaderID',
          tuskImage: 'tuskImage',
          uploaderProfilePhoto: 'uploaderProfilePhoto',
          isService: 'isService',
          tuskTags: [],
          isListView: isListView,
        );
      },
    );
  }
}
