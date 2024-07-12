import 'package:flutter/material.dart';
import 'package:frontend_inventary_mobile/state/movements_state.dart';
import 'package:provider/provider.dart';
import 'package:frontend_inventary_mobile/components/footerComponent.dart';
import 'package:frontend_inventary_mobile/components/headerSettingsComponent.dart';

class Historical_clientsPage extends StatelessWidget {
  const Historical_clientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovementsState(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: HeaderSettingsComponent(
            title: 'Historial clientes',
            onBackButtonPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15,),
                _buildSearchAndDownloadSection(),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: _buildMovementsTable(),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const FooterComponent(),
      ),
    );
  }

  Widget _buildSearchAndDownloadSection() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50, // Ajusta la altura según tus necesidades
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: Icon(Icons.search_rounded, color: Colors.grey, size: 30,), 
              contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0), 
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: () {
            // Acción al presionar el botón de descargar
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 3,
          ),
          child: const Icon(Icons.download, color: Colors.grey),
        ),
      ],
    );
  }


  Widget _buildMovementsTable() {
    final columns = [
      'Código',
      'Fecha',
      'Referencia',
      'Cliente',
      'Total de venta',
      'Estado'
    ];

    final rows = List<DataRow>.generate(
      10,
      (index) => DataRow(
        cells: [
          DataCell(Text('123')),
          DataCell(Text('01/01/2023')),
          DataCell(Text('REF123')),
          DataCell(Text('Cliente')),
          DataCell(Text('\$100.00')),
          DataCell(
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Entregado',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
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
