import 'package:flutter/material.dart';
import 'package:frontend_inventary_mobile/components/footerComponent.dart';
import 'package:frontend_inventary_mobile/components/headerComponent.dart';
import 'package:frontend_inventary_mobile/views/productScanPage.dart';

class ProductEntryPage extends StatefulWidget {
  const ProductEntryPage({super.key});

  @override
  _ProductEntryPageState createState() => _ProductEntryPageState();
}

class _ProductEntryPageState extends State<ProductEntryPage> {
  List<bool> isRegisteredList = List.generate(3, (index) => index == 0); // Inicialmente, solo el primer producto está registrado

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
              'Ingreso de productos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 16),
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
          _buildOrderSummary(),
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
                'Orden No. 123456',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 100),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Fecha de envío: DD/MM/AAAA',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const Text(
            'Empresa: Empresa S.A de C.V.',
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
      itemCount: isRegisteredList.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            _buildProductItem(index),
            if (index < isRegisteredList.length - 1) const Divider(),
          ],
        );
      },
    );
  }

  Widget _buildProductItem(int index) {
    bool isRegistered = isRegisteredList[index];

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
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    if (!isRegistered) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductScanPage(onScanComplete: (scanResult) {
                            setState(() {
                              isRegisteredList[index] = true; // Cambia el estado a "Registrado"
                            });
                          }),
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isRegistered ? const Color(0xFF3D8305) : Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isRegistered ? 'Registrado' : 'Registrar',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
        ],
      ),
    );
  }
}
