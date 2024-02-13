import 'package:demo/app/modules/currency/presenter/controllers/currency_controller.dart';
import 'package:demo/app/modules/currency/presenter/controllers/state/history_state.dart';
import 'package:demo/app/modules/currency/presenter/controllers/store/history_store.dart';
import 'package:demo/core/common/widgets/loading_modal.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HistoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HistoryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Modular.get<HistoryListStore>();
    return AppBar(
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
          ValueListenableBuilder<HistoryListState>(
            valueListenable: store,
            builder: (context, value, child) {
              if (store.mainList.isNotEmpty) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    loadingWidget();

                    final controller = Modular.get<CurrencyController>();

                    final result = await controller.deleteAllHistory();
                    Modular.to.pop();
                    if (result) {
                      await store.getAllHistory();
                    } else {
                      CoreUtils.bottomSnackBar(controller.errorMessage);
                    }
                  },
                  child: const Text(
                    'Clear history',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
