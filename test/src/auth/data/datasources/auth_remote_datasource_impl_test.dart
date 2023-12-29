import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/services/firebase/user_collection.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/data/datasources/auth_remote_datasource.dart';
import 'package:education_app/src/auth/data/models/local_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseStorage extends Mock implements FirebaseStorage {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

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

  var tUser = LocalUserModel.empty();

  setUpAll(() async {
    authClient = MockFirebaseAuth();
    storageClient = MockFirebaseStorage();
    firestoreClient = MockFirebaseFirestore();
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
}
