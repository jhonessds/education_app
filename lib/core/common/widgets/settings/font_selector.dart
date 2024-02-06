import 'package:demo/app/app_widget.dart';
import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/common/states/app_state.dart';
import 'package:demo/core/utils/fonts.dart';
import 'package:flutter/material.dart';

Future<void> fontSelector() async {
  final context = NavigationService.instance.currentContext;
  await showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10),
      ),
    ),
    builder: (context) {
      return SafeArea(
        child: Wrap(
          children: [
            ListTile(
              title: const Text(Fonts.aeonik),
              onTap: () async {
                await setFont(Fonts.aeonik).then((_) {
                  Navigator.pop(context);
                });
              },
              trailing: appConfigState.value.font == Fonts.aeonik
                  ? const Icon(Icons.check)
                  : null,
            ),
            ListTile(
              title: const Text(Fonts.montserrat),
              onTap: () async {
                await setFont(Fonts.montserrat).then((_) {
                  Navigator.pop(context);
                });
              },
              trailing: appConfigState.value.font == Fonts.montserrat
                  ? const Icon(Icons.check)
                  : null,
            ),
            ListTile(
              title: const Text(Fonts.poppins),
              onTap: () async {
                await setFont(Fonts.poppins).then((_) {
                  Navigator.pop(context);
                });
              },
              trailing: appConfigState.value.font == Fonts.poppins
                  ? const Icon(Icons.check)
                  : null,
            ),
          ],
        ),
      );
    },
  );
}
