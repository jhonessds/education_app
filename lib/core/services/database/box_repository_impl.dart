// import 'package:demo/core/database/box_provider.dart';
// import 'package:demo/core/database/box_repository.dart';
// import 'package:demo/core/database/objectbox.g.dart';
// import 'package:demo/core/utils/logger.dart';

// class ObjectBoxRepositoryImpl implements ObjectBoxRepository {
//   Future<Box<T>> _getBox<T>() async {
//     final store = await ObjectBoxProvider.db.store;
//     return store.box<T>();
//   }

//   @override
//   Future<bool> create<T>({
//     required T value,
//   }) async {
//     try {
//       final box = await _getBox<T>();
//       final id = box.put(value);

//       return id > 0;
//     } catch (ex) {
//       logger(ex);
//       return false;
//     }
//   }

//   @override
//   Future<bool> delete<T>({required int id}) async {
//     try {
//       final box = await _getBox<T>();
//       final removed = box.remove(id);

//       return removed;
//     } catch (ex) {
//       logger(ex);
//       return false;
//     }
//   }

//   @override
//   Future<List<T>> getAll<T>() async {
//     try {
//       final box = await _getBox<T>();
//       final result = box.getAll();
//       return result;
//     } catch (ex) {
//       logger(ex);
//       return <T>[];
//     }
//   }

//   @override
//   Future<T?> getById<T>({required int id}) async {
//     try {
//       final box = await _getBox<T>();
//       final result = box.get(id);

//       return result;
//     } catch (ex) {
//       logger(ex);
//       return null;
//     }
//   }

//   @override
//   Future<bool> update<T>({required T value}) async {
//     try {
//       final box = await _getBox<T>();
//       final id = box.put(value);

//       return id > 0;
//     } catch (ex) {
//       logger(ex);
//       return false;
//     }
//   }

//   @override
//   Future<List<T>> query<T>([Condition<T>? qc]) async {
//     try {
//       final box = await _getBox<T>();
//       final query = box.query(qc).build();
//       final result = query.find();
//       query.close();
//       return result;
//     } catch (ex) {
//       logger(ex);
//       return <T>[];
//     }
//   }
// }
