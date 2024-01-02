part of 'router_main.dart';

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
    case Dashboard.routeName:
      return _pageBuilder((_) => const Dashboard(), settings: settings);
    case '/forgot-password':
      return _pageBuilder(
        (_) => const ForgotPasswordView(),
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
      return FadeTransition(
        opacity: animation,
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling,
          ),
          child: child,
        ),
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) => page(context),
  );
}
