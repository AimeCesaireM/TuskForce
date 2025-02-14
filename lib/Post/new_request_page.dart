import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../Global/global_vars.dart';

class NewRequestPage extends StatefulWidget {
  const NewRequestPage({super.key});

  @override
  State<NewRequestPage> createState() => _NewRequestPageState();
}

class _NewRequestPageState extends State<NewRequestPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();

  bool isService = false;
  String selectedCategory = categories[0];
  DateTime? picked;
  Timestamp? pickedTimestamp;

  final _formKey = GlobalKey<FormState>();
  bool _isUploading = false;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Handle form submission
      Uuid uuid = Uuid();
      final String postID = uuid.v4();
      User? user = FirebaseAuth.instance.currentUser;
      final String? userID = user?.uid;

      final String title = _titleController.text;
      final String description = _descriptionController.text;
      final String price = _priceController.text;
      final String deadline = _deadlineController.text;
      final String category = selectedCategory;
      final bool isService = this.isService;
      final bool isOffer = true;

      setState(() {
        _isUploading = true;
      });

      try {
        await FirebaseFirestore.instance.collection('posts').doc(postID).set({
          'postID': postID,
          'userID': userID,
          'username': user?.displayName,
          'profilePic': user?.photoURL,
          'email': user?.email,
          'title': title,
          'description': description,
          'price': price,
          'deadline': deadline,
          'deadlineTimestamp': pickedTimestamp,
          'category': category,
          'isService': isService,
          'isOffer': isOffer,
          'createdAt': Timestamp.now(),
          'tags': [],
          'recruitment': true,
        });
        setState(() {
          _isUploading = false;
        });

        await Fluttertoast.showToast(
          msg: 'Post successful',
          toastLength: Toast.LENGTH_LONG,
        );
        Navigator.pop(context);
      } catch (e) {
        setState(() {
          _isUploading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to post: $e')),
        );
      } finally {
        setState(() {
          _isUploading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all required fields')),
      );
    }
  }

  Future<void> _selectDeadline(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _deadlineController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Product'),
                  SizedBox(width: 10),
                  Switch(
                    value: isService,
                    onChanged: (value) {
                      setState(() {
                        isService = value;
                      });
                    },
                  ),
                  SizedBox(width: 10),
                  Text('Service'),
                ],
              ),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  if (value == 'Any') {
                    return "'Any' is not a valid category.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _deadlineController,
                decoration: InputDecoration(
                  labelText: 'Deadline',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
                readOnly: true,
                onTap: () => _selectDeadline(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a deadline';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              Center(
                child: _isUploading
                    ? CircularProgressIndicator()
                    : OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                            side: BorderSide(color: Colors.black),
                          ),
                        ),
                        onPressed: _submitForm,
                        child: Text('Post'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
