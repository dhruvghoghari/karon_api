import 'package:flutter/material.dart';
import 'package:karon_api/app/views/productcategory.dart';
import 'package:karon_api/app/views/jsonplaceholder/getdummy.dart';
import 'package:karon_api/app/views/profile.dart';

import 'homepage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _tabs =[
    HomePage(),
    ProductCategory(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index){
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile'
          )
        ],
      ),
    );
  }
}
