import 'package:demo/core/common/widgets/custom_input.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class SearchCurrency extends StatelessWidget {
  const SearchCurrency({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
