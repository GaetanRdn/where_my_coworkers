
import 'package:easymakers_tracker/client_form.dart';
import 'package:easymakers_tracker/easymaker_form.dart';
import 'package:easymakers_tracker/easymaker_storage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

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
        children: [
          EasymakerFormPage(storage: EasymakerStorage()),
          const ClientFormPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          bottomTapped(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.face), label: 'Easymakers'),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Clients'),
        ],
      ),
    );
  }
}

PageController _pageController = PageController(
  initialPage: 0,
  keepPage: true,
);
