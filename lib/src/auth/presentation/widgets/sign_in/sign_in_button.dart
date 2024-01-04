import 'package:demo/core/utils/language_constants.dart';
import 'package:demo/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignInButton extends StatefulWidget {
  const SignInButton({
    required this.formKey,
    required this.buttonKey,
    required this.email,
    required this.password,
    super.key,
  });

  final String email;
  final String password;
  final GlobalKey<FormState> formKey;
  final GlobalKey<State<StatefulWidget>> buttonKey;

  @override
  State<SignInButton> createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  final btnController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      key: widget.buttonKey,
      height: 45,
      margin: EdgeInsets.only(
        left: 13,
        right: 13,
        bottom: screenSize.height * 0.01,
      ),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            btnController.stop();
          }
        },
        builder: (context, state) {
          return RoundedLoadingButton(
            borderRadius: 70,
            color: Theme.of(context).primaryColor,
            controller: btnController,
            onPressed: () async {
              await FirebaseAuth.instance.currentUser?.reload();
              if (widget.formKey.currentState!.validate()) {
                // ignore: use_build_context_synchronously
                context.read<AuthBloc>().add(
                      SignInEvent(
                        email: widget.email,
                        password: widget.password,
                      ),
                    );
              } else {
                btnController.stop();
              }
            },
            width: screenSize.width,
            child: Text(
              translation().signIn,
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
}
