import 'package:flutter/material.dart';

import 'components/fondue_button.dart';
import 'components/fondue_card.dart';
import 'components/fondue_input.dart';
import 'components/fondue_sidebar.dart';
import 'theme/fondue_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      theme: FondueTheme.lightTheme,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<FondueSidebarItem> _sidebarItems = const [
    FondueSidebarItem(title: 'Dashboard', icon: Icons.dashboard),
    FondueSidebarItem(title: 'Products', icon: Icons.inventory),
    FondueSidebarItem(title: 'Orders', icon: Icons.shopping_cart),
    FondueSidebarItem(title: 'Customers', icon: Icons.people),
    FondueSidebarItem(title: 'Analytics', icon: Icons.analytics),
    FondueSidebarItem(title: 'Settings', icon: Icons.settings),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          FondueSidebar(
            items: _sidebarItems,
            selectedIndex: _selectedIndex,
            onItemSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                title: Text(_sidebarItems[_selectedIndex].title),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      // TODO: Implement cart functionality
                    },
                  ),
                ],
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FondueCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome to our store',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          const SizedBox(height: 16),
                          FondueInput(
                            label: 'Search products',
                            hint: 'Type to search...',
                            prefix: const Icon(Icons.search),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Featured Products',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return FondueCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Image.network(
                                  'https://picsum.photos/200/300?random=$index',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Product ${index + 1}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                '\$${(index + 1) * 10}.99',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 12),
                              FondueButton(
                                text: 'Add to Cart',
                                onPressed: () {
                                  // TODO: Implement add to cart
                                },
                                icon: Icons.shopping_cart,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
