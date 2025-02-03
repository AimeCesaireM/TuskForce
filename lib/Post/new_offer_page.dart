import 'package:flutter/material.dart';

class NewOfferPage extends StatefulWidget {
  const NewOfferPage({super.key});

  @override
  State<NewOfferPage> createState() => _NewOfferPageState();
}

class _NewOfferPageState extends State<NewOfferPage> {
  bool isService = true;
  bool isProduct = false;
  String selectedCategory = 'Beauty';
  final List<String> categories = [
    'Beauty', 'Clothing', 'Rideshare', 'Electronics', 'Home Goods', 'Books',
    'Toys', 'Outdoors', 'Tutoring', 'Entertainment', 'Design', 'Content Creation',
    'Event Services', 'Other'
  ];

  void _uploadImage() {
    // Handle image upload
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Product'),
                SizedBox(width: 20),
                Switch(
                  value: isService,
                  onChanged: (value) {
                    setState(() {
                      isService = value;
                      isProduct = !value;
                    });
                  },
                ),
                SizedBox(width: 20),
                Text('Service'),
              ],
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
            ),
            SizedBox(height: 20,),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            if (isProduct)
              Column(
                children: [
                  SizedBox(height: 20),
                  OutlinedButton.icon(
                    onPressed: _uploadImage,
                    icon: Icon(Icons.upload_outlined),
                    label: Text('Upload Picture'),
                  ),
                ],
              ),
            SizedBox(height: 50),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    side: BorderSide(color: Colors.black),
                  ),
                ),
                onPressed: () {
                  // Handle submit action
                },
                child: Text('Post'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}