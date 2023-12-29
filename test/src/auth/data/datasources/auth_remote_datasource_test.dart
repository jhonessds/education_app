import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/src/auth/data/datasources/auth_remote_datasource.dart';
import 'package:education_app/src/auth/data/models/local_user_model.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late FakeFirebaseFirestore firestoreClient;
  late MockFirebaseAuth authClient;
  late MockFirebaseStorage storageClient;
  late AuthRemoteDataSource dataSource;

  setUp(() async {
    firestoreClient = FakeFirebaseFirestore();
    final mockUser = MockUser(
      uid: 'someuid',
      email: 'bob@somedomain.com',
      displayName: 'Bob',
    );
    authClient = MockFirebaseAuth(mockUser: mockUser);
    storageClient = MockFirebaseStorage();

    dataSource = AuthRemoteDataSourceImpl(
      authClient: authClient,
      storageClient: storageClient,
      firestoreClient: firestoreClient,
    );
    registerFallbackValue(LocalUserModel.empty());
  });

  const tPassword = 'password';
  const tNewPassword = 'newPassword';
  const tFullName = 'fullname';
  const tEmail = 'email@email.com';
  final tUser = LocalUserModel.empty();

  test('signUp', () async {
    // Act
    await dataSource.signUp(
      email: tEmail,
      fullName: tFullName,
      password: tPassword,
    );

    // Assert
    expect(authClient.currentUser, isNotNull);
    expect(authClient.currentUser!.displayName, tFullName);

    final user = await firestoreClient
        .collection('users')
        .doc(authClient.currentUser!.uid)
        .get();
    expect(user.exists, isTrue);
  });

  test('signIn', () async {
    // Act
    await dataSource.signUp(
      email: 'new_email@email.com',
      fullName: tFullName,
      password: tPassword,
    );

    await authClient.signOut();

    await dataSource.signIn(email: 'new_email@email.com', password: tPassword);

    // Assert
    expect(authClient.currentUser, isNotNull);
    expect(authClient.currentUser!.email, equals('new_email@email.com'));
  });

  test('updatePassword', () async {
    // Act
    await dataSource.signIn(email: 'email@email.com', password: tPassword);
    await dataSource.updatePassword(
      oldPassword: tPassword,
      newPassword: tNewPassword,
    );

    // Assert
    expect(authClient.currentUser, isNotNull);
  });

  group('updateUser', () {
    test('displayName', () async {
      // Arrange
      await dataSource.signUp(
        email: tEmail,
        fullName: tFullName,
        password: tPassword,
      );

      // Act
      await dataSource.updateUser(
        user: tUser,
        action: UpdateUserAction.displayName,
      );
      // Assert

      expect(authClient.currentUser!.displayName, tUser.fullName);
    });

    test('email', () async {
      // Arrange
      await dataSource.signUp(
        email: tEmail,
        fullName: tFullName,
        password: tPassword,
      );
      await dataSource.signIn(email: tEmail, password: tPassword);

      // Act
      await dataSource.updateUser(
        user: tUser.copyWith(email: 'new@example.com'),
        action: UpdateUserAction.email,
      );
      // Assert

      expect(authClient.currentUser!.email, tUser.email);
    });
  });
}
