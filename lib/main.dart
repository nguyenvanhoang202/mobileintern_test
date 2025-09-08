import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/search_screen.dart';
import 'viewmodel/search_viewmodel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SearchViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchScreen(), // Không cần truyền viewModel nữa
    );
  }
}
