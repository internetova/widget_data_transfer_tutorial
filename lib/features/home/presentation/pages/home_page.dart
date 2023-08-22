import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_data_transfer_tutorial/features/search_filter/entity/search_filter_entity.dart';
import 'package:widget_data_transfer_tutorial/features/search_filter/presentation/pages/filter_page.dart';
import 'package:widget_data_transfer_tutorial/features/search_filter/providers/filter_provider.dart';

/// Главная страница
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная страница'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<FilterProvider>(
              builder: (_, filterProvider, __) {
                final savedCategories = filterProvider.filter.categories;

                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: savedCategories
                      .map(
                        (e) => Chip(
                          label: Text(e.name),
                          backgroundColor: Colors.green[200],
                          shape: const StadiumBorder(),
                        ),
                      )
                      .toList(),
                );
              },
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FilledButton(
                  onPressed: () => {
                    Navigator.of(context).push<SearchFilterEntity>(
                      MaterialPageRoute(
                        builder: (_) => const FilterPage(),
                      ),
                    )
                  },
                  child: const Text('Настроить фильтр'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
