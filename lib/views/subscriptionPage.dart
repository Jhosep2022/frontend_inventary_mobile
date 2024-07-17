import 'package:flutter/material.dart';
import 'package:frontend_inventary_mobile/components/footerComponent.dart';
import 'package:frontend_inventary_mobile/components/headerSettingsComponent.dart';
import 'package:frontend_inventary_mobile/components/subscriptionCard.dart';
class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: HeaderSettingsComponent(
          title: 'Suscripción',
          onBackButtonPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 2,
              ),
              child: const Text(
                'Ver planes',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.65,
                children: const [
                  SubscriptionCard(
                    icon: Icons.lock,
                    title: 'Lorem ipsum',
                    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  ),
                  SubscriptionCard(
                    icon: Icons.favorite,
                    title: 'Lorem ipsum',
                    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  ),
                  SubscriptionCard(
                    icon: Icons.star,
                    title: 'Lorem ipsum',
                    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  ),
                  SubscriptionCard(
                    icon: Icons.cloud,
                    title: 'Lorem ipsum',
                    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  ),
                  SubscriptionCard(
                    icon: Icons.inventory,
                    title: 'Lorem ipsum',
                    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  ),
                  SubscriptionCard(
                    icon: Icons.sentiment_satisfied_alt_outlined,
                    title: 'Lorem ipsum',
                    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const FooterComponent(),
    );
  }
}
