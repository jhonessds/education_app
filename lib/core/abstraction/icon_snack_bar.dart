import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:icon_animated/icon_animated.dart';

enum SnackBarType {
  save,
  fail,
  alert,
}

class SnackBarStyle {
  const SnackBarStyle({
    this.backgroundColor,
    this.iconColor = Colors.white,
    this.labelTextStyle = const TextStyle(),
  });
  final Color? backgroundColor;
  final Color iconColor;
  final TextStyle labelTextStyle;
}

class IconSnackBar {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show({
    required BuildContext context,
    required String label,
    required SnackBarType snackBarType,
    Duration? duration,
    DismissDirection? direction,
    SnackBarStyle snackBarStyle = const SnackBarStyle(),
  }) {
    switch (snackBarType) {
      case SnackBarType.save:
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: duration ?? const Duration(seconds: 2),
            dismissDirection: direction ?? DismissDirection.down,
            behavior: SnackBarBehavior.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: SnackBarWidget(
              onPressed: () {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
              },
              label: label,
              backgroundColor: context.theme.primaryColor,
              labelTextStyle: snackBarStyle.labelTextStyle,
              iconType: IconType.check,
            ),
          ),
        );
      case SnackBarType.fail:
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: duration ?? const Duration(seconds: 2),
            dismissDirection: direction ?? DismissDirection.down,
            behavior: SnackBarBehavior.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: SnackBarWidget(
              onPressed: () {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
              },
              label: label,
              backgroundColor: context.theme.colorScheme.error,
              labelTextStyle: snackBarStyle.labelTextStyle,
              iconType: IconType.fail,
            ),
          ),
        );
      case SnackBarType.alert:
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: duration ?? const Duration(seconds: 2),
            dismissDirection: direction ?? DismissDirection.down,
            behavior: SnackBarBehavior.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: SnackBarWidget(
              onPressed: () {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
              },
              label: label,
              backgroundColor: context.theme.colorScheme.secondary,
              labelTextStyle: snackBarStyle.labelTextStyle,
              iconType: IconType.alert,
            ),
          ),
        );
    }
  }
}

class SnackBarWidget extends StatefulWidget implements SnackBarAction {
  const SnackBarWidget({
    required this.label,
    required this.onPressed,
    required this.iconType,
    super.key,
    this.textColor,
    this.disabledTextColor,
    this.backgroundColor = Colors.black,
    this.labelTextStyle,
    this.disabledBackgroundColor = Colors.black,
  });

  @override
  final Color? textColor;

  @override
  final Color? disabledTextColor;

  @override
  final String label;

  @override
  final VoidCallback onPressed;

  @override
  final Color backgroundColor;

  @override
  final Color disabledBackgroundColor;

  final TextStyle? labelTextStyle;
  final IconType iconType;

  @override
  State<SnackBarWidget> createState() => _SnackBarWidgetState();
}

class _SnackBarWidgetState extends State<SnackBarWidget> {
  var _fadeAnimationStart = false;
  bool disposed = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!disposed) {
        setState(() {
          _fadeAnimationStart = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: ClipRRect(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        borderRadius: BorderRadius.circular(15),
        child: AnimatedContainer(
          color: widget.backgroundColor,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 400),
          height: 50,
          child: SizedBox(
            height: 50,
            child: Row(
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    width: 40,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white.withOpacity(0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        child: IconAnimated(
                          color: _fadeAnimationStart
                              ? Colors.white
                              : widget.backgroundColor,
                          active: true,
                          size: 40,
                          iconType: widget.iconType,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedContainer(
                      margin:
                          EdgeInsets.only(left: _fadeAnimationStart ? 0 : 10),
                      duration: const Duration(milliseconds: 400),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 400),
                        opacity: _fadeAnimationStart ? 1.0 : 0.0,
                        child: Text(
                          widget.label,
                          overflow: TextOverflow.visible,
                          maxLines: 1,
                          style: widget.labelTextStyle ??
                              const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }
}
