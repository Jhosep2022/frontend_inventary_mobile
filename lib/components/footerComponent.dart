import 'package:flutter/material.dart';
import 'package:frontend_inventary_mobile/views/homePage.dart';
import 'package:frontend_inventary_mobile/views/mainMenuPage.dart';
import 'package:frontend_inventary_mobile/views/settingsPage.dart';

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
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                icon: const Icon(
                  Icons.home,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.inventory,
                  color: Colors.grey,
                  size: 30,
                ),
              ),
              const SizedBox(width: 56), // Espacio para el botón flotante
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.receipt,
                  color: Colors.grey,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
                icon: const Icon(
                  Icons.person_rounded,
                  color: Colors.grey,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -28, // Elevar el botón flotante
          left: MediaQuery.of(context).size.width / 2 -
              28, // Centrar horizontalmente
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainMenuPage())
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
}
