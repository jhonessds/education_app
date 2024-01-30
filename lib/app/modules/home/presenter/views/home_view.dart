import 'package:demo/app/modules/auth/presenter/controllers/session_controller.dart';
import 'package:demo/core/services/notifications/push_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final sessionCtrl = Modular.get<SessionController>();

  @override
  void initState() {
    super.initState();
    PushNotificationsManager().init(userId: sessionCtrl.currentUser.id);
  }

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Column(
        children: [
          Center(
            child: Text(sessionCtrl.currentUser.name),
          ),
          TextButton(
            onPressed: () {
              sessionCtrl.logOut();
              Modular.to.pushReplacementNamed('/auth/');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
