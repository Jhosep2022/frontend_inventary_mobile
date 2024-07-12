import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:frontend_inventary_mobile/views/registeredProductPage.dart';

class ProductScanPage extends StatelessWidget {
  final Function(String) onScanComplete;

  const ProductScanPage({super.key, required this.onScanComplete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ingresar pedidos',
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
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
                  'Escanear el código del producto',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () async {
                    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                      '#ff6666', 'Cancel', true, ScanMode.BARCODE);
                    if (barcodeScanRes != '-1') {
                      onScanComplete(barcodeScanRes);
                      Navigator.pop(context, barcodeScanRes);
                    }
                  },
                  child: const Icon(
                    Icons.qr_code_scanner,
                    size: 100,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Ingrese manualmente',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Código/nombre',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  textAlign: TextAlign.center,
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      onScanComplete(value);
                      Navigator.pop(context, value);
                    }
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => RegisteredProductPage(),
                    ),
                  );
                  },
                  child: Text('Submit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
