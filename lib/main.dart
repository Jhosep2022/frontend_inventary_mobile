import 'package:flutter/material.dart';
import 'package:frontend_inventary_mobile/provider/selected_screen_provider.dart';
import 'package:frontend_inventary_mobile/state/movements_state.dart';
import 'package:frontend_inventary_mobile/state/registered_product_state.dart';
import 'package:frontend_inventary_mobile/views/loginPage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovementsState()),
        ChangeNotifierProvider(create: (_) => RegisteredProductState()),
        ChangeNotifierProvider(create: (_) => SelectedScreenProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
        debugShowCheckedModeBanner: false, // Add this line to remove the red debug banner
      ),
    );
  }
}

