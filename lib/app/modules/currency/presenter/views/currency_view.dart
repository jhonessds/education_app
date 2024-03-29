import 'package:demo/app/modules/currency/presenter/components/currency_bottom_nav.dart';
import 'package:demo/app/modules/currency/presenter/controllers/currency_controller.dart';
import 'package:demo/app/modules/currency/presenter/views/converter/currency_converter_view.dart';
import 'package:demo/app/modules/currency/presenter/views/currency_group_view.dart';
import 'package:demo/app/modules/currency/presenter/views/currency_history_view.dart';
import 'package:demo/app/modules/currency/presenter/views/currency_profile.dart';
import 'package:demo/core/abstraction/logger.dart';
import 'package:demo/core/services/web/web_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CurrencyView extends StatefulWidget {
  const CurrencyView({super.key});

  @override
  State<CurrencyView> createState() => _CurrencyViewState();
}

class _CurrencyViewState extends State<CurrencyView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final currencyCtrl = Modular.get<CurrencyController>();

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
          children: const [
            CurrencyConverterView(),
            CurrencyHistoryView(),
            CurrencyGroupView(),
            CurrencyProfile(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final web = WebServiceImpl(
            'https://openexchangerates.org/api/latest.json?app_id=1abfc475e76b45f6919fbe7bc63a92a9',
            isAuthenticated: false,
          );

          await web.getModel(
            '',
            (json) {
              final temp = json;
              logger(json);
            },
          );
        },
      ),
      bottomNavigationBar: CurrencyBottomNav(tabController: tabController),
    );
  }
}
