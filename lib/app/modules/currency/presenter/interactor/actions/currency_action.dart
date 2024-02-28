// import 'package:demo/app/modules/currency/presenter/interactor/state/currency_state.dart';

 

// void convert() {
//   final currency = double.tryParse(currencyCtrlState.value.text) ?? 1;
//   for (final element in cGroupState.value.currencies) {
//     final val = currencyLeftSate.value!.buy * currency;
//     final fixed = element.code == 'BTC' ? 6 : 2;
//     element.conversion = currencyCtrlState.value.text.isEmpty
//         ? '0.0'
//         : (val / element.buy).toStringAsFixed(fixed);
//   }
 
// }

// void resetConversion() {
//   for (final element in cGroupState.value.currencies) {
//     element.conversion = '0.0';
//   }
//   cGroupState.call();
// }

// String currencyText() {
//   final c = cGroupState.value.currencies.first;
//   final fixed = c.code == 'BTC' ? 6 : 2;
//   return '1 ${currencyLeftSate.value?.code} ='
//       ' ${((currencyLeftSate.value!.buy * 1) / c.buy).toStringAsFixed(fixed)}'
//       ' ${c.code}';
// }
