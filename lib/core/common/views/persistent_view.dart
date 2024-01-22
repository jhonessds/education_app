import 'package:demo/core/common/app/providers/tab_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersistentView extends StatefulWidget {
  const PersistentView({super.key, this.body});

  final Widget? body;
  @override
  State<PersistentView> createState() => _PersistentViewState();
}

class _PersistentViewState extends State<PersistentView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.body ?? context.watch<TabNavigator>().currentPage.child;
  }

  @override
  bool get wantKeepAlive => true;
}
