import 'package:asp/asp.dart';
import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:flutter/material.dart';

final localeState = Atom<Locale>(const Locale(ENGLISH));
final fcmTokenState = Atom<bool>(true);
