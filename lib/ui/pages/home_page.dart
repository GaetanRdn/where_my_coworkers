import 'package:easymakers_tracker/ui/pages/clients_page.dart';
import 'package:easymakers_tracker/ui/pages/easymakers_page.dart';
import 'package:easymakers_tracker/ui/pages/map_page.dart';
import 'package:easymakers_tracker/ui/pages/missions_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void pageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: PageView(
        physics: const ClampingScrollPhysics(),
        onPageChanged: (index) {
          pageChanged(index);
        },
        controller: _pageController,
        children: const [
          EasymakersPage(),
          ClientsPage(),
          MissionsPage(),
          MapPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.blue,
        currentIndex: _selectedIndex,
        onTap: (index) {
          bottomTapped(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.face), label: 'Easymakers'),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Clients'),
          BottomNavigationBarItem(
              icon: Icon(Icons.military_tech), label: 'Mission'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
        ],
      ),
    );
  }
}

PageController _pageController = PageController(
  initialPage: 0,
  keepPage: true,
);
