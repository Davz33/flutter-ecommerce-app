import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'components/fondue_card.dart';
import 'components/fondue_sidebar.dart';
import 'firebase_options.dart';
import 'models/product.dart';
import 'services/product_service.dart';
import 'theme/fondue_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
  final ProductService _productService = ProductService();

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
          return _buildMobileLayout();
        } else {
          return _buildDesktopLayout();
        }
      },
    );
  }

  Widget _buildMobileLayout() {
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
          IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {}),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildDesktopLayout() {
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

  Widget _buildBody() {
    return StreamBuilder<List<Product>>(
      stream: _productService.getProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final products = snapshot.data ?? [];

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
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return FondueCard(
                    title: product.title,
                    price: '\$${product.price.toStringAsFixed(2)}',
                    imageUrl: product.imageUrl,
                    onTap: () {
                      // TODO: Navigate to product details
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
