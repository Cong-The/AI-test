import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_example/core/error/failures.dart';
import 'package:login_example/features/auth/domain/entities/user.dart';
import 'package:login_example/features/auth/domain/repositories/auth_repository.dart';
import 'package:login_example/features/auth/domain/usecases/login_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late LoginUseCase loginUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  final tEmail = 'test@example.com';
  final tPassword = 'password';
  final tUser = User(
    id: '1',
    email: tEmail,
    name: 'Test User',
    token: 'test_token',
  );

  test('should get User from the repository when login is successful', () async {
    // arrange
    when(mockAuthRepository.login(any, any))
        .thenAnswer((_) async => Right(tUser));

    // act
    final result = await loginUseCase(
        LoginParams(email: tEmail, password: tPassword));

    // assert
    expect(result, Right(tUser));
    verify(mockAuthRepository.login(tEmail, tPassword));
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return a ServerFailure when login fails', () async {
    // arrange
    final tFailure = ServerFailure(message: 'Invalid credentials', code: '401');
    when(mockAuthRepository.login(any, any))
        .thenAnswer((_) async => Left(tFailure));

    // act
    final result = await loginUseCase(
        LoginParams(email: tEmail, password: tPassword));

    // assert
    expect(result, Left(tFailure));
    verify(mockAuthRepository.login(tEmail, tPassword));
    verifyNoMoreInteractions(mockAuthRepository);
  });
} 