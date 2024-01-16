import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TabNavigatorProvider extends InheritedNotifier<TabNavigator> {
  const TabNavigatorProvider({
    required super.child,
    required this.navigator,
    super.key,
  }) : super(notifier: navigator);

  final TabNavigator navigator;

  static TabNavigator? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TabNavigatorProvider>()
        ?.navigator;
  }
}

class TabNavigator extends ChangeNotifier {
  TabNavigator(this._initialPage) {
    _navigatioStack.add(_initialPage);
  }

  final TabItem _initialPage;
  final List<TabItem> _navigatioStack = [];

  TabItem get currentPage => _navigatioStack.last;

  void push(TabItem page) {
    _navigatioStack.add(page);
    notifyListeners();
  }

  void pop() {
    if (_navigatioStack.isNotEmpty) {
      _navigatioStack.removeLast();
      notifyListeners();
    }
  }

  void popToRoot() {
    _navigatioStack
      ..clear()
      ..add(_initialPage);
    notifyListeners();
  }

  void popTo(TabItem page) {
    _navigatioStack.remove(page);
    notifyListeners();
  }

  void popUntil(TabItem? page) {
    if (page == null) popToRoot();
    if (_navigatioStack.isNotEmpty) {
      _navigatioStack.removeRange(1, _navigatioStack.indexOf(page!) + 1);
      notifyListeners();
    }
  }

  void pushAndRemoveUntil(TabItem page) {
    _navigatioStack
      ..clear()
      ..add(page);
    notifyListeners();
  }
}

class TabItem extends Equatable {
  TabItem({required this.child}) : id = const Uuid().v4();

  final Widget child;
  final String id;

  @override
  List<dynamic> get props => [id];
}
