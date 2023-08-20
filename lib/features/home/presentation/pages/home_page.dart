import 'package:flutter/material.dart';
import 'package:widget_data_transfer_tutorial/features/search_filter/entity/search_filter_entity.dart';
import 'package:widget_data_transfer_tutorial/features/search_filter/presentation/pages/filter_page.dart';

/// Главная страница
class HomePage extends StatefulWidget {
  final SearchFilterEntity filter;

  const HomePage({Key? key, required this.filter}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Фильтр пользователя
  late SearchFilterEntity _userFilter;

  @override
  void initState() {
    super.initState();

    _userFilter = widget.filter;
  }

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
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _userFilter.categories
                  .map(
                    (e) => Chip(
                      label: Text(e.name),
                      backgroundColor: Colors.green[200],
                      shape: const StadiumBorder(),
                    ),
                  )
                  .toList(),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FilledButton(
                  onPressed: () => _goToFilterSettings(_userFilter),
                  child: const Text('Настроить фильтр'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Перейти на страницу настройки фильтра
  Future<void> _goToFilterSettings(SearchFilterEntity filter) async {
    final newFilter = await Navigator.of(context).push<SearchFilterEntity>(
      MaterialPageRoute(
        builder: (context) => FilterPage(
          filter: filter,
        ),
      ),
    );

    if (newFilter != null) {
      setState(() {
        _userFilter = newFilter;
      });
    }
  }
}
