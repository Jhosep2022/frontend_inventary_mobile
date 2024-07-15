import 'package:flutter/material.dart';
import 'package:frontend_inventary_mobile/components/footerComponent.dart';
import 'package:frontend_inventary_mobile/components/settingsItem.dart';
import 'package:frontend_inventary_mobile/views/historical_clientsPage.dart';
import 'package:frontend_inventary_mobile/views/movementsPage.dart';
import 'package:frontend_inventary_mobile/views/profilePage.dart';
import 'package:frontend_inventary_mobile/views/stadisticPage.dart';
import 'package:frontend_inventary_mobile/views/subscriptionPage.dart';
import 'package:frontend_inventary_mobile/views/usersPAge.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes', style: TextStyle(fontSize: 28),), 
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black), 
        toolbarTextStyle: const TextTheme(
          titleLarge: TextStyle( 
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ).bodyText2,
        titleTextStyle: const TextTheme( 
          titleLarge: TextStyle( 
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ).headline6,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Personal',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
                SettingsItem(
                title: 'Perfil',
                onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                ),
              SettingsItem(
                title: 'Subscripción',
                onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubscriptionPage()),
                  );
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Admin',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
                SettingsItem(
                title: 'Estadísticas',
                onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatisticPage()),
                  );
                },
                ),
                SettingsItem(
                title: 'Movimientos',
                onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MovementsPage()),
                  );
                },
                ),
                SettingsItem(
                title: 'Historial de clientes',
                onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Historical_clientsPage()),
                  );
                },
                ),
                SettingsItem(
                title: 'Usuarios',
                onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UsersPage()),
                  );
                },
                ),
              SettingsItem(
                title: 'Configuración',
                onTap: () {
                  // Navegar a la pantalla de Configuración
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const FooterComponent(),
    );
  }
}
