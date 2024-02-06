import 'package:demo/app/modules/currency/presenter/components/currency_bottom_nav.dart';
import 'package:demo/app/modules/currency/presenter/views/converter_view.dart';
import 'package:demo/app/modules/currency/presenter/views/currency_group_view.dart';
import 'package:demo/app/modules/currency/presenter/views/currency_history_view.dart';
import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/common/states/app_state.dart';
import 'package:flutter/material.dart';

class CurrencyView extends StatefulWidget {
  const CurrencyView({super.key});

  @override
  State<CurrencyView> createState() => _CurrencyViewState();
}

class _CurrencyViewState extends State<CurrencyView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        child: TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const ConverterView(),
            const CurrencyHistoryView(),
            const CurrencyGroupView(),
            Container(color: Colors.blue),
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
      bottomNavigationBar: CurrencyBottomNav(tabController: tabController),
    );
  }
}
