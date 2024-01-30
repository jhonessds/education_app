import 'package:demo/app/modules/auth/presenter/controllers/session_controller.dart';
import 'package:demo/core/common/widgets/profile/profile_picture.dart';
import 'package:demo/core/common/widgets/settings/theme_selector.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      actions: [
        const ThemeSelector(),
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
