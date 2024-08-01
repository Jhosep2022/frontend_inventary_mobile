import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_inventary_mobile/provider/auth_bloc/auth_bloc.dart';
import 'package:frontend_inventary_mobile/provider/auth_bloc/auth_event.dart';
import 'package:frontend_inventary_mobile/provider/auth_bloc/auth_state.dart';
import 'package:frontend_inventary_mobile/views/Employee/fillOrdersPage.dart';
import 'package:frontend_inventary_mobile/views/forgotPasswordPage.dart';


class LoginPageContainer extends StatefulWidget {
  const LoginPageContainer({super.key});

  @override
  _LoginPageContainerState createState() => _LoginPageContainerState();
}

class _LoginPageContainerState extends State<LoginPageContainer> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoginPage(
      emailController: _emailController,
      passwordController: _passwordController,
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginPage({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo de burbujas
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/Bubbles.png',
              width: screenWidth,
              fit: BoxFit.cover,
            ),
          ),
          // Texto y logo que no se moverán
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const Text(
                  '¡Bienvenido!',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF1289D4),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Image.asset(
                  'assets/Logo.png',
                  height: 100,
                ),
              ],
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 400),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(19.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: -1,
                            blurRadius: 5,
                            offset: const Offset(0, -9),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Email',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: 'example@mail.com',
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal: 16.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Contraseña',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: '*******',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal: 16.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                          Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordPage()),
                                );
                              },
                              child: const Text(
                                '¿Olvidaste tu contraseña?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: BlocConsumer<AuthBloc, AuthState>(
                              listener: (context, state) {
                                if (state is AuthAuthenticated) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FillOrdersPage()),
                                  );
                                } else if (state is AuthError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Error: ${state.message}')),
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state is AuthLoading) {
                                  return const CircularProgressIndicator();
                                }
                                return ElevatedButton(
                                  onPressed: () {
                                    final email = emailController.text;
                                    final password = passwordController.text;
                                    print('Button pressed: email=$email, password=$password');
                                    BlocProvider.of<AuthBloc>(context).add(
                                        LoginRequested(email, password));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1289D4),
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  child: const Text(
                                    'Iniciar sesión',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}