import 'package:asp/asp.dart';
import 'package:demo/app/modules/home/presenter/components/nav_option_content.dart';
import 'package:demo/app/modules/home/presenter/controllers/states/home_state.dart';
import 'package:demo/core/common/widgets/custom_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChangeBottomNavType extends StatelessWidget {
  const ChangeBottomNavType({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RxBuilder(
      builder: (_) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: indexState.value == 2 ? 1 : 0,
          child: FloatingActionButton(
            onPressed: () {
              customAlert(
                contentPadding: 10,
                insetPadding: const EdgeInsets.all(8),
                content: const NavOptionContent(),
                callback: () => Modular.to.pop(),
                showOkBtn: true,
              );
            },
            child: const Icon(Icons.edit),
          ),
        );
      },
    );
  }
}
