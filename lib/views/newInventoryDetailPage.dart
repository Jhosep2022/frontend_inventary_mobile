import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_inventary_mobile/components/footerComponent.dart';
import 'package:frontend_inventary_mobile/components/headerSettingsComponent.dart';
import 'package:frontend_inventary_mobile/provider/areas_bloc/areas_bloc.dart';
import 'package:frontend_inventary_mobile/provider/inventory_Detail_bloc/inventory_Detail_bloc.dart';
import 'package:frontend_inventary_mobile/provider/inventory_Detail_bloc/inventory_detail_event.dart';
import 'package:frontend_inventary_mobile/provider/inventory_Detail_bloc/inventory_detail_state.dart';
import 'package:frontend_inventary_mobile/provider/products_bloc/products_bloc.dart';
import 'package:frontend_inventary_mobile/views/inventoryAssignmentPage.dart';

import '../models/producto.dart';

class NewInventoryDetailPage extends StatelessWidget {
  final List<int> selectedProductIds;
  final int selectedAreaId;
  final String selectedDate;
  final String selectedTime;

  const NewInventoryDetailPage({
    super.key,
    required this.selectedProductIds,
    required this.selectedAreaId,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InventoryDetailBloc(
        productsBloc: BlocProvider.of<ProductsBloc>(context),
        areasBloc: BlocProvider.of<AreasBloc>(context),
      )..add(LoadInventoryDetail(
          productIds: selectedProductIds,
          areaId: selectedAreaId,
        )),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: HeaderSettingsComponent(title: 'Nuevo inventario'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: _buildMainContainer(context),
            ),
          ],
        ),
        bottomNavigationBar: const FooterComponent(),
      ),
    );
  }

  Widget _buildMainContainer(BuildContext context) {
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
      child: BlocBuilder<InventoryDetailBloc, InventoryDetailState>(
        builder: (context, state) {
          if (state is InventoryDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is InventoryDetailLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOrderSummary(state),
                const SizedBox(height: 16),
                const Text(
                  'Listado de productos:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: _buildProductList(state.selectedProducts),
                ),
                const SizedBox(height: 26),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InventoryAssignmentPage(
                            selectedProducts: state.selectedProducts,
                            selectedAreaId: selectedAreaId,
                            formattedDate: '$selectedDate $selectedTime',
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      'Asignar encargados del registro de inventario',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is InventoryDetailError) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildOrderSummary(InventoryDetailLoaded state) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Nuevo Inventario',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Área de creación: ${state.selectedArea.name}',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            'Fecha de creación: $selectedDate $selectedTime',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildProductList(List<Producto> products) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            _buildProductItem(products[index]),
            if (index < products.length - 1) const Divider(),
          ],
        );
      },
    );
  }

  Widget _buildProductItem(Producto product) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                child: Icon(Icons.image, size: 30, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.sku,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Cantidad: ${product.total}',
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
