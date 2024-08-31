import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_inventary_mobile/provider/auth_bloc/auth_bloc.dart';
import 'package:frontend_inventary_mobile/provider/auth_bloc/auth_event.dart';
import 'package:frontend_inventary_mobile/provider/auth_bloc/auth_state.dart';
import 'package:frontend_inventary_mobile/provider/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:frontend_inventary_mobile/provider/profile_bloc/profile_bloc.dart';
import 'package:frontend_inventary_mobile/provider/selected_screen_provider.dart';
import 'package:frontend_inventary_mobile/provider/products_bloc/products_bloc.dart';
import 'package:frontend_inventary_mobile/provider/areas_bloc/areas_bloc.dart';
import 'package:frontend_inventary_mobile/provider/user_bloc/users_bloc.dart';
import 'package:frontend_inventary_mobile/services/authService.dart';
import 'package:frontend_inventary_mobile/services/forgotPasswordService.dart';
import 'package:frontend_inventary_mobile/services/profile_service.dart';
import 'package:frontend_inventary_mobile/services/inventoryService.dart';
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
  final inventoryService = InventoryService(); 

  runApp(MyApp(
    authService: authService,
    forgotPasswordService: forgotPasswordService,
    profileService: profileService,
    inventoryService: inventoryService, 
  ));
}

class MyApp extends StatelessWidget {
  final AuthService authService;
  final ForgotPasswordService forgotPasswordService;
  final ProfileService profileService;
  final InventoryService inventoryService; 

  MyApp({
    required this.authService,
    required this.forgotPasswordService,
    required this.profileService,
    required this.inventoryService, 
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
          authBloc.add(AppStarted());  
          return authBloc;
        }),
        BlocProvider(create: (context) => ForgotPasswordBloc(forgotPasswordService)),
        BlocProvider(create: (context) => ProfileBloc(profileService)),
        BlocProvider(create: (context) => ProductsBloc(inventoryService)), 
        BlocProvider(create: (context) => AreasBloc(inventoryService)), 
        BlocProvider(create: (context) => UsersBloc(inventoryService)), // Añadir UsersBloc
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
            } else if (state is AuthInitial) {
              return LoginPageContainer();  
            } else if (state is AuthError) {
              // Opcional: Puedes manejar un estado de error aquí
              return LoginPageContainer();  
            } else {
              // Mientras se carga, podrías mostrar una pantalla de splash o loader
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),

        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
