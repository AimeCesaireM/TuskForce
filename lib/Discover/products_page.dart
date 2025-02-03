import 'package:flutter/material.dart';
import 'package:tusk_force/Global/global_vars.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
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
      _showScrollToTopButton = _scrollController.position.pixels > 500;
    });
  }

  void _loadMoreItems() {
    setState(() {
      items.addAll(List.generate(20, (index) => items.length + index));
    });
  }

  void _onCategorySelected(String category) {
    setState(() {
      if (selectedCategories.contains(category)) {
        selectedCategories.remove(category);
      } else {
        selectedCategories.add(category);
      }
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
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = selectedCategories.contains(category);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (selected) {
                          _onCategorySelected(category);
                        },
                        shape: StadiumBorder(
                          side: BorderSide(
                            color: isSelected ? Colors.deepPurple : Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: GridView.builder(
                  controller: _scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Center(
                        child: Text('Item ${items[index]}'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          if (_showScrollToTopButton)
            Positioned(
              right: 16,
              top: MediaQuery.of(context).size.height / 2 - 28,
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
