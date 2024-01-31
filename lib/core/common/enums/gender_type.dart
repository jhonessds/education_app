import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:flutter/material.dart';

enum GenderType {
  male('MALE', 0),
  female('FEMALE', 10),
  none('NONE', 20);

  const GenderType(this.name, this.value);

  factory GenderType.fromString(String value) {
    switch (value) {
      case 'MALE':
        return GenderType.male;
      case 'FEMALE':
        return GenderType.female;
      default:
        return GenderType.male;
    }
  }

  static String translated(String value, BuildContext context) {
    switch (value) {
      case 'MALE':
        return translation().male;
      case 'FEMALE':
        return translation().female;
      default:
        return translation().male;
    }
  }

  final String name;
  final int value;

  @override
  String toString() => name;
}
