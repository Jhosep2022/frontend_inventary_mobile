import 'package:flutter/material.dart';
import 'package:frontend_inventary_mobile/components/footerComponent.dart';
import 'package:frontend_inventary_mobile/components/headerComponent.dart';
import 'package:frontend_inventary_mobile/state/movements_state.dart';
import 'package:provider/provider.dart';

class SeeInventoryPage extends StatelessWidget {
  const SeeInventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovementsState(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: HeaderComponent(),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFilterSection(context),
              const SizedBox(height: 16),
              _buildInventoryList(),
            ],
          ),
        ),
        bottomNavigationBar: const FooterComponent(),
      ),
    );
  }

  Widget _buildFilterSection(BuildContext context) {
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
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Filtrar inventario por:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_drop_down_circle_outlined,
                          color: Colors.blue, size: 25),
                      onPressed: () {
                        context
                            .read<MovementsState>()
                            .toggleFilterVisibility();
                      },
                    ),
                  ],
                ),
                if (context.watch<MovementsState>().isFilterVisible) ...[
                  const SizedBox(height: 8),
                  Column(
                    children: context
                        .watch<MovementsState>()
                        .filters
                        .keys
                        .map((String key) {
                      return Column(
                        children: [
                          _buildFilterCheckbox(context, key),
                          const Divider(height: 1),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Acción al presionar el botón de aplicar filtro
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 5,
            ),
            child: const Text(
              'Aplicar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterCheckbox(BuildContext context, String title) {
    return CheckboxListTile(
      title: Text(title),
      value: context.watch<MovementsState>().filters[title],
      onChanged: (bool? newValue) {
        context.read<MovementsState>().toggleFilter(title);
      },
      activeColor: Colors.blue,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Widget _buildInventoryList() {
    final items = {
      'A': ['Lorem ipsum', 'Lorem ipsum', 'Lorem ipsum'],
      'B': ['Lorem ipsum'],
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.keys.map((String key) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              key,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              children: items[key]!
                  .map((item) => Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child: const Icon(Icons.image, color: Colors.grey),
                          ),
                          title: Text(item),
                          trailing: IconButton(
                            icon: const Icon(Icons.more_vert, color: Colors.blue),
                            onPressed: () {
                              // Acción al presionar el botón de más opciones
                            },
                          ),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
          ],
        );
      }).toList(),
    );
  }
}
