import 'package:education_app/core/common/widgets/gradient_background.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/auth/data/models/local_user_model.dart';
import 'package:education_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:education_app/src/auth/presentation/views/sign_in_body.dart';
import 'package:education_app/src/auth/presentation/widgets/sign_in_form.dart';
import 'package:education_app/src/auth/presentation/widgets/sign_in_row.dart';
import 'package:education_app/src/auth/presentation/widgets/top_sign_in_text.dart';
import 'package:education_app/src/dashboard/presentation/views/dashboard_view.dart';
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
            CoreUtils.showSnackBar(state.message);
          } else if (state is SignedIn) {
            context.userProvider.initUser(state.user as LocalUserModel);
            Navigator.pushReplacementNamed(context, Dashboard.routeName);
          }
        },
        builder: (context, state) {
          return const SignInBody();
          // return GradientBackground(
          //   image: MediaRes.authGradientBackground,
          //   child: ListView(
          //     shrinkWrap: true,
          //     padding: const EdgeInsets.symmetric(horizontal: 20),
          //     children: [
          //       const TopSignInText(),
          //       const SignInRowButton(),
          //       SignInForm(
          //         emailController: emailController,
          //         passwordController: passwordController,
          //         formKey: formKey,
          //       ),
          //       Align(
          //         alignment: Alignment.centerRight,
          //         child: TextButton(
          //           onPressed: () {
          //             Navigator.pushReplacementNamed(
          //               context,
          //               '/forgot-password',
          //             );
          //           },
          //           child: const Text(
          //             'Forgot password?',
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // );
        },
      ),
    );
  }
}
