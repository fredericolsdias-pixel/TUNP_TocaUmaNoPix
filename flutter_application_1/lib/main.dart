import 'package:flutter/material.dart';

void main() {
  runApp(const TunpApp());
}

class TunpApp extends StatelessWidget {
  const TunpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TUNP',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.music_note, size: 100, color: Colors.amber),

            const SizedBox(height: 20),

            const Text(
              'TUNP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Escolheu, pagou no Pix, sua música toca.',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),

            const SizedBox(height: 30),

            ElevatedButton(onPressed: () {}, child: const Text('Ver Cardápio')),
          ],
        ),
      ),
    );
  }
}
