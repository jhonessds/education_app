import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/core/enums/update_user.dart';
import 'package:demo/core/errors/server_failure.dart';
import 'package:demo/core/res/media_res.dart';
import 'package:demo/core/utils/typedefs.dart';
import 'package:demo/src/auth/data/datasources/auth_remote_datasource.dart';
import 'package:demo/src/auth/data/models/local_user_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthCredential extends Mock implements AuthCredential {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

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
  late AuthRemoteDataSource dataSource;
  late UserCredential userCredential;
  late DocumentReference<DataMap> documentReference;
  late FakeFirebaseFirestore firestoreClient;
  late MockUser mockUser;

  final tUser = LocalUserModel.empty();

  setUpAll(() async {
    authClient = MockFirebaseAuth();
    storageClient = MockFirebaseStorage();
    firestoreClient = FakeFirebaseFirestore();
    documentReference = firestoreClient.collection('users').doc();
    await documentReference.set(
      tUser.copyWith(uid: documentReference.id).toMap(),
    );
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
  const tBio = 'bio';
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

    test('should throw [ServerFailure] when user is null after signing',
        () async {
      // Arrange
      final emptyUserCredential = MockUserCredential();
      when(
        () => authClient.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => emptyUserCredential);

      // Act
      final methodCall = dataSource.signIn;

      // Assert
      expect(
        () => methodCall(email: tEmail, password: tPassword),
        throwsA(isA<ServerFailure>()),
      );

      verify(
        () => authClient.signInWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(authClient);
    });

    test('should throw [ServerFailure] when [FirebaseAuthException] is throw',
        () async {
      // Arrange
      when(
        () => authClient.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(tFirabaseException);

      // Act
      final methodCall = dataSource.signIn;

      // Assert
      expect(
        () => methodCall(email: tEmail, password: tPassword),
        throwsA(isA<ServerFailure>()),
      );

      verify(
        () => authClient.signInWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(authClient);
    });
  });

  group('signUp', () {
    test('should complete successfully when no [Exception] is throw', () async {
      // Arrange
      when(
        () => authClient.createUserWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => userCredential);

      when(() => userCredential.user!.updateDisplayName(any())).thenAnswer(
        (_) async => Future.value(),
      );

      when(() => userCredential.user!.updatePhotoURL(any())).thenAnswer(
        (_) async => Future.value(),
      );

      // Act
      final methodCall = dataSource.signUp(
        email: tEmail,
        password: tPassword,
        fullName: tFullName,
      );

      // Assert
      expect(methodCall, completes);

      verify(
        () => authClient.createUserWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);

      await untilCalled(() => userCredential.user!.updateDisplayName(any()));
      await untilCalled(() => userCredential.user!.updatePhotoURL(any()));

      verify(() => userCredential.user!.updateDisplayName(tFullName)).called(1);
      verify(
        () => userCredential.user!.updatePhotoURL(MediaRes.defaultAvatar),
      ).called(1);
      verifyNoMoreInteractions(authClient);
    });

    test('should throw [ServerFailure] when [FirebaseAuthException] is throw',
        () async {
      // Arrange
      when(
        () => authClient.createUserWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(tFirabaseException);

      // Act
      final methodCall = dataSource.signUp;

      // Assert
      expect(
        () => methodCall(
          email: tEmail,
          password: tPassword,
          fullName: tFullName,
        ),
        throwsA(isA<ServerFailure>()),
      );

      verify(
        () => authClient.createUserWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(authClient);
    });
  });

  group('updateUser', () {
    test(
        'should update user displayName successfully when no [Exception] '
        'is throw ', () async {
      // Arrange
      when(
        () => mockUser.updateDisplayName(any()),
      ).thenAnswer((_) async => Future.value());

      // Act
      await dataSource.updateUser(
        user: tUser.copyWith(fullName: tFullName, uid: mockUser.uid),
        action: UpdateUserAction.displayName,
      );

      // Assert
      verify(() => mockUser.updateDisplayName(tFullName)).called(1);
      verifyNever(() => mockUser.updateEmail(any()));
      final user =
          await firestoreClient.collection('users').doc(mockUser.uid).get();
      expect(user.data()!['fullName'], tFullName);
    });

    test(
        'should update user email successfully when no [Exception] '
        'is throw ', () async {
      // Arrange
      when(
        () => mockUser.updateEmail(any()),
      ).thenAnswer((_) async => Future.value());

      // Act
      await dataSource.updateUser(
        user: tUser.copyWith(email: tEmail, uid: mockUser.uid),
        action: UpdateUserAction.email,
      );

      // Assert
      verify(() => mockUser.updateEmail(tEmail)).called(1);
      verifyNever(() => mockUser.updateDisplayName(any()));
      final user =
          await firestoreClient.collection('users').doc(mockUser.uid).get();
      expect(user.data()!['email'], tEmail);
    });

    test(
        'should update user bio successfully when no [Exception] '
        'is throw ', () async {
      // Act
      await dataSource.updateUser(
        user: tUser.copyWith(bio: tBio, uid: mockUser.uid),
        action: UpdateUserAction.others,
      );

      // Assert
      final user =
          await firestoreClient.collection('users').doc(mockUser.uid).get();
      expect(user.data()!['bio'], tBio);
      verifyNever(() => mockUser.updateDisplayName(any()));
      verifyNever(() => mockUser.updateEmail(any()));
    });
  });

  group('updatePassword', () {
    setUp(() {
      registerFallbackValue(MockAuthCredential());
    });

    test('should throw [ServerFailure] when email is null', () async {
      // Arrange

      // Act
      final methodCall = dataSource.updatePassword;

      // Assert
      expect(
        methodCall(
          oldPassword: tPassword,
          newPassword: tNewPassword,
        ),
        throwsA(isA<ServerFailure>()),
      );
    });

    test(
        'should update user password successfully when no [Exception] '
        'is throw ', () async {
      // Arrange
      when(
        () => mockUser.updatePassword(any()),
      ).thenAnswer((_) async => Future.value());

      when(
        () => mockUser.reauthenticateWithCredential(any()),
      ).thenAnswer((_) async => userCredential);

      when(() => mockUser.email).thenReturn(tEmail);

      // Act
      await dataSource.updatePassword(
        oldPassword: tPassword,
        newPassword: tNewPassword,
      );

      // Assert
      verify(() => mockUser.updatePassword(tNewPassword)).called(1);
    });
  });

  group('saveProfilePicture', () {
    test(
        'should update user profilePicture successfully when no [Exception] '
        'is throw', () async {
      // Arrange
      final newProfilePicture = File('assets/images/default_user.png');
      when(
        () => mockUser.updatePhotoURL(any()),
      ).thenAnswer((_) async => Future.value());

      // Act
      await dataSource.saveProfilePicture(profilePicture: newProfilePicture);

      // Assert
      verify(() => mockUser.updatePhotoURL(any())).called(1);
      expect(storageClient.storedFilesMap.isNotEmpty, isTrue);
    });

    test('should throw [ServerFailure] when user not found', () async {
      // Arrange
      await firestoreClient.collection('users').doc(mockUser.uid).delete();
      final newProfilePicture = File('assets/images/default_user.png');

      // Act
      final methodCall = dataSource.saveProfilePicture;

      // Assert
      expect(
        methodCall(profilePicture: newProfilePicture),
        throwsA(isA<ServerFailure>()),
      );
      verifyNever(() => mockUser.updatePhotoURL(any()));
    });
  });
}
