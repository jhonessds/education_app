import 'package:objectbox/objectbox.dart';

abstract class ObjectBoxRepository {
  Future<bool> create<T>({required T value});
  Future<bool> update<T>({required T value});
  Future<bool> delete<T>({required int id});
  Future<T?> getById<T>({required int id});
  Future<List<T>> getAll<T>();
  Future<List<T>> query<T>([Condition<T>? qc]);
}
