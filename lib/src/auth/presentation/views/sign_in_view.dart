import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:demo/src/auth/data/models/local_user_model.dart';
import 'package:demo/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:demo/src/auth/presentation/components/sign_in_body.dart';
import 'package:demo/src/dashboard/presentation/views/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  static const routeName = '/sign-in';

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            CoreUtils.showSnackBar(state.message, isError: true);
          } else if (state is SignedIn) {
            context.userProvider.initUser(state.user as LocalUserModel);
            Navigator.pushReplacementNamed(context, Dashboard.routeName);
          }
        },
        builder: (context, state) {
          return SignInBody(state: state);
        },
      ),
    );
  }
}
