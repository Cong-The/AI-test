import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_example/core/error/failures.dart';
import 'package:login_example/features/auth/domain/entities/user.dart';
import 'package:login_example/features/auth/domain/usecases/login_usecase.dart';
import 'package:login_example/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_bloc_test.mocks.dart';

@GenerateMocks([LoginUseCase])
void main() {
  late AuthBloc authBloc;
  late MockLoginUseCase mockLoginUseCase;
  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    authBloc = AuthBloc(loginUseCase: mockLoginUseCase);
  });

  tearDown(() {
    authBloc.close();
  });

  final tEmail = 'test@example.com';
  final tPassword = 'password';
  final tUser = User(
    id: '1',
    email: tEmail,
    name: 'Test User',
    token: 'test_token',
  );

  test('initial state should be AuthInitial', () {
    // assert
    expect(authBloc.state, equals(AuthInitial()));
  });

  group('LoginEvent', () {
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthAuthenticated] when login is successful',
      build: () {
        when(mockLoginUseCase(any)).thenAnswer((_) async => Right(tUser));
        return authBloc;
      },
      act: (bloc) => bloc.add(LoginEvent(email: tEmail, password: tPassword)),
      expect: () => [
        AuthLoading(),
        AuthAuthenticated(user: tUser),
      ],
      verify: (bloc) {
        verify(mockLoginUseCase(LoginParams(
          email: tEmail,
          password: tPassword,
        )));
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthError] when login fails',
      build: () {
        when(mockLoginUseCase(any)).thenAnswer((_) async => Left(
            ServerFailure(message: 'Invalid credentials', code: '401')));
        return authBloc;
      },
      act: (bloc) => bloc.add(LoginEvent(email: tEmail, password: tPassword)),
      expect: () => [
        AuthLoading(),
        AuthError(message: 'Invalid credentials'),
      ],
      verify: (bloc) {
        verify(mockLoginUseCase(LoginParams(
          email: tEmail,
          password: tPassword,
        )));
      },
    );
  });
} 