import 'package:flutter/material.dart';
import 'package:frontend_inventary_mobile/provider/selected_screen_provider.dart';
import 'package:frontend_inventary_mobile/views/homePage.dart';
import 'package:frontend_inventary_mobile/views/mainMenuPage.dart';
import 'package:frontend_inventary_mobile/views/searchPage.dart';
import 'package:frontend_inventary_mobile/views/seeInventoryPage.dart';
import 'package:frontend_inventary_mobile/views/settingsPage.dart';
import 'package:provider/provider.dart';

class FooterComponent extends StatelessWidget {
  const FooterComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildIconButton(context, 0, Icons.home, HomePage()),
              _buildIconButton(context, 1, Icons.inventory, SearchPage()),
              const SizedBox(width: 56), // Espacio para el botón flotante
              _buildIconButton(context, 2, Icons.receipt, SeeInventoryPage()),
              _buildIconButton(context, 3, Icons.person_rounded, SettingsPage()),
            ],
          ),
        ),
        Positioned(
          top: -28, // Elevar el botón flotante
          left: MediaQuery.of(context).size.width / 2 - 28, // Centrar horizontalmente
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainMenuPage()),
              );
            },
            backgroundColor: Colors.blue, // Set the button color to blue
            child: const Icon(
              Icons.add_circle_outline,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIconButton(BuildContext context, int index, IconData icon, Widget? page) {
    final selectedScreenProvider = Provider.of<SelectedScreenProvider>(context);
    final isSelected = selectedScreenProvider.selectedScreen == index;

    return IconButton(
      onPressed: () {
        if (page != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        }
        selectedScreenProvider.selectScreen(index);
      },
      icon: Icon(
        icon,
        color: isSelected ? Colors.blue : Colors.grey,
        size: 30,
      ),
    );
  }
}
