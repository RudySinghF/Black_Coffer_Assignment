import 'package:black_coffer/CreateVideo.dart';
import 'package:black_coffer/Home.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  int _selectedIndex = 0;
  @override
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Record(),
    Text(
      'Index 3: Settings',
      // style: optionStyle,
    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: _selectedIndex,
          elevation: 0.0,
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: "Explore",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_rounded), label: "Create"),
            BottomNavigationBarItem(icon: Icon(Icons.folder), label: "Library")
          ]),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Color.fromARGB(255, 15, 82, 182),
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: ((context) => quizcreator())));
      //   },
      // ),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
