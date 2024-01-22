import 'package:demo/core/common/app/providers/tab_navigator.dart';
import 'package:demo/core/common/views/persistent_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardController extends ChangeNotifier {
  List<int> _indexHistory = [0];

  final List<Widget> _screens = [
    ChangeNotifierProvider(
      create: (context) => TabNavigator(TabItem(child: const Placeholder())),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (context) => TabNavigator(TabItem(child: const Placeholder())),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (context) => TabNavigator(TabItem(child: const Placeholder())),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (context) => TabNavigator(TabItem(child: const Placeholder())),
      child: const PersistentView(),
    ),
  ];

  List<Widget> get screens => _screens;

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  bool isSelected(int value) => _currentIndex == value;

  void changeIndex(int index) {
    if (index == _currentIndex) return;
    _currentIndex = index;
    _indexHistory.add(index);
    notifyListeners();
  }

  void goBack() {
    if (_indexHistory.length == 1) return;
    _indexHistory.removeLast();
    _currentIndex = _indexHistory.last;
    notifyListeners();
  }

  void resetIndex() {
    _indexHistory = [0];
    _currentIndex = 0;
    notifyListeners();
  }
}
