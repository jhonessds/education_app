import 'dart:io';

String fixture(String file) =>
    File('test/fixtures/$file.json').readAsStringSync();
