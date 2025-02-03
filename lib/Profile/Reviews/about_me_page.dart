import 'package:flutter/material.dart';

class AboutMePage extends StatefulWidget {
  const AboutMePage({super.key});

  @override
  State<AboutMePage> createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  final ScrollController _scrollController = ScrollController();
  List<int> reviews = List.generate(20, (index) => index); // Initial reviews
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
      _loadMoreReviews();
    }
    setState(() {
      _showScrollToTopButton = _scrollController.position.pixels > 200;
    });
  }

  void _loadMoreReviews() {
    setState(() {
      reviews.addAll(List.generate(20, (index) => reviews.length + index));
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
          ListView.builder(
            controller: _scrollController,
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Review ${reviews[index]}'),
                subtitle: Text('Details for review ${reviews[index]}'),
              );
            },
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
