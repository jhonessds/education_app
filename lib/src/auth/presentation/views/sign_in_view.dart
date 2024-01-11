import 'package:demo/core/common/widgets/footer.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:demo/src/auth/data/models/local_user_model.dart';
import 'package:demo/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:demo/src/auth/presentation/components/sign_in/sign_in_body.dart';
import 'package:demo/src/dashboard/presentation/views/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  static const routeName = '/sign-in';

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
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
        } else if (state is SignedIn) {
          context.userProvider.initUser(state.user as LocalUserModel);
          Navigator.pushReplacementNamed(context, Dashboard.routeName);
        }
      },
      builder: (context, state) {
        return KeyboardVisibilityBuilder(
          builder: (context, isKeyboardVisible) {
            return Scaffold(
              body: SignInBody(state: state),
              bottomSheet: !isKeyboardVisible ? const Footer() : null,
            );
          },
        );
      },
    );
  }
}
