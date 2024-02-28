import 'package:demo/app/modules/currency/presenter/controllers/state/currency_state.dart';
import 'package:demo/app/modules/currency/presenter/controllers/store/currency_store.dart';
import 'package:demo/core/common/widgets/empty_widget.dart';
import 'package:demo/core/common/widgets/loading_widget.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/utils/currency_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CurrencyListView extends StatefulWidget {
  const CurrencyListView({this.isRight = true, super.key});
  final bool isRight;
  @override
  State<CurrencyListView> createState() => _CurrencyListViewState();
}

class _CurrencyListViewState extends State<CurrencyListView> {
  final store = Modular.get<CurrencyListStore>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store.getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<CurrencyListState>(
        valueListenable: store,
        builder: (context, value, child) {
          if (value is LoadingCurrencyState) {
            return const LoadingWidget(
              animationHeight: 200,
              withAnimation: true,
            );
          } else {
            value as SuccessCurrencyListState;
            if (value.currencies.isEmpty) {
              return const EmptyWidget(
                animationHeight: 200,
                message: 'No Currencies',
              );
            }
            return ListView.builder(
              padding: EdgeInsets.only(
                left: 15,
                right: widget.isRight ? 0 : 15,
                bottom: 15,
                top: 20,
              ),
              itemCount: value.currencies.length,
              itemBuilder: (context, index) {
                final currency = value.currencies[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Text(
                    CurrencyUtils.currencyToEmoji(currency.flag),
                    style: const TextStyle(
                      fontSize: 35,
                    ),
                  ),
                  title: SimpleText(
                    text: currency.code,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle: Text(
                    currency.name,
                  ),
                  onTap: () {
                    if (widget.isRight) {
                      store.check(index: index, check: !currency.checked);
                    } else {
                      store.setCurrencyLeft(currency.code);
                      Modular.to.pop();
                    }
                  },
                  trailing: widget.isRight
                      ? Checkbox(
                          value: currency.checked,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(99),
                          ),
                          onChanged: (_) {
                            store.check(index: index, check: !currency.checked);
                          },
                        )
                      : const Icon(Icons.arrow_forward_ios),
                );
              },
            );
          }
        },
      ),
    );
  }
}
