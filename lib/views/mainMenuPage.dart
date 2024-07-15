import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend_inventary_mobile/components/footerComponent.dart';
import 'package:frontend_inventary_mobile/components/headerComponent.dart';
import 'package:frontend_inventary_mobile/views/newInventoryPage.dart';
import 'package:frontend_inventary_mobile/views/searchKitsPage.dart';
import 'package:frontend_inventary_mobile/views/searchPage.dart';
import 'package:frontend_inventary_mobile/views/seeInventoryPage.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: HeaderComponent(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildMenuItem(
              svgPath: 'assets/caja.svg',
              label: 'Ingresar pedidos',
              onTap: () {},
            ),
            _buildMenuItem(
              svgPath: 'assets/carrito.svg',
              label: 'Surtir pedidos',
              onTap: () {},
            ),
            _buildMenuItem(
              svgPath: 'assets/buscador.svg',
              label: 'Buscar productos',
              onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
              },
            ),
            _buildMenuItem(
              svgPath: 'assets/lista.svg',
              label: 'Ver inventario',
              onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SeeInventoryPage()),
              );
              },
            ),
            _buildMenuItem(
              svgPath: 'assets/kits.svg',
              label: 'Kits',
              onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchKitsPage()),
              );
              },
            ),
            _buildMenuItem(
              svgPath: 'assets/agregarLista.svg',
              label: 'Nuevo inventario',
              onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewInventaryPage()),
              );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const FooterComponent(),
    );
  }

  Widget _buildMenuItem({required String svgPath, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              height: 90,
              width: 90,
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}