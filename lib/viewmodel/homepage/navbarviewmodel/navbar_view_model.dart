import 'package:flutter/material.dart';

class BottomNavigationBarProvider with ChangeNotifier {
  ///set current index to 1 to show message on initial screen
  int _currentIndex = 1;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
