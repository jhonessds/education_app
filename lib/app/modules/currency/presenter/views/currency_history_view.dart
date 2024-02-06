import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class CurrencyHistoryView extends StatelessWidget {
  const CurrencyHistoryView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SimpleText(
              text: 'History',
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: context.theme.colorScheme.onBackground,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: context.theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Clear history',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 25,
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemCount: 20,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      SimpleText(
                        alignment: Alignment.centerLeft,
                        text: 'USD to CAD',
                        fontWeight: FontWeight.bold,
                        color: context.theme.primaryColor,
                        fontSize: 20,
                      ),
                      const SimpleText(
                        mgTop: 10,
                        mgBottom: 5,
                        alignment: Alignment.centerLeft,
                        text: 'Amount',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SimpleText(
                            text: '10,000',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          Row(
                            children: [
                              Icon(
                                IconlyLight.time_circle,
                                color: context.theme.disabledColor,
                                size: 12,
                              ),
                              SimpleText(
                                text: '3hr ago',
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: context.theme.disabledColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
