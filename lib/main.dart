import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_data_transfer_tutorial/features/home/presentation/pages/home_page.dart';
import 'package:widget_data_transfer_tutorial/features/search_filter/providers/filter_provider.dart';
import 'package:widget_data_transfer_tutorial/mock.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FilterProvider(MockData.searchFilter),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
