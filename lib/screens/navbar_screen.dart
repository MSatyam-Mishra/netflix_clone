// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:Netflix/cubits/cubits.dart';
import 'package:Netflix/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({Key? key}) : super(key: key);

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _currentIndex = 0;
  final List _screens = [
    MyHomePage(
      key: PageStorageKey('homeScreen'),
    ),
    SearchScreen(key:PageStorageKey('searchScreen')),
    Scaffold(),
    Scaffold(),
    Scaffold()
  ];
  final Map _navbarIcons = {
    'Home': (Icons.home_rounded),
    'Search': (Icons.search_rounded),
    'Coming soon': (Icons.upcoming),
    'Downloads': (Icons.download_rounded),
    'More': (Icons.menu_rounded),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AppBarCubit>(
        create: (_) => AppBarCubit(),
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.white,
          selectedFontSize: 12,
          unselectedItemColor: Colors.grey,
          unselectedFontSize: 12,
          onTap: (i) => setState(() {
                _currentIndex = i;
              }),
          items: _navbarIcons
              .map(
                (title, icon) => MapEntry(
                  title,
                  BottomNavigationBarItem(
                    icon: Icon(
                      icon,
                      size: 30,
                    ),
                    label: title,
                  ),
                ),
              )
              .values
              .toList()),
    );
  }
}
