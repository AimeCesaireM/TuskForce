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
  PostScreen postScreen = PostScreen();

  static final List<Widget> _navbarDestinations = <Widget>[
    const HomeScreen(),
    const DiscoverScreen(),
    const MyStuffScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostButtonTapped() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => postScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _navbarDestinations,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPostButtonTapped,
        backgroundColor: Colors.deepPurple.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        // backgroundColor: Colors.blue,
        child: Icon(Icons.add_circle_outline_rounded, size: 40),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
