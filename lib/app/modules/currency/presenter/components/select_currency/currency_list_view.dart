import 'package:asp/asp.dart';
import 'package:demo/app/modules/currency/presenter/interactor/state/currency_state.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CurrencyListView extends StatelessWidget {
  const CurrencyListView({
    required this.isRight,
    super.key,
  });
  final bool isRight;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RxBuilder(
        builder: (context) {
          return ListView.separated(
            padding: EdgeInsets.only(
              left: 15,
              right: isRight ? 0 : 15,
              bottom: 15,
              top: 20,
            ),
            separatorBuilder: (context, index) => Divider(
              thickness: 1,
              endIndent: isRight ? 15 : 0,
              height: 5,
            ),
            itemCount: currencyAvailableState.value.length,
            itemBuilder: (context, index) {
              final currrency = currencyAvailableState.value[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CoreUtils.getFlag(
                  currencyCode: currrency.code,
                ),
                title: SimpleText(
                  text: '${currrency.code} - ${currrency.name}',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                onTap: () {
                  if (isRight) {
                    currrency.checked = !currrency.checked;
                    currencyAvailableState.call();
                  } else {
                    Modular.to.pop(currrency);
                  }
                },
                trailing: isRight
                    ? Checkbox(
                        value: currrency.checked,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(99),
                        ),
                        onChanged: (_) {
                          if (isRight) {
                            currrency.checked = !currrency.checked;
                            currencyAvailableState.call();
                          } else {
                            Modular.to.pop(currrency);
                          }
                        },
                      )
                    : const Icon(Icons.arrow_forward_ios),
              );
            },
          );
        },
      ),
    );
  }
}
