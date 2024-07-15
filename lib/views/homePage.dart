import 'package:flutter/material.dart';
import 'package:frontend_inventary_mobile/components/footerComponent.dart';
import 'package:frontend_inventary_mobile/components/headerComponent.dart';
import 'package:frontend_inventary_mobile/views/backtoOrderPage.dart';
import 'package:frontend_inventary_mobile/views/finishedOrderPage.dart';
import 'package:frontend_inventary_mobile/views/orderCancellationPage.dart';
import 'package:frontend_inventary_mobile/views/orderDetailPage.dart';
import 'package:frontend_inventary_mobile/views/orderTrackingPage.dart'; // Importa otras pantallas según sea necesario

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: const HeaderComponent(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bienvenido Admin',
                    style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFF555555),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Dashboard',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 5,
                          ),
                          child: const Text(
                            'Órdenes de ingreso',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8), // Añadir un espacio entre los botones
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 5,
                          ),
                          child: const Text(
                            'Pedidos por surtir',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'No de orden',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Estatus',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Detalles',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildOrderRow(context, '123456', 'Recibida', const Color(0xFF6289EC), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OrderDetailPage()),
                    );
                  }),
                  const Divider(),
                  _buildOrderRow(context, '123457', 'Ubicando productos', Colors.yellow, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OrderTrackingPage()), // Cambia esto según la pantalla adecuada
                    );
                  }),
                  const Divider(),
                  _buildOrderRow(context, '123458', 'En espera', Colors.grey, () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const OrderDetailPage()), // Cambia esto según la pantalla adecuada
                    // );
                  }),
                  const Divider(),
                  _buildOrderRow(context, '123459', 'Cancelada', Colors.red, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OrderCancellationPage()), // Cambia esto según la pantalla adecuada
                    );
                  }),
                  const Divider(),
                  _buildOrderRow(context, '123460', 'Finalizada', Colors.green, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FinishedOrderPage()), // Cambia esto según la pantalla adecuada
                    );
                  }),
                  const Divider(),
                  _buildOrderRow(context, '123461', 'Back order', Colors.purple, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BackToOrderPage()), // Cambia esto según la pantalla adecuada
                    );
                  }),
                  const Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const FooterComponent(),
    );
  }

  Widget _buildOrderRow(BuildContext context, String orderNumber, String status, Color color, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            orderNumber,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Text(
              status,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: onPressed,
            child: Column(
              children: [
                const Text(
                  'Ver más',
                  style: TextStyle(
                    color: Color(0xFF888888),
                  ),
                ),
                Container(
                  height: 1,
                  width: 50,
                  color: const Color(0xFF888888),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
