import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_inventary_mobile/components/footerComponent.dart';
import 'package:frontend_inventary_mobile/components/headerSettingsComponent.dart';
import 'package:frontend_inventary_mobile/models/area.dart';
import 'package:frontend_inventary_mobile/models/producto.dart';
import 'package:frontend_inventary_mobile/provider/products_bloc/products_bloc.dart';
import 'package:frontend_inventary_mobile/provider/areas_bloc/areas_bloc.dart';
import 'package:frontend_inventary_mobile/provider/products_bloc/products_event.dart';
import 'package:frontend_inventary_mobile/provider/areas_bloc/areas_event.dart';
import 'package:frontend_inventary_mobile/provider/products_bloc/products_state.dart';
import 'package:frontend_inventary_mobile/provider/areas_bloc/areas_state.dart';
import 'package:frontend_inventary_mobile/views/newInventoryDetailPage.dart';

class NewInventaryPage extends StatefulWidget {
  const NewInventaryPage({super.key});

  @override
  _NewInventaryPageState createState() => _NewInventaryPageState();
}

class _NewInventaryPageState extends State<NewInventaryPage> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  int? _selectedAreaId;  // Cambiado a int para manejar el ID
  List<Producto> _selectedProducts = [];

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
                  'Ingrese los productos',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildProductSelector(),
                const SizedBox(height: 16),
                _buildSelectedProductsList(),
              ],
            ),
            const SizedBox(height: 16),
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
                  if (_selectedAreaId != null && _selectedProducts.isNotEmpty && _selectedDate != null && _selectedTime != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewInventoryDetailPage(
                          selectedProductIds: _selectedProducts.map((product) => product.id).toList(),
                          selectedAreaId: _selectedAreaId!,
                          selectedDate: '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                          selectedTime: _selectedTime!.format(context),
                        ),
                      ),
                    );
                  } else {
                    // Mostrar un mensaje si no se ha seleccionado un área, productos, fecha o tiempo
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Seleccione un área, productos, fecha y hora.'),
                      ),
                    );
                  }
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
                _selectedAreaId = value?.id;
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

  Widget _buildProductSelector() {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoading) {
          return const CircularProgressIndicator();
        } else if (state is ProductsLoaded) {
          return DropdownButtonHideUnderline(
            child: DropdownButtonFormField<Producto>(
              decoration: InputDecoration(
                labelText: 'Seleccione productos',
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
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
                      StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Checkbox(
                            value: _selectedProducts.contains(product),
                            onChanged: (bool? selected) {
                              setState(() {
                                if (selected == true) {
                                  _selectedProducts.add(product);
                                } else {
                                  _selectedProducts.remove(product);
                                }
                              });
                              // Actualizar la pantalla principal
                              this.setState(() {});
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                // No es necesario manejar cambios aquí, ya que se gestiona en los checkboxes.
              },
              dropdownColor: Colors.white,
              selectedItemBuilder: (context) {
                return state.products.map<Widget>((product) {
                  return Container();
                }).toList();
              },
            ),
          );
        } else if (state is ProductsError) {
          return Text('Error al cargar productos: ${state.message}');
        }
        return Container();
      },
    );
  }

  Widget _buildSelectedProductsList() {
    return Wrap(
      spacing: 8.0,
      children: _selectedProducts.map((product) {
        return Chip(
          label: Text(product.name),
          onDeleted: () {
            setState(() {
              _selectedProducts.remove(product);
            });
          },
        );
      }).toList(),
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
