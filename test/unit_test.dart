import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/services/auth.dart';

class MockUserClass extends Mock implements User{

}

final MockUserClass _mockUserClass = MockUserClass();

class MockFirebaseAuthClass extends Mock implements FirebaseAuth{
  @override
  Stream<User> authStateChanges() {
    return Stream.fromIterable([
      _mockUserClass,
    ]);
  }
}

void main() {
  final MockFirebaseAuthClass mockFirebaseAuthClass = MockFirebaseAuthClass();
  final Auth auth = Auth(auth: mockFirebaseAuthClass);
  setUp((){

  });
  tearDown((){

  });

  test("emit occurs", () async{
    expectLater(auth.user, emitsInOrder([_mockUserClass]));
  });

  test("create account", () async{
    when(mockFirebaseAuthClass.createUserWithEmailAndPassword(email: "harshvardhanbsv@gmail.com", password: "harshsolo"), ).thenAnswer((realInvocation) => null);
    expect(await auth.createAccount(email: "harshvardhanbev@gmail.com", password: "harshsolo"), "Success");
  });

  test("create account exception", () async{
    when(mockFirebaseAuthClass.createUserWithEmailAndPassword(email: "harshvardhanbsv@gmail.com", password: "harshsolo"), ).thenAnswer((realInvocation) => throw FirebaseAuthException(message: "Success"));
    expect(await auth.createAccount(email: "harshvardhanbev@gmail.com", password: "harshsolo"), "Success");
  });

  test("sign in", () async{
    when(mockFirebaseAuthClass.signInWithEmailAndPassword(email: "harshvardhanbsv@gmail.com", password: "harshsolo"), ).thenAnswer((realInvocation) => null);
    expect(await auth.createAccount(email: "harshvardhanbev@gmail.com", password: "harshsolo"), "Success");
  });

  test("sign in exception", () async{
    when(mockFirebaseAuthClass.signInWithEmailAndPassword(email: "harshvardhanbsv@gmail.com", password: "harshsolo"), ).thenAnswer((realInvocation) => throw FirebaseAuthException(message: "Success"));
    expect(await auth.createAccount(email: "harshvardhanbev@gmail.com", password: "harshsolo"), "Success");
  });

  test("sign out", () async{
    when(mockFirebaseAuthClass.signOut(), ).thenAnswer((realInvocation) => null);
    expect(await auth.createAccount(email: "harshvardhanbev@gmail.com", password: "harshsolo"), "Success");
  });

  test("sign out exception", () async{
    when(mockFirebaseAuthClass.signOut(), ).thenAnswer((realInvocation) => throw FirebaseAuthException(message: "Success"));
    expect(await auth.createAccount(email: "harshvardhanbev@gmail.com", password: "harshsolo"), "Success");
  });
}