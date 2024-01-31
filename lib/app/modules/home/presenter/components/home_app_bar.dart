import 'package:asp/asp.dart';
import 'package:demo/app/modules/auth/presenter/controllers/session_controller.dart';
import 'package:demo/app/modules/home/presenter/controllers/states/home_state.dart';
import 'package:demo/core/common/widgets/profile/profile_picture.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return RxBuilder(
      builder: (_) {
        if (indexState.value == 2) {
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: indexState.value == 2 ? 1 : 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                  splashRadius: 25,
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications,
                    color: context.theme.colorScheme.primary,
                  ),
                ),
                ProfilePicture(
                  onTap: () async {
                    await Modular.get<SessionController>().logOut();
                    await Modular.to.pushReplacementNamed('/auth/');
                  },
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
