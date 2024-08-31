import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_inventary_mobile/components/footerComponent.dart';
import 'package:frontend_inventary_mobile/components/headerSettingsComponent.dart';
import 'package:frontend_inventary_mobile/models/area.dart';
import 'package:frontend_inventary_mobile/models/producto.dart';
import 'package:frontend_inventary_mobile/views/newInventoryDetailPage.dart';
import 'package:frontend_inventary_mobile/provider/products_bloc/products_bloc.dart';
import 'package:frontend_inventary_mobile/provider/areas_bloc/areas_bloc.dart';
import 'package:frontend_inventary_mobile/provider/products_bloc/products_event.dart';
import 'package:frontend_inventary_mobile/provider/areas_bloc/areas_event.dart';
import 'package:frontend_inventary_mobile/provider/products_bloc/products_state.dart';
import 'package:frontend_inventary_mobile/provider/areas_bloc/areas_state.dart';

class NewInventaryPage extends StatefulWidget {
  const NewInventaryPage({super.key});

  @override
  _NewInventaryPageState createState() => _NewInventaryPageState();
}

class _NewInventaryPageState extends State<NewInventaryPage> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  String? _selectedArea;
  String? _selectedProduct;

  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(FetchProducts(1)); 
    context.read<AreasBloc>().add(FetchAreas(1)); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(95.0),
        child: HeaderSettingsComponent(
          title: 'Nuevo inventario',
          onBackButtonPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ingrese el área del producto',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildAreaDropdown(),
                const SizedBox(height: 16),
                const Text(
                  'Ingrese el producto',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildProductDropdown(),
                const SizedBox(height: 16),
              ],
            ),
            const Text(
              '*El área y productos seleccionados serán bloqueados del inventario hasta que se finalice la actividad',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Programar inventario',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildDateField(context),
            const SizedBox(height: 16),
            _buildTimeField(context),
            const SizedBox(height: 26),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewInventoryDetailPage(),
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
                  'Continuar',
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
      ),
      bottomNavigationBar: const FooterComponent(),
    );
  }

  Widget _buildAreaDropdown() {
    return BlocBuilder<AreasBloc, AreasState>(
      builder: (context, state) {
        if (state is AreasLoading) {
          return const CircularProgressIndicator();
        } else if (state is AreasLoaded) {
          return DropdownButtonFormField<Area>(
            decoration: InputDecoration(
              labelText: 'Seleccione un área',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 12.0,
              ),
            ),
            isExpanded: true,
            iconSize: 24, 
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
            items: state.areas.map((area) {
              return DropdownMenuItem<Area>(
                value: area,
                child: Text(
                  area.name,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedArea = value?.name;
              });
            },
          );
        } else if (state is AreasError) {
          return Text('Error al cargar áreas: ${state.message}');
        }
        return Container();
      },
    );
  }


  Widget _buildProductDropdown() {
  return BlocBuilder<ProductsBloc, ProductsState>(
    builder: (context, state) {
      if (state is ProductsLoading) {
        return const CircularProgressIndicator();
      } else if (state is ProductsLoaded) {
        print('Building product dropdown with products: ${state.products}');
        return DropdownButtonFormField<Producto>(
          decoration: InputDecoration(
            labelText: 'Seleccione un producto',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 12.0,
            ),
          ),
          isExpanded: true, 
          iconSize: 24, 
          style: const TextStyle(
            fontSize: 14, 
            color: Colors.black,
          ),
          items: state.products.map((product) {
            return DropdownMenuItem<Producto>(
              value: product,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8, 
                ),
                child: Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedProduct = value?.name;
            });
            print('Selected product: $_selectedProduct');
          },
        );
      } else if (state is ProductsError) {
        print('Error loading products: ${state.message}');
        return Text('Error al cargar productos: ${state.message}');
      }
      return Container();
    },
  );
}



  Widget _buildDateField(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Fecha',
        hintText: 'dd/mm/aaaa',
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today, color: Colors.blue),
          onPressed: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (picked != null && picked != _selectedDate) {
              setState(() {
                _selectedDate = picked;
              });
            }
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      controller: TextEditingController(
        text: _selectedDate != null
            ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
            : '',
      ),
    );
  }

  Widget _buildTimeField(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Hora',
        hintText: '00:00',
        suffixIcon: IconButton(
          icon: const Icon(Icons.access_time, color: Colors.blue),
          onPressed: () async {
            final TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (picked != null && picked != _selectedTime) {
              setState(() {
                _selectedTime = picked;
              });
            }
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      controller: TextEditingController(
        text: _selectedTime != null
            ? _selectedTime!.format(context)
            : '',
      ),
    );
  }
}
