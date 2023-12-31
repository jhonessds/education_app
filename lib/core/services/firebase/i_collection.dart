abstract class ICollection<T> {
  Future<void> create(T value, {String? id});
  Future<void> update(T value);
  Future<void> delete(String id);
  Future<T?> getById(String id);
  Future<List<T>> getAll();
}
