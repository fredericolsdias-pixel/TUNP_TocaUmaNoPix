import 'package:flutter/material.dart';

class RequestPage extends StatefulWidget {
  final String songName;

  const RequestPage({super.key, required this.songName});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final TextEditingController nameController = TextEditingController();

  int selectedTip = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(
        title: const Text('Pedido de Música'),
        backgroundColor: Colors.black,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text('Música:', style: TextStyle(color: Colors.grey)),

            Text(
              widget.songName,
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: nameController,

              decoration: const InputDecoration(
                labelText: 'Seu Nome',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Escolha a Gorjeta',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedTip = 10;
                    });
                  },
                  child: const Text('R\$10'),
                ),

                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedTip = 20;
                    });
                  },
                  child: const Text('R\$20'),
                ),

                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedTip = 50;
                    });
                  },
                  child: const Text('R\$50'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              'Gorjeta selecionada: R\$ $selectedTip',
              style: const TextStyle(color: Colors.amber),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Pedido enviado com sucesso!')),
                  );
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
