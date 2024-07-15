import 'package:flutter/material.dart';
import 'package:frontend_inventary_mobile/views/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:frontend_inventary_mobile/views/loginPage.dart';
import 'package:frontend_inventary_mobile/components/footerComponent.dart';

class CombinedHeaderComponent extends StatelessWidget {
  final String title;
  final VoidCallback? onBackButtonPressed;

  const CombinedHeaderComponent({
    required this.title,
    this.onBackButtonPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Image.asset(
                    'assets/Logo.png',
                    height: 40,
                  ),
                ),
                IconButton(
                  onPressed: () {}, 
                  icon: const Icon(
                    Icons.notifications,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 0.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: onBackButtonPressed ?? () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 15),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold, 
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}