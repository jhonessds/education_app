import 'package:demo/app/modules/auth/presenter/controllers/session_controller.dart';
import 'package:demo/app/modules/home/presenter/components/change_nav_bottom_type.dart';
import 'package:demo/app/modules/home/presenter/components/custom_bottom_nav.dart';
import 'package:demo/app/modules/home/presenter/components/home_app_bar.dart';
import 'package:demo/app/modules/home/presenter/controllers/states/home_state.dart';
import 'package:demo/app/modules/settings/presenter/views/settings_view.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/services/notifications/push_notification_service.dart';
import 'package:demo/core/utils/helpers/user_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  final sessionCtrl = Modular.get<SessionController>();
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    indexState.value = 2;

    if (!UserHelper.isAnonymous()) PushNotificationsManager().init();

    tabController = TabController(vsync: this, length: 5, initialIndex: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: const HomeAppBar(),
      body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        child: TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Container(color: Colors.red),
            Container(color: Colors.green),
            Scaffold(
              backgroundColor:
                  context.theme.colorScheme.onBackground.withOpacity(0.1),
            ),
            Container(color: Colors.blue),
            const SettingsView(),
          ],
        ),
      ),
      floatingActionButton: const ChangeBottomNavType(),
      bottomNavigationBar: CustomBottomNav(tabController: tabController),
    );
  }
}
