import 'package:demo/core/utils/flex_scheme_manager.dart';
import 'package:demo/core/utils/theme_manager.dart';
import 'package:demo/src/app_widget.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

Future<String?> flexSchemeSelector(BuildContext context) async {
  final flexSchemes = [
    {'material': const Color(0xff6200ee)},
    {'materialHc': const Color(0xff0000ba)},
    {'blue': const Color(0xFF1565C0)},
    {'indigo': const Color(0xFF303F9F)},
    {'hippieBlue': const Color(0xFF4C9BBA)},
    {'aquaBlue': const Color(0xFF35A0CB)},
    {'brandBlue': const Color(0xFF3B5998)},
    {'deepBlue': const Color(0xFF223A5E)},
    {'sakura': const Color(0xFFCE5B78)},
    {'mandyRed': const Color(0xFFCD5758)},
    {'red': const Color(0xFFC62828)},
    {'redWine': const Color(0xFF9B1B30)},
    {'purpleBrown': const Color(0xFF450A0F)},
    {'green': const Color(0xFF2E7D32)},
    {'money': const Color(0xFF264E36)},
    {'jungle': const Color(0xFF004E15)},
    {'greyLaw': const Color(0xFF37474F)},
    {'wasabi': const Color(0xFF738625)},
    {'gold': const Color(0xFFb86914)},
    {'mango': const Color(0xFFC78D20)},
    {'amber': const Color(0xFFE65100)},
    {'vesuviusBurn': const Color(0xFFA6400F)},
    {'deepPurple': const Color(0xFF4527A0)},
    {'ebonyClay': const Color(0xFF202541)},
    {'barossa': const Color(0xFF4E0029)},
    {'shark': const Color(0xFF1D2228)},
    {'bigStone': const Color(0xFF1A2C42)},
    {'damask': const Color(0xFFC96646)},
    {'bahamaBlue': const Color(0xFF095D9E)},
    {'mallardGreen': const Color(0xFF2D4421)},
    {'espresso': const Color(0xFF452F2B)},
    {'outerSpace': const Color(0xFF1F3339)},
    {'blueWhale': const Color(0xFF023047)},
    {'sanJuanBlue': const Color(0xFF375778)},
    {'rosewood': const Color(0xFF5C000E)},
    {'blumineBlue': const Color(0xFF19647E)},
  ];

  final actualTheme = await getTheme();
  final isDarkMode = actualTheme == ThemeMode.dark;

  late FlexScheme scheme;
  if (isDarkMode) {
    scheme = await getDarkFlexScheme();
  } else {
    scheme = await getFlexScheme();
  }

  // ignore: use_build_context_synchronously
  final result = await showModalBottomSheet<String>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25),
      ),
    ),
    builder: (context) {
      return GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(4),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
        ),
        itemCount: flexSchemes.length,
        itemBuilder: (context, index) {
          final data = flexSchemes[index];

          return Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: data.values.first,
              ),
              child: IconButton(
                splashRadius: 35,
                icon: scheme.name == data.keys.first
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                      )
                    : Container(),
                onPressed: () async {
                  if (isDarkMode) {
                    final flexScheme = await setDarkFlexScheme(data.keys.first);
                    // ignore: use_build_context_synchronously
                    AppWidget.setDarkFlexScheme(context, flexScheme);
                  } else {
                    final flexScheme = await setFlexScheme(data.keys.first);
                    // ignore: use_build_context_synchronously
                    AppWidget.setFlexScheme(context, flexScheme);
                  }
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
              ),
            ),
          );
        },
      );
    },
  );
  return result;
}
