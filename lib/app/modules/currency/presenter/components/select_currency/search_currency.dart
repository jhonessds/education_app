import 'package:demo/app/modules/currency/presenter/controllers/store/currency_store.dart';
import 'package:demo/core/common/widgets/custom_input.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchCurrency extends StatelessWidget {
  const SearchCurrency({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final store = Modular.get<CurrencyListStore>();
    return CustomInput(
      hintText: 'Search Currency',
      mgLeft: 15,
      maxlines: 1,
      mgTop: 20,
      borderRadius: 25,
      prefixIcon: const Icon(Icons.search),
      fillColor: context.theme.colorScheme.background,
      mgRight: 15,
      unfocus: true,
      onChange: store.onChangedSearch,
    );
  }
}
