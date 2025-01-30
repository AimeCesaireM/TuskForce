import 'package:flutter/material.dart';
import 'package:tusk_force/Home/home_screen.dart';
import 'package:tusk_force/MyStuff/my_stuff_screen.dart';
import 'package:tusk_force/Profile/profile_screen.dart';

import 'Discover/discover_screen.dart';
import 'Post/post_screen.dart';

class Frame extends StatefulWidget {
  Frame({super.key});

  @override
  _FrameState createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  int _selectedIndex = 0;

  static final List<Widget> _navbarDestinations = <Widget>[
    const HomeScreen(),
    const DiscoverScreen(),
    const PostScreen(),
    const MyStuffScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _navbarDestinations,
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
