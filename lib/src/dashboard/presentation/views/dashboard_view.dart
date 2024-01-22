import 'package:demo/core/common/app/providers/user_provider.dart';
import 'package:demo/src/auth/data/models/local_user_model.dart';
import 'package:demo/src/dashboard/providers/dashboard_controller.dart';
import 'package:demo/src/dashboard/utils/dashboard_utils.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  static const routeName = '/dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LocalUserModel>(
      stream: DashboardUtils.userDataStream,
      builder: (_, snap) {
        if (snap.hasData && snap.data is LocalUserModel) {
          context.read<UserProvider>().user = snap.data;
        }
        return Consumer<DashboardController>(
          builder: (_, controller, __) {
            return Scaffold(
              body: IndexedStack(
                index: controller.currentIndex,
                children: controller.screens,
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: controller.currentIndex,
                showSelectedLabels: false,
                backgroundColor: Theme.of(context).colorScheme.onBackground,
                elevation: 8,
                onTap: controller.changeIndex,
                items: [
                  _buildBarItem(
                    icon: controller.isSelected(0)
                        ? IconlyBold.home
                        : IconlyLight.home,
                    isSelected: controller.isSelected(0),
                    label: 'Home',
                  ),
                  _buildBarItem(
                    icon: controller.isSelected(1)
                        ? IconlyBold.document
                        : IconlyLight.document,
                    isSelected: controller.isSelected(1),
                    label: 'Materials',
                  ),
                  _buildBarItem(
                    icon: controller.isSelected(2)
                        ? IconlyBold.chat
                        : IconlyLight.chat,
                    isSelected: controller.isSelected(2),
                    label: 'Chat',
                  ),
                  _buildBarItem(
                    icon: controller.isSelected(3)
                        ? IconlyBold.profile
                        : IconlyLight.profile,
                    isSelected: controller.isSelected(3),
                    label: 'Profile',
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  BottomNavigationBarItem _buildBarItem({
    required String label,
    required IconData icon,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
      ),
      label: label,
    );
  }
}
