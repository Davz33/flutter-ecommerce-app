import 'package:flutter/material.dart';

class FondueSidebarItem {
  final String title;
  final IconData icon;

  const FondueSidebarItem({required this.title, required this.icon});
}

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
      width: 240,
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'E-commerce Admin',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 32),
          ...items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isSelected = index == selectedIndex;

            return ListTile(
              leading: Icon(
                item.icon,
                color:
                    isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.6),
              ),
              title: Text(
                item.title,
                style: TextStyle(
                  color:
                      isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              selected: isSelected,
              onTap: () => onItemSelected(index),
            );
          }),
        ],
      ),
    );
  }
}
