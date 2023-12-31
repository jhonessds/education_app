import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/services/firebase/user_collection.dart';
import 'package:education_app/src/auth/data/models/local_user_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_exceptions/mock_exceptions.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late UserCollection userCollection;
  late FakeFirebaseFirestore firestoreClient;
  const uid = '123';
  final tUser = LocalUserModel.empty();
  const tFullname = 'fullName';

  const expectedDumpAfterDelete = '''
{
  "users": {}
}''';

  setUp(() {
    firestoreClient = FakeFirebaseFirestore();
    userCollection = UserCollection(instance: firestoreClient);
    registerFallbackValue(LocalUserModel.empty());
  });

  group('update', () {
    test('should update a user when no [Exception] is throw', () async {
      // Act
      final methodCall = userCollection.update;

      // Assert
      expect(
        methodCall(tUser.copyWith(uid: uid, fullName: tFullname)),
        completes,
      );
      final user = await firestoreClient.collection('users').doc(uid).get();
      expect(user.data()!['fullName'], tFullname);
    });

    test('should throws [Exception] when update failure', () async {
      // Arrange
      final doc = firestoreClient.collection('users').doc(uid);
      whenCalling(Invocation.method(#set, null))
          .on(doc)
          .thenThrow(FirebaseException(plugin: 'firestore'));

      // Act

      // Assert
      // Works on the same reference.
      expect(() => doc.set({'name': 'Bob'}), throwsA(isA<FirebaseException>()));
      // Works on a different reference of the same document.
      expect(
        () => firestoreClient.collection('users').doc(uid).set(
          {
            'name': 'Bob',
          },
        ),
        throwsA(isA<FirebaseException>()),
      );
      // Does not affect other documents.
      expect(
        () => firestoreClient
            .collection('users')
            .doc('${uid}abc')
            .set({'name': 'Alice'}),
        returnsNormally,
      );
    });
  });

  group('create', () {
    test('should create a user when no [Exception] is throw', () async {
      // Act
      final methodCall = userCollection.create;

      // Assert
      expect(methodCall(tUser.copyWith(uid: uid)), completes);
      final user = await firestoreClient.collection('users').doc(uid).get();
      expect(user.id, uid);
    });

    test('should throws [Exception] when create failure', () async {
      // Arrange
      final doc = firestoreClient.collection('users').doc(uid);
      whenCalling(Invocation.method(#set, null))
          .on(doc)
          .thenThrow(FirebaseException(plugin: 'firestore'));

      // Assert
      // Works on the same reference.
      expect(
        () => doc.set({'fullName': 'Bob'}),
        throwsA(isA<FirebaseException>()),
      );
      // Works on a different reference of the same document.
      expect(
        () => firestoreClient.collection('users').doc(uid).set(
          {
            'fullName': 'Bob',
          },
        ),
        throwsA(isA<FirebaseException>()),
      );
      // Does not affect other documents.
      expect(
        () => firestoreClient
            .collection('users')
            .doc('${uid}abc')
            .set({'fullName': 'Alice'}),
        returnsNormally,
      );
    });
  });

  group('getById', () {
    test('should get a user when no [Exception] is throw', () async {
      // Arrange
      await firestoreClient.collection('users').doc(uid).set({
        'uid': uid,
        'fullName': 'Bob',
      });

      // Act
      final result = await userCollection.getById(uid);

      // Assert
      expect(result!.uid, uid);
    });

    test('should throws [Exception] when update failure', () async {
      // Arrange
      final doc = firestoreClient.collection('users').doc(uid);
      whenCalling(Invocation.method(#get, null))
          .on(doc)
          .thenThrow(FirebaseException(plugin: 'firestore'));

      // Assert
      expect(doc.get, throwsA(isA<FirebaseException>()));
    });
  });

  group('delete', () {
    test('should delete a user when no [Exception] is throw', () async {
      // Arrange
      final user = firestoreClient.collection('users').doc(uid);
      await user.set({
        'uid': uid,
        'fullName': 'Bob',
      });

      // Act
      await user.delete();

      // Assert
      expect(firestoreClient.dump(), expectedDumpAfterDelete);
    });

    test('should throws [Exception] when update failure', () async {
      // Arrange
      final doc = firestoreClient.collection('users').doc(uid);
      whenCalling(Invocation.method(#delete, null))
          .on(doc)
          .thenThrow(FirebaseException(plugin: 'firestore'));

      // Assert
      expect(doc.delete, throwsA(isA<FirebaseException>()));
    });
  });
}
