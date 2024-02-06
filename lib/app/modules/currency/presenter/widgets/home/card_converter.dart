import 'package:demo/core/common/widgets/custom_input.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class CardConverter extends StatelessWidget {
  const CardConverter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
                        fontSize: 16,
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
                        fontSize: 16,
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
    );
  }
}
