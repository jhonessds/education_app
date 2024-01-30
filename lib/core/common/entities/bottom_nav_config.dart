import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class BottomNavConfig {
  BottomNavConfig({
    required this.id,
    required this.snakeBarStyle,
    required this.snakeShape,
    required this.padding,
    required this.showSelectedLabels,
    required this.showUnselectedLabels,
    this.bottomBarShape,
  });

  factory BottomNavConfig.optZero() {
    return BottomNavConfig(
      id: 0,
      snakeBarStyle: SnakeBarBehaviour.floating,
      snakeShape: SnakeShape.circle,
      padding: const EdgeInsets.all(12),
      bottomBarShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }

  factory BottomNavConfig.opt({required int option}) {
    switch (option) {
      case 0:
        return BottomNavConfig.optZero();
      case 1:
        return BottomNavConfig(
          id: 1,
          snakeBarStyle: SnakeBarBehaviour.pinned,
          snakeShape: SnakeShape.circle,
          padding: EdgeInsets.zero,
          bottomBarShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          showSelectedLabels: false,
          showUnselectedLabels: false,
        );

      case 2:
        return BottomNavConfig(
          id: 2,
          snakeBarStyle: SnakeBarBehaviour.pinned,
          snakeShape: SnakeShape.rectangle,
          padding: EdgeInsets.zero,
          bottomBarShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          showSelectedLabels: true,
          showUnselectedLabels: true,
        );
      case 3:
        return BottomNavConfig(
          id: 3,
          snakeBarStyle: SnakeBarBehaviour.pinned,
          snakeShape: SnakeShape.indicator,
          padding: EdgeInsets.zero,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        );
      default:
        return BottomNavConfig.optZero();
    }
  }

  final int id;
  final SnakeBarBehaviour snakeBarStyle;
  final SnakeShape snakeShape;
  final EdgeInsets padding;
  final ShapeBorder? bottomBarShape;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;

  BottomNavConfig copyWith({
    int? id,
    SnakeBarBehaviour? snakeBarStyle,
    SnakeShape? snakeShape,
    EdgeInsets? padding,
    ShapeBorder? bottomBarShape,
    bool? showSelectedLabels,
    bool? showUnselectedLabels,
  }) {
    return BottomNavConfig(
      id: id ?? this.id,
      snakeBarStyle: snakeBarStyle ?? this.snakeBarStyle,
      snakeShape: snakeShape ?? this.snakeShape,
      padding: padding ?? this.padding,
      bottomBarShape: bottomBarShape ?? this.bottomBarShape,
      showSelectedLabels: showSelectedLabels ?? this.showSelectedLabels,
      showUnselectedLabels: showUnselectedLabels ?? this.showUnselectedLabels,
    );
  }
}
