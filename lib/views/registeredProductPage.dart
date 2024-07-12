// registered_product_page.dart
import 'package:flutter/material.dart';
import 'package:frontend_inventary_mobile/views/orderRegistrationPage.dart';
import 'package:provider/provider.dart';
import 'package:frontend_inventary_mobile/components/headerComponent.dart';
import 'package:frontend_inventary_mobile/components/footerComponent.dart';
import 'package:frontend_inventary_mobile/state/registered_product_state.dart';

class RegisteredProductPage extends StatelessWidget {
  const RegisteredProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisteredProductState(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: HeaderComponent(),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'El producto ha sido registrado',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Icon(
                      Icons.check_circle_outline,
                      size: 100,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Proporcione la siguiente información:',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Consumer<RegisteredProductState>(
                      builder: (context, state, child) {
                        return Column(
                          children: [
                            RadioListTile<String>(
                              title: const Text('El producto se encuentra en buen estado'),
                              value: 'estado_bueno',
                              groupValue: state.selectedValue,
                              onChanged: (String? value) {
                                state.setSelectedValue(value);
                              },
                            ),
                            RadioListTile<String>(
                              title: const Text('El producto está completo'),
                              value: 'completo',
                              groupValue: state.selectedValue,
                              onChanged: (String? value) {
                                state.setSelectedValue(value);
                              },
                            ),
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Ingrese la cantidad total que recibió',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            RadioListTile<String>(
                              title: const Text('Lorem ipsum'),
                              value: 'lorem',
                              groupValue: state.selectedValue,
                              onChanged: (String? value) {
                                state.setSelectedValue(value);
                              },
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Agregar comentarios',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              maxLines: 4,
                              decoration: InputDecoration(
                                hintText: 'Lorem ipsum',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                        onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) => OrderRegistrationPage(),
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
                        'Continuar registrando productos',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
