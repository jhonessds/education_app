import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustombottomTabBar extends StatelessWidget {
  const CustombottomTabBar({
    required this.tabController,
    required this.currentIndex,
    required this.setIndex,
    super.key,
  });
  final TabController tabController;
  final int currentIndex;
  final void Function(int) setIndex;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallPhone = screenSize.width <= 360.0;
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (i) {
        tabController.animateTo(i);
        setIndex(i);
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const FaIcon(FontAwesomeIcons.bus, size: 20),
          label: 'translation().travel',
          backgroundColor: Theme.of(context).cardColor,
        ),
        BottomNavigationBarItem(
          icon: const FaIcon(FontAwesomeIcons.house, size: 20),
          label: 'home',
          backgroundColor: Theme.of(context).cardColor,
        ),
        BottomNavigationBarItem(
          icon: const FaIcon(FontAwesomeIcons.trophy, size: 20),
          label: 'translation().points',
          backgroundColor: Theme.of(context).cardColor,
        ),
      ],
      type: BottomNavigationBarType.shifting,
      showUnselectedLabels: true,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Theme.of(context).disabledColor,
      selectedLabelStyle: TextStyle(
        fontSize: isSmallPhone ? 9 : 11,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
