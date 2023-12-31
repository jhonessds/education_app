import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/errors/server_failure.dart';
import 'package:education_app/core/services/firebase/user_collection.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/data/datasources/auth_remote_datasource.dart';
import 'package:education_app/src/auth/data/models/local_user_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCollection extends Mock implements UserCollection {}

class MockUserCredential extends Mock implements UserCredential {
  MockUserCredential([User? user]) : _user = user;

  User? _user;
  @override
  User? get user => _user;

  set user(User? value) {
    if (_user != value) _user = value;
  }
}

class MockUser extends Mock implements User {
  String _uid = '';
  @override
  String get uid => _uid;

  set uid(String value) {
    if (_uid != value) _uid = value;
  }
}

void main() {
  late MockFirebaseAuth authClient;
  late MockFirebaseStorage storageClient;
  late MockUserCollection userCollection;
  late AuthRemoteDataSource dataSource;
  late UserCredential userCredential;
  late DocumentReference<DataMap> documentReference;
  late FirebaseFirestore firestoreClient;
  late MockUser mockUser;

  final tUser = LocalUserModel.empty();

  setUpAll(() async {
    authClient = MockFirebaseAuth();
    storageClient = MockFirebaseStorage();
    firestoreClient = FakeFirebaseFirestore();
    documentReference = await firestoreClient.collection('users').add(
          tUser.toMap(),
        );
    userCollection = MockUserCollection();
    mockUser = MockUser()..uid = documentReference.id;
    userCredential = MockUserCredential(mockUser);
    dataSource = AuthRemoteDataSourceImpl(
      authClient: authClient,
      storageClient: storageClient,
      firestoreClient: firestoreClient,
    );

    registerFallbackValue(LocalUserModel.empty());

    when(() => authClient.currentUser).thenReturn(mockUser);
  });

  const tPassword = 'password';
  const tNewPassword = 'newPassword';
  const tFullName = 'fullname';
  const tEmail = 'email@email.com';
  final tFirabaseException = FirebaseAuthException(
    code: 'user-not-found',
    message: 'No user corresponding to the email address',
  );

  group('forgotPassword', () {
    test('should complete successfully when no [Exception] is throw', () async {
      // Arrange
      when(
        () => authClient.sendPasswordResetEmail(email: any(named: 'email')),
      ).thenAnswer((_) async => Future.value());

      // Act
      final methodCall = dataSource.forgotPassword(email: tEmail);

      // Assert
      expect(methodCall, completes);

      verify(() => authClient.sendPasswordResetEmail(email: tEmail)).called(1);
      verifyNoMoreInteractions(authClient);
    });

    test('should throw [ServerFailure] when [FirebaseAuthException] is throw',
        () async {
      // Arrange
      when(
        () => authClient.sendPasswordResetEmail(email: any(named: 'email')),
      ).thenThrow(tFirabaseException);

      // Act
      final methodCall = dataSource.forgotPassword;

      // Assert
      expect(() => methodCall(email: tEmail), throwsA(isA<ServerFailure>()));

      verify(() => authClient.sendPasswordResetEmail(email: tEmail)).called(1);
      verifyNoMoreInteractions(authClient);
    });
  });

  group('signIn', () {
    test('should return a [LocalUserModel] when no [Exception] is throw',
        () async {
      // Arrange
      when(
        () => authClient.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => userCredential);

      // Act
      final result = await dataSource.signIn(
        email: tEmail,
        password: tPassword,
      );

      // Assert
      expect(result.uid, userCredential.user!.uid);
      verify(
        () => authClient.signInWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(authClient);
    });
  });
}
