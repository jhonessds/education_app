import 'package:demo/app/modules/currency/presenter/widgets/home/card_converter.dart';
import 'package:demo/app/modules/currency/presenter/widgets/home/convert_button.dart';
import 'package:demo/app/modules/currency/presenter/widgets/home/top_group.dart';
import 'package:demo/app/modules/currency/presenter/widgets/home/waves.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ConverterView extends StatelessWidget {
  const ConverterView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: context.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            const Waves(),
            const TopGroup(),
            const CardConverter(),
            const ConvertButton(),
            Container(
              margin: EdgeInsets.only(
                top: context.height * 0.4,
                bottom: 20,
                left: 15,
                right: 15,
              ),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) => const Divider(
                  thickness: 1,
                  height: 5,
                ),
                itemCount: 22,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Flag(Flags.saba_island),
                    title: const SimpleText(
                      text: 'USD',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    trailing: const SimpleText(
                      text: '123,43',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
