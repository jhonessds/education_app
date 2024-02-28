import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class CurrencyUtils {
  /// Return Flag (Emoji Unicode) of a given currency
  static String currencyToEmoji(String currencyFlag) {
    // 0x41 is Letter A
    // 0x1F1E6 is Regional Indicator Symbol Letter A
    // Example :
    // firstLetter U => 20 + 0x1F1E6
    // secondLetter S => 18 + 0x1F1E6
    // See: https://en.wikipedia.org/wiki/Regional_Indicator_Symbol
    final firstLetter = currencyFlag.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final secondLetter = currencyFlag.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }

  static Widget getFlag([String? flag, double size = 30]) {
    if (flag == null) {
      return const Padding(
        padding: EdgeInsets.only(right: 5),
        child: Icon(
          FontAwesome.money_bill_transfer_solid,
        ),
      );
    }
    if (flag == 'GRP') {
      return Icon(Bootstrap.currency_exchange, size: size);
    } else {
      return Text(
        currencyToEmoji(flag),
        style: TextStyle(fontSize: size),
      );
    }
  }
}
