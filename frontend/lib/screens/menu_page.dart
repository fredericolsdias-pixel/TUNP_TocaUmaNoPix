import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(
        title: const Text('Cardápio Musical'),
        backgroundColor: Colors.black,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: Text('Evidências'),
              subtitle: Text('Chitãozinho & Xororó'),
              trailing: Text('R\$ 10'),
            ),
          ),

          Card(
            child: ListTile(
              title: Text('Tempo Perdido'),
              subtitle: Text('Legião Urbana'),
              trailing: Text('R\$ 20'),
            ),
          ),

          Card(
            child: ListTile(
              title: Text('Sinônimos'),
              subtitle: Text('Chitãozinho & Xororó'),
              trailing: Text('R\$ 15'),
            ),
          ),
        ],
      ),
    );
  }
}
