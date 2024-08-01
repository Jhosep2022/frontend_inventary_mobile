import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_inventary_mobile/provider/auth_bloc/auth_bloc.dart';
import 'package:frontend_inventary_mobile/provider/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:frontend_inventary_mobile/provider/selected_screen_provider.dart';
import 'package:frontend_inventary_mobile/services/authService.dart';
import 'package:frontend_inventary_mobile/services/forgotPasswordService.dart';
import 'package:frontend_inventary_mobile/state/movements_state.dart';
import 'package:frontend_inventary_mobile/state/registered_product_state.dart';
import 'package:frontend_inventary_mobile/views/loginPage.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final authService = AuthService();
  final forgotPasswordService = ForgotPasswordService();
  runApp(MyApp(authService: authService, forgotPasswordService: forgotPasswordService));
}

class MyApp extends StatelessWidget {
  final AuthService authService;
  final ForgotPasswordService forgotPasswordService;

  MyApp({required this.authService, required this.forgotPasswordService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovementsState()),
        ChangeNotifierProvider(create: (_) => RegisteredProductState()),
        ChangeNotifierProvider(create: (_) => SelectedScreenProvider()),
        BlocProvider(create: (context) => AuthBloc(authService)),
        BlocProvider(
            create: (context) => ForgotPasswordBloc(forgotPasswordService)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPageContainer(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
