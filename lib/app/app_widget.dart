import 'package:asp/asp.dart';
import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/common/states/app_state.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void didChangeDependencies() {
    initApp();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Modular
      ..setNavigatorKey(NavigationService.instance.navigatorKey)
      ..setInitialRoute('/splash/');

    return RxBuilder(
      builder: (context) {
        return MaterialApp.router(
          routeInformationParser: Modular.routeInformationParser,
          routerDelegate: Modular.routerDelegate,
          title: 'DevJhones Demo',
          debugShowCheckedModeBanner: false,
          theme: FlexColorScheme.light(
            colors: FlexColor.schemes[appConfigState.value.flexScheme]?.light,
            fontFamily: appConfigState.value.font,
          ).toTheme,
          localeResolutionCallback: localeResolution,
          darkTheme: FlexColorScheme.dark(
            colors:
                FlexColor.schemes[appConfigState.value.darkFlexScheme]?.dark,
            fontFamily: appConfigState.value.font,
          ).toTheme,
          themeMode: appConfigState.value.themeMode,
          locale: appConfigState.value.language.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}

class NavigationService {
  NavigationService._();

  static NavigationService instance = NavigationService._();

  final navigatorKey = GlobalKey<NavigatorState>();
  BuildContext get currentContext => navigatorKey.currentContext!;
}
