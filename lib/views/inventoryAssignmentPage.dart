import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend_inventary_mobile/models/inventoryRequest.dart';
import 'package:frontend_inventary_mobile/models/productOrder.dart';
import 'package:frontend_inventary_mobile/models/producto.dart';
import 'package:frontend_inventary_mobile/provider/InventoryBloc/inventory_bloc.dart';
import 'package:frontend_inventary_mobile/provider/InventoryBloc/inventory_event.dart';
import 'package:frontend_inventary_mobile/provider/InventoryBloc/inventory_state.dart';
import 'package:frontend_inventary_mobile/provider/user_bloc/users_bloc.dart';
import 'package:frontend_inventary_mobile/provider/user_bloc/users_event.dart';
import 'package:frontend_inventary_mobile/provider/user_bloc/users_state.dart';
import 'package:frontend_inventary_mobile/components/footerComponent.dart';
import 'package:frontend_inventary_mobile/components/headerComponent.dart';
import 'package:frontend_inventary_mobile/utils/toast_utils.dart';
import 'package:frontend_inventary_mobile/views/newRegisteredInventoryPage.dart';
import 'package:intl/intl.dart';


class InventoryAssignmentPage extends StatefulWidget {
  final List<Producto> selectedProducts;
  final int selectedAreaId;
  final String formattedDate;

  const InventoryAssignmentPage({
    Key? key,
    required this.selectedProducts,
    required this.selectedAreaId,
    required this.formattedDate,
  }) : super(key: key);

  @override
  _InventoryAssignmentPageState createState() => _InventoryAssignmentPageState();
}

class _InventoryAssignmentPageState extends State<InventoryAssignmentPage> {
  bool assignToOneUser = true;
  bool assignToMultipleUsers = false;
  String? selectedUser;
  List<String?> selectedUsersForProducts = [];

  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(FetchUsers(1)); // Cambia '1' al id de la compañía apropiado
    selectedUsersForProducts = List.filled(widget.selectedProducts.length, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: HeaderComponent(),
      ),
      body: BlocListener<InventoryBloc, InventoryState>(
        listener: (context, state) {
          if (state is InventorySuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const NewRegisteredInventoryPage()),
            );
          } else if (state is InventoryError) {
            // Se maneja el error con un toast, que ya se muestra en el bloc
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderSummary(),
            Expanded(
              child: _buildMainContainer(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const FooterComponent(),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nuevo Inventario',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Área de creación: Área ${widget.selectedAreaId}', // Cambia esto para mostrar el área real si es necesario
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            'Fecha de creación: ${widget.formattedDate}',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
        ],
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(
                value: assignToOneUser,
                onChanged: (bool? value) {
                  setState(() {
                    assignToOneUser = value!;
                    assignToMultipleUsers = !value;
                  });
                },
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Asignar a un solo usuario para acomodar los productos',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(width: 8),
              Checkbox(
                value: assignToMultipleUsers,
                onChanged: (bool? value) {
                  setState(() {
                    assignToMultipleUsers = value!;
                    assignToOneUser = !value;
                  });
                },
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Asignar a varios usuarios para acomodar los productos',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          if (assignToOneUser)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: _buildUserDropdown(),
            ),
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
            child: _buildProductList(),
          ),
          const SizedBox(height: 26),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _submitInventory(context); // Aquí llamas al método para enviar el inventario
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 90,
                  vertical: 10,
                ),
              ),
              child: const Text(
                'Aceptar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.selectedProducts.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            _buildProductItem(widget.selectedProducts[index], index),
            if (index < widget.selectedProducts.length - 1) const Divider(),
          ],
        );
      },
    );
  }

  Widget _buildProductItem(Producto product, int index) {
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
          if (assignToMultipleUsers)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: _buildProductUserDropdown(index),
            ),
        ],
      ),
    );
  }

  Widget _buildUserDropdown() {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        if (state is UsersLoading) {
          return const CircularProgressIndicator();
        } else if (state is UsersLoaded) {
          return DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Seleccionar usuario',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            value: selectedUser,
            items: state.users.map((user) {
              return DropdownMenuItem<String>(
                value: user.id.toString(), // Asegúrate de utilizar el ID en lugar del nombre
                child: Text(user.name),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedUser = value;
              });
            },
          );
        } else if (state is UsersError) {
          return Text('Error al cargar usuarios: ${state.message}');
        }
        return Container();
      },
    );
  }

  Widget _buildProductUserDropdown(int index) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        if (state is UsersLoaded) {
          return DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Seleccionar usuario',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            value: selectedUsersForProducts[index],
            items: state.users.map((user) {
              return DropdownMenuItem<String>(
                value: user.id.toString(), // Asegúrate de utilizar el ID en lugar del nombre
                child: Text(user.name),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedUsersForProducts[index] = value;
              });
            },
          );
        } else if (state is UsersError) {
          return Text('Error al cargar usuarios: ${state.message}');
        }
        return Container();
      },
    );
  }

  void _submitInventory(BuildContext context) async {
    final storage = FlutterSecureStorage();
    final String? userId = await storage.read(key: 'userId');

    if (userId == null) {
      showErrorToast('No se pudo obtener el ID del usuario autenticado');
      return;
    }

    final List<ProductOrder> productOrders = [];

    for (int i = 0; i < widget.selectedProducts.length; i++) {
      final product = widget.selectedProducts[i];
      final String userOrder = assignToOneUser
          ? selectedUser != null
              ? selectedUser!
              : userId
          : selectedUsersForProducts[i] ?? userId;

      // Añade el producto con los tipos correctos
      productOrders.add(ProductOrder(
        idProduct: product.id,  // Es un entero, se envía como int
        idUserOrder: int.parse(userOrder),  // Convertido a int
      ));
    }

    // Convertir la fecha al formato correcto y asegurarse de que es un String
    final DateTime parsedDate = DateFormat('dd/MM/yyyy hh:mm a').parse(widget.formattedDate);
    final String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(parsedDate);

    final inventoryRequest = InventoryRequest(
      idArea: widget.selectedAreaId.toString(),  // Convertido a String
      fechaHora: formattedDate.toString(),  // String
      idUser: userId.toString(),  // String
      products: productOrders,
    );

    // Imprimir el JSON antes de enviarlo para verificación
    print('JSON a enviar: ${inventoryRequest.toJson()}');

    context.read<InventoryBloc>().add(UploadInventory(inventoryRequest));
  }
}
