import 'package:asp/asp.dart';
import 'package:demo/app/modules/home/presenter/states/home_state.dart';
import 'package:demo/app/modules/home/presenter/widgets/nav_option.dart';
import 'package:demo/core/common/entities/bottom_nav_config.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/utils/helpers/app_helper.dart';
import 'package:flutter/material.dart';

class NavOptionContent extends StatelessWidget {
  const NavOptionContent({super.key});

  @override
  Widget build(BuildContext context) {
    return RxBuilder(
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SimpleText(
              text: 'Escolha um estilo de navegação',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              maxlines: 2,
              mgRight: 13,
              mgTop: 15,
              mgLeft: 13,
              mgBottom: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: NavOption(
                    setUserType: () {
                      bottomConfigState.value = BottomNavConfig.opt(option: 0);
                      AppHelper.setNavOption(option: 0);
                    },
                    currentValue: bottomConfigState.value.id,
                    title: 'Estilo 1',
                    groupValue: 0,
                  ),
                ),
                Expanded(
                  child: NavOption(
                    setUserType: () {
                      bottomConfigState.value = BottomNavConfig.opt(option: 1);
                      AppHelper.setNavOption(option: 1);
                    },
                    currentValue: bottomConfigState.value.id,
                    title: 'Estilo 2',
                    groupValue: 1,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: NavOption(
                    setUserType: () {
                      bottomConfigState.value = BottomNavConfig.opt(option: 2);
                      AppHelper.setNavOption(option: 2);
                    },
                    currentValue: bottomConfigState.value.id,
                    title: 'Estilo 3',
                    groupValue: 2,
                  ),
                ),
                Expanded(
                  child: NavOption(
                    setUserType: () {
                      bottomConfigState.value = BottomNavConfig.opt(option: 3);
                      AppHelper.setNavOption(option: 3);
                    },
                    currentValue: bottomConfigState.value.id,
                    title: 'Estilo 4',
                    groupValue: 3,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
