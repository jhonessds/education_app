import 'package:asp/asp.dart';
import 'package:demo/app/modules/home/presenter/states/home_state.dart';
import 'package:demo/core/common/entities/bottom_nav_config.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/helpers/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({
    required this.tabController,
    super.key,
  });
  final TabController tabController;

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  @override
  void initState() {
    super.initState();
    AppHelper.getNavOption().then((option) {
      bottomConfigState.value = BottomNavConfig.opt(option: option);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RxBuilder(
      builder: (_) {
        return SnakeNavigationBar.color(
          behaviour: bottomConfigState.value.snakeBarStyle,
          snakeShape: bottomConfigState.value.snakeShape,
          shape: bottomConfigState.value.bottomBarShape,
          padding: bottomConfigState.value.padding,
          snakeViewColor: context.theme.colorScheme.primary,
          selectedItemColor:
              bottomConfigState.value.snakeShape == SnakeShape.indicator
                  ? context.theme.primaryColor
                  : Colors.white,
          unselectedItemColor: context.theme.primaryColor,
          showUnselectedLabels: bottomConfigState.value.showUnselectedLabels,
          showSelectedLabels: bottomConfigState.value.showSelectedLabels,
          currentIndex: indexState.value,
          onTap: (index) {
            widget.tabController.animateTo(index);
            indexState.value = index;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'tickets',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'calendar',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.podcasts),
              label: 'microphone',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          selectedLabelStyle: const TextStyle(fontSize: 14),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
        );
      },
    );
  }
}
