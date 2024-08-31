import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_inventary_mobile/components/footerComponent.dart';
import 'package:frontend_inventary_mobile/components/headerComponent.dart';
import 'package:frontend_inventary_mobile/provider/user_bloc/users_bloc.dart';
import 'package:frontend_inventary_mobile/provider/user_bloc/users_event.dart';
import 'package:frontend_inventary_mobile/provider/user_bloc/users_state.dart';
import 'package:frontend_inventary_mobile/views/kitTrackingPage.dart';

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
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(FetchUsers(1)); // Cambia '1' al id de la compañía apropiado
  }

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
              const SizedBox(width: 8), // Espacio añadido
              const Expanded(
                child: Text(
                  'Asignar a un solo usuario para acomodar los productos',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(width: 8), // Espacio añadido
              Checkbox(
                value: assignToMultipleUsers,
                onChanged: (bool? value) {
                  setState(() {
                    assignToMultipleUsers = value!;
                    assignToOneUser = !value;
                  });
                },
              ),
              const SizedBox(width: 8), // Espacio añadido
              const Expanded(
                child: Text(
                  'Asignar a varios usuarios para acomodar los productos',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          if (assignToOneUser) Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0), // Espacio añadido
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
                value: user.name,
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
          if (assignToMultipleUsers) Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0), // Espacio añadido
            child: _buildProductUserDropdown(index),
          ),
        ],
      ),
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
                value: user.name,
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
}
