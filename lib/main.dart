import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_inventary_mobile/provider/auth_bloc/auth_bloc.dart';
import 'package:frontend_inventary_mobile/provider/auth_bloc/auth_event.dart';
import 'package:frontend_inventary_mobile/provider/auth_bloc/auth_state.dart';
import 'package:frontend_inventary_mobile/provider/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:frontend_inventary_mobile/provider/profile_bloc/profile_bloc.dart';
import 'package:frontend_inventary_mobile/provider/selected_screen_provider.dart';
import 'package:frontend_inventary_mobile/services/authService.dart';
import 'package:frontend_inventary_mobile/services/forgotPasswordService.dart';
import 'package:frontend_inventary_mobile/services/profile_service.dart';
import 'package:frontend_inventary_mobile/state/movements_state.dart';
import 'package:frontend_inventary_mobile/state/registered_product_state.dart';
import 'package:frontend_inventary_mobile/views/homePage.dart';
import 'package:frontend_inventary_mobile/views/loginPage.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final authService = AuthService();
  final forgotPasswordService = ForgotPasswordService();
  final profileService = ProfileService();

  runApp(MyApp(
    authService: authService,
    forgotPasswordService: forgotPasswordService,
    profileService: profileService,
  ));
}

class MyApp extends StatelessWidget {
  final AuthService authService;
  final ForgotPasswordService forgotPasswordService;
  final ProfileService profileService;

  MyApp({
    required this.authService,
    required this.forgotPasswordService,
    required this.profileService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovementsState()),
        ChangeNotifierProvider(create: (_) => RegisteredProductState()),
        ChangeNotifierProvider(create: (_) => SelectedScreenProvider()),
        BlocProvider(create: (context) {
          final authBloc = AuthBloc(authService);
          authBloc.add(AppStarted());  // Dispara el evento AppStarted al iniciar
          return authBloc;
        }),
        BlocProvider(create: (context) => ForgotPasswordBloc(forgotPasswordService)),
        BlocProvider(create: (context) => ProfileBloc(profileService)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return HomePage();  
            } else {
              return LoginPageContainer();  
            }
          },
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
