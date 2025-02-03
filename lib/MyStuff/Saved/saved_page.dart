import 'package:flutter/material.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  final List<String> selectedCategories = [];
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
      _showScrollToTopButton = _scrollController.position.pixels > 200;
    });
  }

  void _loadMoreItems() {
    setState(() {
      items.addAll(List.generate(20, (index) => items.length + index));
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
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Item ${items[index]}'),
                    );
                  },
                ),
              ),
            ],
          ),
          if (_showScrollToTopButton)
            Positioned(
              right: 16,
              top: MediaQuery.of(context).size.height / 2 -
                  28, // Adjust for FAB size
              child: FloatingActionButton(
                onPressed: _scrollToTop,
                backgroundColor: Colors.white,
                child: Icon(Icons.arrow_upward),
              ),
            ),
        ],
      ),
    );
  }
}
