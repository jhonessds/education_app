import 'package:demo/core/services/preferences/flex_scheme_manager.dart';
import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:demo/core/services/preferences/theme_manager.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();

  static void setLocale(BuildContext context, Locale newLocale) {
    final state = context.findAncestorStateOfType<_AppWidgetState>();
    state?.setLocale(newLocale);
  }

  static void setTheme(BuildContext context, ThemeMode theme) {
    final state = context.findAncestorStateOfType<_AppWidgetState>();
    state?.setTheme(theme);
  }

  static void setFlexScheme(BuildContext context, FlexScheme flexScheme) {
    final state = context.findAncestorStateOfType<_AppWidgetState>();
    state?.setFlexScheme(flexScheme);
  }

  static void setDarkFlexScheme(BuildContext context, FlexScheme flexScheme) {
    final state = context.findAncestorStateOfType<_AppWidgetState>();
    state?.setDarkFlexScheme(flexScheme);
  }
}

class _AppWidgetState extends State<AppWidget> {
  late ThemeMode _themeMode;

  Locale? _locale;
  FlexScheme? _flexScheme;
  FlexScheme? _darkFlexScheme;

  void setFlexScheme(FlexScheme flexScheme) {
    setState(() => _flexScheme = flexScheme);
  }

  void setDarkFlexScheme(FlexScheme flexScheme) {
    setState(() => _darkFlexScheme = flexScheme);
  }

  void setLocale(Locale locale) {
    setState(() => _locale = locale);
  }

  void setTheme(ThemeMode themeMode) {
    setState(() => _themeMode = themeMode);
  }

  @override
  void didChangeDependencies() {
    getLocale().then(setLocale);
    getTheme().then(setTheme);
    getFlexScheme().then(setFlexScheme);
    getDarkFlexScheme().then(setDarkFlexScheme);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _themeMode = ThemeMode.light;
    super.initState();
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

    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      title: 'DevJhones Demo',
      debugShowCheckedModeBanner: false,
      theme: FlexColorScheme.light(
        colors: FlexColor.schemes[_flexScheme]?.light,
        fontFamily: 'Poppins',
      ).toTheme,
      darkTheme: FlexColorScheme.dark(
        colors: FlexColor.schemes[_darkFlexScheme]?.dark,
        fontFamily: 'Poppins',
      ).toTheme,
      themeMode: _themeMode,
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

class NavigationService {
  NavigationService._();

  static NavigationService instance = NavigationService._();

  final navigatorKey = GlobalKey<NavigatorState>();
  BuildContext get currentContext => navigatorKey.currentContext!;
}
