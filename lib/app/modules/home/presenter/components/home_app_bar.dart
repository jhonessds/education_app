import 'package:asp/asp.dart';
import 'package:demo/app/modules/home/presenter/components/profile_home_tile.dart';
import 'package:demo/app/modules/home/presenter/controllers/states/home_state.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

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
              title: const ProfileHomeTile(),
              actions: [
                Card(
                  margin: const EdgeInsets.only(right: 12),
                  shape: const CircleBorder(),
                  elevation: 2,
                  child: InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    onTap: () {},
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Icon(
                        Icons.notifications,
                        color: context.theme.colorScheme.primary,
                      ),
                    ),
                  ),
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
