import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend_inventary_mobile/state/movements_state.dart';
import 'package:frontend_inventary_mobile/views/usersPage.dart';
import 'package:provider/provider.dart';
import 'package:frontend_inventary_mobile/components/footerComponent.dart';
import 'package:frontend_inventary_mobile/components/headerSettingsComponent.dart';

class New_UserPage extends StatelessWidget {
  const New_UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovementsState(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: HeaderSettingsComponent(
            title: 'Nuevo Usuario',
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
                const SizedBox(height: 16),
                _buildForm(context),
                const SizedBox(height: 16),
                _buildFilterSection(context),
                const SizedBox(height: 30),
                _buildSaveButton(context),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const FooterComponent(),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Usuario 2',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildDropdownButtonFormField('Seleccione el área a la que se integra'),
        const SizedBox(height: 16),
        _buildTextField('Nuevo usuario'),
        const SizedBox(height: 16),
        _buildDropdownButtonFormField('Seleccione el área a la que se integra'),
      ],
    );
  }
  Widget _buildDropdownButtonFormField(String labelText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
          icon: const Icon(Icons.arrow_drop_down_outlined, color: Colors.blue),
          items: ['Área 1', 'Área 2', 'Área 3']
              .map((area) => DropdownMenuItem<String>(
                    value: area,
                    child: Text(area),
                  ))
              .toList(),
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget _buildTextField(String labelText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        ),
      ],
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
            offset: Offset(0, 3),
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
                      'Seleccione acciones permitidas: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_drop_down_circle_outlined,
                          color: Colors.blue, size: 25),
                      onPressed: () {
                        context.read<MovementsState>().toggleFilterVisibility();
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

  Widget _buildSaveButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UsersPage()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
        ),
        child: const Text(
          'Guardar Cambios',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
