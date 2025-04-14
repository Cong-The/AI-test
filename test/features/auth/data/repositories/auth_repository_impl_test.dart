import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_example/core/error/failures.dart';
import 'package:login_example/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:login_example/features/auth/domain/entities/user.dart';

void main() {
  late AuthRepositoryImpl repository;

  setUp(() {
    repository = AuthRepositoryImpl();
  });

  group('login', () {
    const tValidEmail = 'test@example.com';
    const tValidPassword = 'password';
    const tInvalidEmail = 'wrong@example.com';
    const tInvalidPassword = 'wrongpassword';

    test('should return a User when credentials are valid (test@example.com/password)', () async {
      // act
      final result = await repository.login(tValidEmail, tValidPassword);

      // assert
      expect(
        result,
        isA<Right<Failure, User>>(),
      );
      result.fold(
        (failure) => fail('Expected Right<User> but got Left<Failure>'),
        (user) {
          expect(user.email, equals(tValidEmail));
          expect(user.id, equals('1'));
          expect(user.name, equals('Test User'));
          expect(user.token, equals('mock_token'));
        },
      );
    });

    test('should return a ServerFailure when credentials are invalid',
        () async {
      // act
      final result = await repository.login(tInvalidEmail, tInvalidPassword);

      // assert
      expect(
        result,
        isA<Left<Failure, User>>(),
      );
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, equals('Invalid credentials'));
          expect(failure.code, equals('401'));
        },
        (user) => fail('Expected Left<Failure> but got Right<User>'),
      );
    });
  });

  group('register', () {
    test('should throw UnimplementedError', () async {
      // act & assert
      expect(
        () => repository.register('email', 'password', 'name'),
        throwsA(isA<UnimplementedError>()),
      );
    });
  });

  group('logout', () {
    test('should throw UnimplementedError', () async {
      // act & assert
      expect(
        () => repository.logout(),
        throwsA(isA<UnimplementedError>()),
      );
    });
  });
} 