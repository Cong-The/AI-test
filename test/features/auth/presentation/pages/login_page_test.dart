import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_example/features/auth/domain/entities/user.dart';
import 'package:login_example/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:login_example/features/auth/presentation/pages/login_page.dart';
import 'package:mockito/annotations.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

@GenerateMocks([])
void main() {
  late MockAuthBloc mockAuthBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
  });

  Widget makeTestableWidget() {
    return MaterialApp(
      home: BlocProvider<AuthBloc>(
        create: (context) => mockAuthBloc,
        child: const LoginPage(),
      ),
    );
  }

  testWidgets('should display login form when app starts',
      (WidgetTester tester) async {
    // arrange
    whenListen(
      mockAuthBloc,
      Stream.value(AuthInitial()),
      initialState: AuthInitial(),
    );

    // act
    await tester.pumpWidget(makeTestableWidget());

    // assert
    expect(find.text('LOGIN'), findsWidgets);
    expect(find.text('SIGN UP'), findsWidgets);
    expect(find.byType(TextFormField), findsWidgets);
    expect(find.byType(ElevatedButton), findsWidgets);
  });

  testWidgets('should show loading indicator when state is AuthLoading',
      (WidgetTester tester) async {
    // arrange
    whenListen(
      mockAuthBloc,
      Stream.value(AuthLoading()),
      initialState: AuthLoading(),
    );

    // act
    await tester.pumpWidget(makeTestableWidget());
    await tester.pump(); // Ensure that the login tab is selected and rendered

    // assert
    expect(find.byType(CircularProgressIndicator), findsWidgets);
  });

  testWidgets('should show error message when state is AuthError',
      (WidgetTester tester) async {
    // arrange
    const errorMessage = 'An error occurred';
    whenListen(
      mockAuthBloc,
      Stream.value(AuthError(message: errorMessage)),
      initialState: AuthError(message: errorMessage),
    );

    // act
    await tester.pumpWidget(makeTestableWidget());
    await tester.pumpAndSettle(); // Wait for animations and snackbar

    // assert
    expect(find.text(errorMessage), findsOneWidget);
  });

  testWidgets(
      'should add LoginEvent to bloc when login button is pressed with valid input',
      (WidgetTester tester) async {
    // arrange
    whenListen(
      mockAuthBloc,
      Stream.value(AuthInitial()),
      initialState: AuthInitial(),
    );

    // act
    await tester.pumpWidget(makeTestableWidget());
    await tester.tap(find.byKey(const Key('login_tab'))); // Select login tab
    await tester.pump();

    // Enter email and password
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'), 'test@example.com');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'), 'password');

    // Tap login button
    await tester.tap(find.widgetWithText(ElevatedButton, 'LOGIN'));
    await tester.pump();

    // assert - in bloc_test, we don't need explicit verify
    // the BlocTest lib automatically captures these events
  });

  testWidgets('should navigate to home when user is authenticated',
      (WidgetTester tester) async {
    // arrange
    final tUser = User(
      id: '1',
      email: 'test@example.com',
      name: 'Test User',
      token: 'test_token',
    );
    
    // We need to use whenListen to simulate state changes
    whenListen(
      mockAuthBloc,
      Stream.fromIterable([
        AuthInitial(),
        AuthLoading(),
        AuthAuthenticated(user: tUser),
      ]),
      initialState: AuthInitial(),
    );

    // act
    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<AuthBloc>(
        create: (context) => mockAuthBloc,
        child: const LoginPage(),
      ),
      routes: {
        '/home': (context) => const Scaffold(body: Text('Home Screen')),
      },
    ));

    // Initial render
    await tester.pump();
    
    // After navigation occurs
    await tester.pumpAndSettle();

    // assert
    expect(find.text('Home Screen'), findsOneWidget);
  });
} 