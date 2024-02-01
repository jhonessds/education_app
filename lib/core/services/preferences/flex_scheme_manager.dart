import 'package:demo/core/common/states/app_state.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setFlexScheme(String flexSchemeName) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('flexScheme', flexSchemeName);

  final flexScheme = FlexScheme.values.firstWhere(
    (element) {
      return element.name == flexSchemeName;
    },
    orElse: () => FlexScheme.brandBlue,
  );

  appConfigState.value = appConfigState.value.copyWith(flexScheme: flexScheme);
}

Future<void> getFlexScheme() async {
  final prefs = await SharedPreferences.getInstance();
  final flexSchemeName = prefs.getString('flexScheme');

  final flexScheme = FlexScheme.values.firstWhere(
    (element) {
      return element.name == flexSchemeName;
    },
    orElse: () => FlexScheme.brandBlue,
  );

  appConfigState.value = appConfigState.value.copyWith(flexScheme: flexScheme);
}

Future<void> setDarkFlexScheme(String flexSchemeName) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('darkFlexScheme', flexSchemeName);
  final flexScheme = FlexScheme.values.firstWhere(
    (element) {
      return element.name == flexSchemeName;
    },
    orElse: () => FlexScheme.brandBlue,
  );

  appConfigState.value = appConfigState.value.copyWith(
    darkFlexScheme: flexScheme,
  );
}

Future<void> getDarkFlexScheme() async {
  final prefs = await SharedPreferences.getInstance();
  final flexSchemeName = prefs.getString('darkFlexScheme');
  final flexScheme = FlexScheme.values.firstWhere(
    (element) {
      return element.name == flexSchemeName;
    },
    orElse: () => FlexScheme.brandBlue,
  );

  appConfigState.value = appConfigState.value.copyWith(
    darkFlexScheme: flexScheme,
  );
}
