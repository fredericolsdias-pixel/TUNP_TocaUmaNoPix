import 'package:flutter/material.dart';

import 'pages/client_page.dart';

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
      theme: ThemeData.dark(),
      home: const Scaffold(body: ClientPage()),
    );
  }
}
