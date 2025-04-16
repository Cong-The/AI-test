import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _loginFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _signupEmailController = TextEditingController();
  final _signupPasswordController = TextEditingController();
  bool _rememberMe = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _signupEmailController.dispose();
    _signupPasswordController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5D91C9),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is AuthAuthenticated) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TabBar(
                            controller: _tabController,
                            tabs: const [
                              Tab(text: 'SIGN UP'),
                              Tab(key: Key('login_tab'), text: 'LOGIN'),
                            ],
                            labelColor: Colors.black87,
                            unselectedLabelColor: Colors.grey,
                            indicatorSize: TabBarIndicatorSize.tab,
                          ),
                          SizedBox(
                            height: 400,
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                // Sign Up Tab
                                SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Form(
                                      key: _signupFormKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          const SizedBox(height: 8),
                                          const Text('Email',
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                          TextFormField(
                                            controller: _signupEmailController,
                                            decoration: const InputDecoration(
                                              border: UnderlineInputBorder(),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your email';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(height: 16),
                                          const Text('Password',
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                          TextFormField(
                                            controller:
                                                _signupPasswordController,
                                            obscureText: true,
                                            decoration: const InputDecoration(
                                              border: UnderlineInputBorder(),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your password';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(height: 24),
                                          ElevatedButton(
                                            onPressed: () {
                                              if (_signupFormKey.currentState!
                                                  .validate()) {
                                                // Handle signup
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFFEF5DA8),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                            ),
                                            child: const Text('SIGN UP',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                          const SizedBox(height: 16),
                                          const Row(
                                            children: [
                                              Expanded(child: Divider()),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.0),
                                                child: Text('OR',
                                                    style: TextStyle(
                                                        color: Colors.grey)),
                                              ),
                                              Expanded(child: Divider()),
                                            ],
                                          ),
                                          const SizedBox(height: 16),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              _socialButton(
                                                  FontAwesomeIcons.google,
                                                  Colors.red),
                                              const SizedBox(width: 16),
                                              _socialButton(
                                                  FontAwesomeIcons.facebook,
                                                  Colors.blue),
                                              const SizedBox(width: 16),
                                              _socialButton(
                                                  FontAwesomeIcons.linkedin,
                                                  Colors.lightBlue),
                                            ],
                                          ),
                                          const SizedBox(height: 16),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text('Already a user?',
                                                  style: TextStyle(
                                                      color: Colors.grey)),
                                              TextButton(
                                                onPressed: () {
                                                  _tabController.animateTo(1);
                                                },
                                                child: const Text('LOGIN',
                                                    style: TextStyle(
                                                        color: Colors.blue)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                // Login Tab
                                SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Form(
                                      key: _loginFormKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          const SizedBox(height: 8),
                                          const Text('Email',
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                          TextFormField(
                                            controller: _emailController,
                                            decoration: const InputDecoration(
                                              border: UnderlineInputBorder(),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your email';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(height: 16),
                                          const Text('Password',
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                          TextFormField(
                                            controller: _passwordController,
                                            obscureText: true,
                                            decoration: const InputDecoration(
                                              border: UnderlineInputBorder(),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your password';
                                              }
                                              return null;
                                            },
                                          ),
                                          Row(
                                            children: [
                                              Checkbox(
                                                value: _rememberMe,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _rememberMe =
                                                        value ?? false;
                                                  });
                                                },
                                                activeColor:
                                                    const Color(0xFFEF5DA8),
                                              ),
                                              const Text('Remember me?',
                                                  style: TextStyle(
                                                      color: Colors.grey)),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          ElevatedButton(
                                            onPressed: state is AuthLoading
                                                ? null
                                                : () {
                                                    if (_loginFormKey
                                                        .currentState!
                                                        .validate()) {
                                                      context
                                                          .read<AuthBloc>()
                                                          .add(
                                                            LoginEvent(
                                                              email:
                                                                  _emailController
                                                                      .text,
                                                              password:
                                                                  _passwordController
                                                                      .text,
                                                            ),
                                                          );
                                                    }
                                                  },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFFEF5DA8),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                            ),
                                            child: state is AuthLoading
                                                ? const CircularProgressIndicator(
                                                    color: Colors.white)
                                                : const Text('LOGIN',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: TextButton(
                                              onPressed: () {
                                                // Forgot password logic
                                              },
                                              child: const Text(
                                                  'Forgot Password?',
                                                  style: TextStyle(
                                                      color: Colors.grey)),
                                            ),
                                          ),
                                          const Row(
                                            children: [
                                              Expanded(child: Divider()),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.0),
                                                child: Text('OR',
                                                    style: TextStyle(
                                                        color: Colors.grey)),
                                              ),
                                              Expanded(child: Divider()),
                                            ],
                                          ),
                                          const SizedBox(height: 16),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              _socialButton(
                                                  FontAwesomeIcons.google,
                                                  Colors.red),
                                              const SizedBox(width: 16),
                                              _socialButton(
                                                  FontAwesomeIcons.facebook,
                                                  Colors.blue),
                                              const SizedBox(width: 16),
                                              _socialButton(
                                                  FontAwesomeIcons.linkedin,
                                                  Colors.lightBlue),
                                            ],
                                          ),
                                          const SizedBox(height: 16),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text('Need an account?',
                                                  style: TextStyle(
                                                      color: Colors.grey)),
                                              TextButton(
                                                onPressed: () {
                                                  _tabController.animateTo(0);
                                                },
                                                child: const Text('SIGN UP',
                                                    style: TextStyle(
                                                        color: Colors.blue)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _socialButton(IconData icon, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 1),
      ),
      child: Center(
        child: FaIcon(icon, color: color, size: 20),
      ),
    );
  }
}
