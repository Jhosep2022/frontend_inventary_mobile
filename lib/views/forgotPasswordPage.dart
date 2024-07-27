import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo de burbujas
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/Bubbles.png',
              width: screenWidth,
              fit: BoxFit.cover,
            ),
          ),
          // Texto y logo que no se moverán
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const SizedBox(height: 16),
                Image.asset(
                  'assets/Logo.png',
                  height: 100,
                ),
              ],
            ),
          ),
          
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 400),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(19.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: -1,
                            blurRadius: 5,
                            offset: const Offset(0, -9),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Ingresa el correo electrónico que tienes vinculado con esta cuenta',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Correo',
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal: 16.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Te enviaremos un correo electrónico con un código para recuperar tu cuenta',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 50),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // Acción para recuperar contraseña
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1289D4),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: const Text(
                                'Continuar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () {
                              // Acción para ayuda adicional
                            },
                            child: const Text(
                              '¿No puedes restablecer la contraseña?',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
          ),
          // Botón de cierre
          Positioned(
            top:  40,
            right: 10,
            child: IconButton(
                icon: Icon(Icons.close, color: Color.fromARGB(255, 24, 158, 248), size: 36),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
