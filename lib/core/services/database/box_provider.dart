import 'package:demo/core/services/database/objectbox.g.dart';

class ObjectBoxProvider {
  ObjectBoxProvider._();
  static final ObjectBoxProvider db = ObjectBoxProvider._();
  Store? _store;

  Future<Store> get store async => _store ??= await openStore();
}
