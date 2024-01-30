import 'dart:ui';
import 'package:demo/app/modules/auth/presentation/controllers/session_controller.dart';
import 'package:demo/app/modules/register/presenter/components/register_button.dart';
import 'package:demo/app/modules/register/presenter/components/register_pop_content.dart';
import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterDialog extends StatefulWidget {
  const RegisterDialog({required this.isSignInView, super.key});

  final bool isSignInView;

  @override
  State<RegisterDialog> createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog>
    with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
    tabController.index = widget.isSignInView ? 0 : 1;
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
                  tabController: tabController,
                  formKey: formKey,
                  isSignInView: widget.isSignInView,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
