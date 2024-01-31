import 'package:demo/app/modules/home/presenter/controllers/states/home_state.dart';
import 'package:demo/core/common/entities/bottom_nav_config.dart';

Future<void> setNavOption(int option) async {
  bottomConfigState.value = BottomNavConfig.opt(option: option);
}
