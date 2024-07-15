import 'package:flutter/material.dart';
import 'package:frontend_inventary_mobile/components/footerComponent.dart';
import 'package:frontend_inventary_mobile/components/headerComponent.dart';
import 'package:frontend_inventary_mobile/views/Employee/availableLocationsOrdersPage.dart';

class FillOrdersPage extends StatelessWidget {
  const FillOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: HeaderComponent(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pedidos asignados',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            _buildOrdersTable(context),
          ],
        ),
      ),
      bottomNavigationBar: const FooterComponent(),
    );
  }

  Widget _buildOrdersTable(BuildContext context) {
    final columns = ['No. de orden', 'Fecha', 'Detalles'];
    final rows = List<DataRow>.generate(
      10,
      (index) => DataRow(
        color: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
          // Alternar color de las filas
          return index.isEven ? Colors.grey.withOpacity(0.1) : Colors.white;
        }),
        cells: [
          DataCell(Text('123')),
          DataCell(Text('01 Abril, 2024')),
          DataCell(TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AvailableLocationsOrdersPage(),
                ),
              );
            },
            child: const Text(
              'Ver más',
              style: TextStyle(color: Colors.blue),
            ),
          )),
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return Colors.blue; // Color de fondo de las cabeceras
            },
          ),
          columns: columns
              .map((column) => DataColumn(
                    label: Text(
                      column,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Color del texto de las cabeceras
                      ),
                    ),
                  ))
              .toList(),
          rows: rows,
        ),
      ),
    );
  }
}