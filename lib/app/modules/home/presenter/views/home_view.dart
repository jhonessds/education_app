import 'package:demo/app/modules/auth/presenter/controllers/session_controller.dart';
import 'package:demo/app/modules/home/presenter/components/home_app_bar.dart';
import 'package:demo/app/modules/home/presenter/components/custom_bottom_nav.dart';
import 'package:demo/app/modules/home/presenter/components/nav_option_content.dart';
import 'package:demo/core/common/widgets/custom_alert.dart';
import 'package:demo/core/common/widgets/profile/profile_picture.dart';
import 'package:demo/core/common/widgets/settings/theme_selector.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/services/notifications/push_notification_service.dart';
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
    PushNotificationsManager().init(userId: sessionCtrl.currentUser.id);
    tabController = TabController(vsync: this, length: 5, initialIndex: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const HomeAppBar(),
      body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        child: TabBarView(
          controller: tabController,
          children: [
            Container(color: Colors.red),
            Container(color: Colors.green),
            Scaffold(
              backgroundColor:
                  context.theme.colorScheme.onBackground.withOpacity(0.1),
            ),
            Container(color: Colors.blue),
            Container(color: Colors.cyan),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
      bottomNavigationBar: CustomBottomNav(tabController: tabController),
    );
  }
}
