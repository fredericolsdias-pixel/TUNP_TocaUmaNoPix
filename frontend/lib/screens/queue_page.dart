import 'package:flutter/material.dart';

import '../pedidos.dart';

class QueuePage extends StatelessWidget {
  const QueuePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08061A),

      appBar: AppBar(
        title: const Text('Fila Ao Vivo'),
        backgroundColor: const Color(0xFF08061A),
      ),

      body: filaPedidos.isEmpty
          ? const Center(
              child: Text(
                'Nenhum pedido na fila',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: filaPedidos.length,

              itemBuilder: (context, index) {
                final pedido = filaPedidos[index];

                return Card(
                  color: const Color(0xFF161229),

                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF7C3AED),

                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),

                    title: Text(
                      pedido.nome,
                      style: const TextStyle(color: Colors.white),
                    ),

                    subtitle: Text(
                      '${pedido.musica} • R\$ ${pedido.gorjeta}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
