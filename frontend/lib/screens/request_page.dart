import 'package:flutter/material.dart';

import '../pedidos.dart';

class RequestPage extends StatefulWidget {
  final String musica;

  const RequestPage({super.key, required this.musica});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController mesaController = TextEditingController();
  final TextEditingController mensagemController = TextEditingController();

  int gorjeta = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08061A),

      appBar: AppBar(
        title: const Text('Pedido'),
        backgroundColor: const Color(0xFF08061A),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              widget.musica,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: nomeController,
              style: const TextStyle(color: Colors.white),

              decoration: const InputDecoration(
                labelText: 'Seu nome',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: mesaController,
              style: const TextStyle(color: Colors.white),

              decoration: const InputDecoration(
                labelText: 'Mesa',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: mensagemController,
              maxLines: 3,
              style: const TextStyle(color: Colors.white),

              decoration: const InputDecoration(
                labelText: 'Mensagem para o músico',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Escolha a gorjeta',
              style: TextStyle(color: Colors.white),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      gorjeta = 10;
                    });
                  },
                  child: const Text('R\$10'),
                ),

                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      gorjeta = 20;
                    });
                  },
                  child: const Text('R\$20'),
                ),

                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      gorjeta = 50;
                    });
                  },
                  child: const Text('R\$50'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              'Gorjeta: R\$ $gorjeta',
              style: const TextStyle(color: Colors.amber, fontSize: 18),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () {
                  filaPedidos.add(
                    Pedido(
                      nome: nomeController.text,
                      musica: widget.musica,
                      gorjeta: gorjeta,
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pedido adicionado à fila!')),
                  );

                  Navigator.pop(context);
                },

                child: const Text('Confirmar Pedido'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
