import 'package:asp/asp.dart';
import 'package:demo/app/modules/currency/presenter/interactor/actions/currency_action.dart';
import 'package:demo/app/modules/currency/presenter/interactor/state/currency_state.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class OneCurrency extends StatelessWidget {
  const OneCurrency({super.key});

  @override
  Widget build(BuildContext context) {
    return RxBuilder(
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(
            top: context.height * 0.43,
            bottom: 20,
            left: 15,
            right: 15,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SimpleText(
                      maxlines: 2,
                      mgLeft: 10,
                      mgRight: 5,
                      text: cGroupState.value.currencies.first.conversion,
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SimpleText(
                text: currencyText(),
                color: context.theme.disabledColor,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        );
      },
    );
  }
}
