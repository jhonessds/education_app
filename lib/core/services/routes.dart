import 'package:education_app/core/common/views/page_under_construction.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:education_app/src/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OnBoardingView.routName:
      return _pageBuilder(
          (_) => BlocProvider(
                create: (context) => sl<OnBoardingCubit>(),
                child: const OnBoardingView(),
              ),
          settings: settings);
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
