import 'package:demo/core/common/widgets/custom_alert.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:demo/app/modules/auth/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ForgotPasswordButton extends StatefulWidget {
  const ForgotPasswordButton({
    required this.emailCtrl,
    required this.buttonKey,
    required this.formKeyEmail,
    super.key,
  });
  final TextEditingController emailCtrl;
  final GlobalKey<State<StatefulWidget>> buttonKey;
  final GlobalKey<FormState> formKeyEmail;

  @override
  State<ForgotPasswordButton> createState() => _ForgotPasswordButtonState();
}

class _ForgotPasswordButtonState extends State<ForgotPasswordButton> {
  final btnCtrl = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.buttonKey,
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthError) {
            btnCtrl.stop();
            Navigator.of(context).pop();
          } else if (state is ForgotPasswordSent) {
            Navigator.of(context).pop();
            linkPop(context);
          }
        },
        builder: (_, state) {
          return RoundedLoadingButton(
            borderRadius: 70,
            color: Theme.of(context).primaryColor,
            controller: btnCtrl,
            onPressed: () async {
              if (widget.formKeyEmail.currentState!.validate()) {
                await FirebaseAuth.instance.currentUser?.reload();
                if (widget.formKeyEmail.currentState!.validate()) {
                  // ignore: use_build_context_synchronously
                  context.read<AuthBloc>().add(
                        ForgotPasswordEvent(
                          email: widget.emailCtrl.text,
                        ),
                      );
                } else {
                  btnCtrl.stop();
                }
              } else {
                btnCtrl.stop();
              }
            },
            width: context.width,
            child: Text(
              translation().send,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  void linkPop(BuildContext context) {
    customAlert(
      showOkBtn: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/lottie/send_email.json',
            repeat: false,
          ),
          SimpleText(
            mgTop: 20,
            text: translation().passwordResetLink,
            maxlines: 3,
            textAlign: TextAlign.center,
            fontSize: 16,
          ),
        ],
      ),
      callback: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );
  }
}
