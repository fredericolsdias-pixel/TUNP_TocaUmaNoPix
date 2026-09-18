import 'package:flutter/material.dart';

import '../screens/request_page.dart';
import '../screens/queue_page.dart';
import '../screens/painel_cantor_page.dart';
import '../screens/login_cantor_page.dart';

class ClientPage extends StatelessWidget {
  const ClientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 24),
            color: const Color(0xFF111111),

            child: const Column(
              children: [
                Text(
                  "🎵 TUNP",
                  style: TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7C3AED),
                  ),
                ),

                SizedBox(height: 16),

                Text(
                  "Toca Uma No Pix",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),

                SizedBox(height: 20),

                Text(
                  "Escolha sua música favorita e coloque ela na fila do show.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(40),
            color: const Color(0xFF151515),

            child: Column(
              children: [
                const Text(
                  "🎵 Repertório da Noite",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 30),

                Wrap(
                  spacing: 10,

                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Todos"),
                    ),

                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Sertanejo"),
                    ),

                    ElevatedButton(onPressed: () {}, child: const Text("MPB")),

                    ElevatedButton(onPressed: () {}, child: const Text("Rock")),

                    ElevatedButton(onPressed: () {}, child: const Text("Pop")),

                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Samba"),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Card(
                  child: ListTile(
                    title: const Text("Evidências"),

                    subtitle: const Text("Chitãozinho & Xororó"),

                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const RequestPage(musica: "Evidências"),
                          ),
                        );
                      },

                      child: const Text("Pedir"),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                Card(
                  child: ListTile(
                    title: const Text("Boate Azul"),

                    subtitle: const Text("Bruno & Marrone"),

                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const RequestPage(musica: "Boate Azul"),
                          ),
                        );
                      },

                      child: const Text("Pedir"),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,

            children: [
              ElevatedButton(
                onPressed: () {},

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C3AED),

                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 18,
                  ),
                ),

                child: const Text("Ver Cardápio"),
              ),

              ElevatedButton(
                onPressed: () {},

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,

                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 18,
                  ),
                ),

                child: const Text("Como Funciona"),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginCantorPage()),
                  );
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC9922B),

                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 18,
                  ),
                ),

                child: const Text("Painel do Cantor"),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QueuePage()),
              );
            },

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,

              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
            ),

            child: const Text("Fila Ao Vivo"),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
