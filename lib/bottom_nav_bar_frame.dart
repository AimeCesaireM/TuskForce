import 'package:flutter/material.dart';
import 'package:tusk_force/Home/home_screen.dart';

class BottomNavBarFrame extends StatefulWidget {
  @override
  _BottomNavBarFrameState createState() => _BottomNavBarFrameState();
}

class _BottomNavBarFrameState extends State<BottomNavBarFrame> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Text('Discover Screen'),
    Text('Post Screen'),
    Text('My Stuff Screen'),
    Text('Profile Screen'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 40),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'My Stuff',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade500,
        backgroundColor: Colors.grey.shade900,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}