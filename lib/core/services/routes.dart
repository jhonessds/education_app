import 'package:education_app/core/common/views/page_under_construction.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/services/injection_container_imports.dart';
import 'package:education_app/src/auth/data/models/local_user_model.dart';
import 'package:education_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:education_app/src/auth/presentation/views/sign_in_view.dart';
import 'package:education_app/src/auth/presentation/views/sign_up_view.dart';
import 'package:education_app/src/dashboard/presentation/views/dashboard_view.dart';
import 'package:education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:education_app/src/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      final prefs = sl<SharedPreferences>();

      return _pageBuilder(
        (context) {
          if (prefs.getBool('isFirstTime') ?? true) {
            return BlocProvider(
              create: (context) => sl<OnBoardingCubit>(),
              child: const OnBoardingView(),
            );
          } else if (sl<FirebaseAuth>().currentUser != null) {
            final user = sl<FirebaseAuth>().currentUser!;
            final localUser = LocalUserModel(
              uid: user.uid,
              email: user.email ?? '',
              fullName: user.displayName ?? '',
            );

            context.userProvider.initUser(localUser);
            return const Dashboard();
          }
          return BlocProvider(
            create: (context) => sl<AuthBloc>(),
            child: const SignInView(),
          );
        },
        settings: settings,
      );
    case SignInView.routeName:
      return _pageBuilder((_) => const Dashboard(), settings: settings);
    case Dashboard.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (context) => sl<AuthBloc>(),
          child: const SignInView(),
        ),
        settings: settings,
      );
    case SignUpView.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (context) => sl<AuthBloc>(),
          child: const SignUpView(),
        ),
        settings: settings,
      );
    default:
      return _pageBuilder(
        (_) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder<dynamic>(
    settings: settings,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
    pageBuilder: (context, animation, secondaryAnimation) => page(context),
  );
}
