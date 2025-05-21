import 'package:flutter/material.dart';

import 'fondue_button.dart';

class FondueSidebar extends StatelessWidget {
  final List<FondueSidebarItem> items;
  final int selectedIndex;
  final Function(int) onItemSelected;

  const FondueSidebar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          right: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Icon(
                  Icons.shopping_bag,
                  color: Theme.of(context).colorScheme.primary,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Text(
                  'E-Commerce',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final isSelected = index == selectedIndex;

                return ListTile(
                  selected: isSelected,
                  selectedTileColor: Theme.of(
                    context,
                  ).colorScheme.primary.withOpacity(0.1),
                  leading: Icon(
                    item.icon,
                    color:
                        isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,
                  ),
                  title: Text(
                    item.title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color:
                          isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurface,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  onTap: () => onItemSelected(index),
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: FondueButton(
              text: 'New Product',
              onPressed: () {
                // TODO: Implement new product
              },
              icon: Icons.add,
            ),
          ),
        ],
      ),
    );
  }
}

class FondueSidebarItem {
  final String title;
  final IconData icon;

  const FondueSidebarItem({required this.title, required this.icon});
}
