import 'package:asp/asp.dart';
import 'package:demo/core/common/entities/bottom_nav_config.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:iconly/iconly.dart';

class CurrencyBottomNav extends StatefulWidget {
  const CurrencyBottomNav({
    required this.tabController,
    super.key,
  });
  final TabController tabController;

  @override
  State<CurrencyBottomNav> createState() => _CurrencyBottomNavState();
}

class _CurrencyBottomNavState extends State<CurrencyBottomNav> {
  int currentIndex = 0;
  BottomNavConfig bottomConfig = BottomNavConfig.opt(option: 1);

  @override
  Widget build(BuildContext context) {
    return RxBuilder(
      builder: (_) {
        return SnakeNavigationBar.color(
          elevation: 7,
          behaviour: bottomConfig.snakeBarStyle,
          snakeShape: bottomConfig.snakeShape,
          shape: bottomConfig.bottomBarShape,
          padding: bottomConfig.padding,
          snakeViewColor: context.theme.colorScheme.primary,
          selectedItemColor: bottomConfig.snakeShape == SnakeShape.indicator
              ? context.theme.primaryColor
              : Colors.white,
          unselectedItemColor: context.theme.primaryColor,
          showUnselectedLabels: bottomConfig.showUnselectedLabels,
          showSelectedLabels: bottomConfig.showSelectedLabels,
          currentIndex: currentIndex,
          shadowColor: context.theme.colorScheme.onBackground,
          onTap: (index) {
            widget.tabController.animateTo(index);
            setState(() => currentIndex = index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(IconlyBold.home),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyBold.time_circle),
              label: 'tickets',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyBold.category),
              label: 'calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyBold.profile),
              label: 'microphone',
            ),
          ],
          selectedLabelStyle: const TextStyle(fontSize: 14),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
        );
      },
    );
  }
}
