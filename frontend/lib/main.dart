import 'package:flutter/material.dart';

import 'pages/catalog_page.dart';
import 'pages/client_page.dart';
import 'pages/how_it_works_page.dart';
import 'screens/queue_page.dart';
import 'theme/app_theme.dart';
import 'widgets/public_layout.dart';

void main() {
  runApp(const TunpApp());
}

class TunpApp extends StatelessWidget {
  const TunpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TUNP',
      theme: AppTheme.theme,
      initialRoute: AppRoutes.inicio,
      routes: {
        AppRoutes.inicio: (_) => const ClientPage(),
        AppRoutes.cardapio: (_) => const CatalogPage(),
        AppRoutes.comoFunciona: (_) => const HowItWorksPage(),
        AppRoutes.fila: (_) => const QueuePage(),
      },
    );
  }
}