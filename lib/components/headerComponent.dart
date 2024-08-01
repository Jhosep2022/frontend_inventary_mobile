import 'package:flutter/material.dart';
import 'package:frontend_inventary_mobile/views/loginPage.dart';

class HeaderComponent extends StatelessWidget {
  const HeaderComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            GestureDetector(
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPageContainer()),
              );
            },
            child: Image.asset(
              'assets/Logo.png',
              height: 40,
            ),
            ),
          IconButton(
            onPressed: (){}, 
            icon: const Icon(
              Icons.notifications,
              color: Colors.blue,
              size: 30, // Increase the size of the icon
            )
          )
        ],
      ),
    );
  }
}