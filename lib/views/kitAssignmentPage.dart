import 'package:flutter/material.dart';
import 'package:frontend_inventary_mobile/components/footerComponent.dart';
import 'package:frontend_inventary_mobile/components/headerComponent.dart';
import 'package:frontend_inventary_mobile/views/kitTrackingPage.dart';
import 'package:frontend_inventary_mobile/views/orderTrackingPage.dart';
import 'package:frontend_inventary_mobile/views/productAssignmentPage.dart';
import 'package:frontend_inventary_mobile/views/productEntryPage.dart';

class KitAssignmentPage extends StatefulWidget {
  const KitAssignmentPage({super.key});

  @override
  _KitAssignmentPageState createState() => _KitAssignmentPageState();
}

class _KitAssignmentPageState extends State<KitAssignmentPage> {
  bool assignToOneUser = true;
  bool assignToMultipleUsers = false;
  String? selectedUser;
  List<String?> selectedUsersForProducts = List.filled(3, null); // Assuming you have 3 products

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: HeaderComponent(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Ubicacion de productos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          _buildOrderSummary(),
          Expanded(
            child: _buildMainContainer(context),
          ),
        ],
      ),
      bottomNavigationBar: const FooterComponent(),
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
              const Expanded(
                child: Text(
                  'Asignar a un solo usuario para acomodar los productos',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Checkbox(
                value: assignToMultipleUsers,
                onChanged: (bool? value) {
                  setState(() {
                    assignToMultipleUsers = value!;
                    assignToOneUser = !value;
                  });
                },
              ),
              const Expanded(
                child: Text(
                  'Asignar a varios usuarios para acomodar los productos',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          if (assignToOneUser)
            Container(
              
              child: DropdownButton<String>(
                hint: const Text("Seleccionar"),
                value: selectedUser,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedUser = newValue;
                  });
                },
                items: <String>['Usuario 1', 'Usuario 2', 'Usuario 3']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KitTrackingPage()),
                );
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

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'KIT No. 123456',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Fecha de creación: DD/MM/AAAA',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const Text(
            'Fecha de vencimiento: DD/MM/AAAA',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Column(
          children: [
            _buildProductItem(index),
            if (index < 2) const Divider(),
          ],
        );
      },
    );
  }

  Widget _buildProductItem(int index) {
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
                  children: const [
                    Text(
                      'Lorem ipsum',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '123456',
                      style: TextStyle(
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
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eleifend elit non nibh molestie maximus.',
            style: TextStyle(
              fontSize: 14,
              
            ),
          ),
          if (assignToMultipleUsers)
            Container(
              
              child: DropdownButton<String>(
                hint: const Text("Seleccionar"),
                value: selectedUsersForProducts[index],
                onChanged: (String? newValue) {
                  setState(() {
                    selectedUsersForProducts[index] = newValue;
                  });
                },
                items: <String>['Usuario 1', 'Usuario 2', 'Usuario 3']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
