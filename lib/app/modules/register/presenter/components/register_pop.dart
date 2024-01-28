import 'dart:ui';

import 'package:demo/app/modules/auth/presentation/controllers/auth_controller.dart';
import 'package:demo/app/modules/auth/presentation/controllers/session_controller.dart';
import 'package:demo/app/modules/register/presenter/components/register_button.dart';
import 'package:demo/app/modules/register/presenter/components/register_pop_content.dart';
import 'package:demo/app/modules/register/presenter/controllers/register_controller.dart';
import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterDialog extends StatefulWidget {
  const RegisterDialog({super.key});

  @override
  State<RegisterDialog> createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog>
    with SingleTickerProviderStateMixin {
  final txtCtrl = TextEditingController();
  final registerCtrl = Modular.get<RegisterController>();
  final authCtrl = Modular.get<AuthController>();
  final formKey = GlobalKey<FormState>();
  ValueNotifier<String> txtButton = ValueNotifier<String>(translation().yes);
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
    tabController.index = 0;
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) async {
        Modular.to.pop();
      },
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: AlertDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          insetPadding: const EdgeInsets.all(10),
          titlePadding: const EdgeInsets.all(8),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          content: RegisterPopContent(
            tabController: tabController,
            formKey: formKey,
            txtCtrl: txtCtrl,
            registerCtrl: registerCtrl,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: const EdgeInsets.only(
            bottom: 5,
            right: 10,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () async {
                    await Modular.get<SessionController>().logOut();
                    Modular.to.pop();
                  },
                  child: Text(
                    translation().cancel,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
                RegisterButton(
                  txtButton: txtButton,
                  tabController: tabController,
                  formKey: formKey,
                  registerCtrl: registerCtrl,
                  authCtrl: authCtrl,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
