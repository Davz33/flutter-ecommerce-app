import 'package:flutter/material.dart';

import 'components/fondue_card.dart';
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
      title: 'E-commerce App',
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        if (isMobile) {
          // Mobile: Use Drawer
          return Scaffold(
            key: _scaffoldKey,
            drawer: Drawer(
              child: FondueSidebar(
                items: _sidebarItems,
                selectedIndex: _selectedIndex,
                onItemSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ),
            appBar: AppBar(
              title: Text(_sidebarItems[_selectedIndex].title),
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {},
                ),
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type to search...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
                ),
                Expanded(child: _buildBody()),
              ],
            ),
          );
        } else {
          // Desktop/Tablet: Sidebar
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
                          onPressed: () {},
                        ),
                      ],
                    ),
                    body: _buildBody(),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FondueCard(
            title: 'Welcome to our store',
            price: 'Browse our products',
            imageUrl: 'https://picsum.photos/800/200',
            onTap: () {},
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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.55,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return FondueCard(
                title: 'Product ${index + 1}',
                price: '\$${(index + 1) * 10}.99',
                imageUrl: 'https://picsum.photos/200/300?random=$index',
                onTap: () {},
              );
            },
          ),
        ],
      ),
    );
  }
}
