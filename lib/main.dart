import 'package:flutter/material.dart';

import 'components/fondue_card.dart';
import 'theme/fondue_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce App',
      theme: FondueTheme.lightTheme,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-commerce Store'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // TODO: Implement cart functionality
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 6, // Example products
        itemBuilder: (context, index) {
          return FondueCard(
            title: 'Product ${index + 1}',
            price: '\$${(index + 1) * 10}.99',
            imageUrl: 'https://picsum.photos/200/300?random=$index',
            onTap: () {
              // TODO: Implement product details
            },
          );
        },
      ),
    );
  }
}
