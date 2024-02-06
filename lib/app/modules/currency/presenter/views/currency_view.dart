import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/common/states/app_state.dart';
import 'package:demo/core/common/widgets/custom_input.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:icons_plus/icons_plus.dart';

class CurrencyView extends StatelessWidget {
  const CurrencyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: context.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                color: context.theme.primaryColor.withOpacity(0.7),
                height: context.height * 0.32,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: context.height * 0.06),
              child: ClipPath(
                clipper: WaveClipperTwo(reverse: true),
                child: Container(
                  color: context.theme.primaryColor.withOpacity(0.8),
                  height: context.height * 0.2,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: context.height * 0.09),
              child: ClipPath(
                clipper: WaveClipperTwo(reverse: true),
                child: Container(
                  color: context.theme.primaryColor.withOpacity(0.9),
                  height: context.height * 0.13,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: context.height * 0.22),
              child: ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Container(
                  color: context.theme.primaryColor,
                  height: context.height * 0.1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: SimpleText(
                      text: 'Convert any Currency',
                      maxlines: 2,
                      fontSize: 25,
                      mgTop: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.theme.colorScheme.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Create Group',
                      style: TextStyle(
                        color: context.theme.colorScheme.onBackground,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 2,
              margin: EdgeInsets.only(
                left: 15,
                right: 15,
                top: context.height * 0.16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 23,
                      right: 23,
                      bottom: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flag(Flags.samoa),
                              const SizedBox(width: 10),
                              SimpleText(
                                text: 'USD',
                                color: context.theme.colorScheme.onBackground,
                                fontWeight: FontWeight.bold,
                              ),
                              const SizedBox(width: 10),
                              Icon(
                                Icons.arrow_drop_down_outlined,
                                color: context.theme.colorScheme.onBackground,
                              ),
                            ],
                          ),
                        ),
                        const SimpleText(
                          text: 'to',
                          fontWeight: FontWeight.bold,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flag(Flags.samoa),
                              const SizedBox(width: 10),
                              SimpleText(
                                text: 'USD',
                                color: context.theme.colorScheme.onBackground,
                                fontWeight: FontWeight.bold,
                              ),
                              const SizedBox(width: 10),
                              Icon(
                                Icons.arrow_drop_down_outlined,
                                color: context.theme.colorScheme.onBackground,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const CustomInput(
                    mgLeft: 30,
                    borderRadius: 25,
                    mgRight: 30,
                    mgBottom: 40,
                  ),
                ],
              ),
            ),
            Positioned(
              top: context.height * 0.32,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 30,
                  ),
                  backgroundColor: context.theme.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Convert',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (appConfigState.value.isDarkMode) {
            await setTheme(ThemeMode.light);
          } else {
            await setTheme(ThemeMode.dark);
          }
        },
      ),
    );
  }
}
