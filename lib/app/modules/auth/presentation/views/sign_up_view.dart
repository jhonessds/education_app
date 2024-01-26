import 'package:demo/app/modules/auth/presentation/bloc/auth_bloc.dart';
import 'package:demo/app/modules/auth/presentation/components/sign_up/sign_up_body.dart';
import 'package:demo/core/common/widgets/footer.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  static const routeName = '/sign-up';

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          CoreUtils.showSnackBar(
            state.statusCode.translated,
            isError: true,
            icon: state.statusCode.icon,
          );
        } else if (state is SignedUp) {
          context.read<AuthBloc>().add(
                SignInEvent(
                  email: emailCtrl.text.trim(),
                  password: passwordCtrl.text,
                ),
              );
        } else if (state is SignedIn) {
          // context.userProvider.initUser(state.user as UserModel);
          // Navigator.pushReplacementNamed(context, Dashboard.routeName);
        }
      },
      builder: (context, state) {
        return KeyboardVisibilityBuilder(
          builder: (context, isKeyboardVisible) {
            return Scaffold(
              body: SignUpBody(
                state: state,
                emailCtrl: emailCtrl,
                passwordCtrl: passwordCtrl,
              ),
              bottomSheet: !isKeyboardVisible ? const Footer() : null,
            );
          },
        );
      },
    );
  }
}
