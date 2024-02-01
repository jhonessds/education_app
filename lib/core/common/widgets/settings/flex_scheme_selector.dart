import 'dart:async';
import 'package:demo/app/app_widget.dart';
import 'package:demo/core/common/states/app_state.dart';
import 'package:demo/core/services/preferences/flex_scheme_manager.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

Future<void> flexSchemeSelector() async {
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
    {'flutterDash': const Color(0xFF4496E0)},
    {'materialBaseline': const Color(0xFF6750A4)},
    {'verdunHemlock': const Color(0xFF616200)},
    {'dellGenoa': const Color(0xFF386A20)},
    {'redM3': const Color(0xFFBB1614)},
    {'pinkM3': const Color(0xFFBC004B)},
    {'purpleM3': const Color(0xFF9A25AE)},
    {'indigoM3': const Color(0xFF4355B9)},
    {'blueM3': const Color(0xFF0061A4)},
    {'cyanM3': const Color(0xFF006876)},
    {'tealM3': const Color(0xFF006A60)},
    {'greenM3': const Color(0xFF006E1C)},
    {'limeM3': const Color(0xFF556500)},
    {'yellowM3': const Color(0xFF695F00)},
    {'orangeM3': const Color(0xFF8B5000)},
    {'deepOrangeM3': const Color(0xFFBF360C)},
  ];

  late FlexScheme scheme;
  if (appConfigState.value.isDarkMode) {
    scheme = appConfigState.value.darkFlexScheme;
  } else {
    scheme = appConfigState.value.flexScheme;
  }

  final context = NavigationService.instance.currentContext;

  await showModalBottomSheet<String>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25),
      ),
    ),
    isScrollControlled: true,
    builder: (context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: GridView.builder(
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
                      : FittedBox(
                          child: Text(
                            data.keys.first,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                  onPressed: () {
                    if (appConfigState.value.isDarkMode) {
                      setDarkFlexScheme(data.keys.first);
                    } else {
                      setFlexScheme(data.keys.first);
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
