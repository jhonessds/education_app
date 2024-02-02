import 'package:demo/app/app_widget.dart';
import 'package:demo/core/common/actions/app_actions.dart';
import 'package:flutter/material.dart';

void customAlert({
  required void Function() callback,
  void Function()? customBtnCallback,
  String? titleOne,
  String? titleTwo,
  Color? titleTwoColor,
  Color? titleOneColor,
  Color? symbolColor,
  String symbol = '?',
  bool withIcon = false,
  IconData? icon = Icons.warning,
  FontWeight? fontWeightSymbol,
  FontWeight? fontWeightTitleOne,
  FontWeight? fontWeightTitleTwo = FontWeight.w600,
  TextAlign textAlign = TextAlign.center,
  Widget? widget,
  Widget? content,
  bool showOkBtn = false,
  bool showCustomBtn = false,
  bool barrierDismissible = false,
  String customBtnTxt = '',
  String? okBtnTitle,
  double contentPadding = 25,
  bool showButtons = true,
  EdgeInsets insetPadding = const EdgeInsets.symmetric(
    horizontal: 40,
    vertical: 24,
  ),
}) {
  final context = NavigationService.instance.currentContext;
  showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => AlertDialog(
      insetPadding: insetPadding,
      contentPadding: EdgeInsets.only(
        left: contentPadding,
        right: contentPadding,
        top: contentPadding,
        bottom: 5,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      backgroundColor: Theme.of(context).cardColor,
      content: content ??
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (withIcon)
                Icon(
                  icon,
                  color: titleTwoColor,
                  size: 80,
                ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: RichText(
                  textAlign: textAlign,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: titleOne,
                        style: TextStyle(
                          fontSize: 20,
                          color: titleOneColor ??
                              Theme.of(context).colorScheme.onBackground,
                          fontWeight: fontWeightTitleOne,
                        ),
                      ),
                      TextSpan(
                        text: ' $titleTwo',
                        style: TextStyle(
                          fontSize: 20,
                          color: titleTwoColor,
                          fontWeight: fontWeightTitleTwo,
                        ),
                      ),
                      TextSpan(
                        text: symbol,
                        style: TextStyle(
                          fontSize: 20,
                          color: symbolColor,
                          fontWeight: fontWeightSymbol,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (widget != null) widget,
            ],
          ),
      actions: [
        Visibility(
          visible: !showOkBtn && showButtons,
          child: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              translation().no,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ),
        Visibility(
          visible: !showOkBtn && showButtons,
          child: TextButton(
            onPressed: callback,
            child: Text(
              translation().yes,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
        Visibility(
          visible: showOkBtn && showButtons,
          child: TextButton(
            onPressed: callback,
            child: Text(
              okBtnTitle ?? translation().close,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
        Visibility(
          visible: showCustomBtn && showButtons,
          child: TextButton(
            onPressed: customBtnCallback,
            child: Text(
              customBtnTxt,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
