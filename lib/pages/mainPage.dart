import 'package:flutter/material.dart';
import 'package:konversiapp/pages/calculatePage.dart';
import 'package:konversiapp/pages/introPage.dart';
import 'package:konversiapp/pages/konvertPage.dart';
import 'package:konversiapp/pages/profilePage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _pages = [
    const Intropage(),
    const Konvertpage(),
    const Calculatepage(),
    const Profilepage(),
  ];

  int _selectedIndex = 1;

  void changeIndexPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_selectedIndex],
      bottomNavigationBar: _selectedIndex != 0
          ? ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: Container(
                color: Colors.transparent,
                child: BottomNavigationBar(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  elevation: 0,
                  onTap: changeIndexPage,
                  currentIndex: _selectedIndex,
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.grey,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  type: BottomNavigationBarType.fixed,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.swap_vert),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.calculate),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: '',
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
